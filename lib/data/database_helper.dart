import 'dart:io';
import 'package:appeal/model/appeal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../constants.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database? _db;

  DatabaseHelper._instance();


  final String tableName = "appeals";
  final String colId = 'id';
  final String colPhone = 'phone';
  final String colDistrict = 'district';
  final String colRequest = 'request';
  final String colDescription = 'description';
  final String colAllowed = 'allowed';

  Future<Database?> get db async {
    return _db ?? await _initDB();
  }

  Future<Database?> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = "${documentsDirectory.path}appeals.db";
    _db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE $tableName ("
              "$colId INTEGER PRIMARY KEY,"
              "$colPhone TEXT,"
              "$colDistrict TEXT,"
              "$colRequest TEXT,"
              "$colDescription TEXT,"
              "$colAllowed INTEGER"
              ")");
        });
    return _db;
  }


  Future<void> loadDB(context) async {
    List<AppealModel> listAppeal = [
      AppealModel("+998996036311", "Yunisobod tumani", "10.01.2023", "TATUni qayta rekonstruksiya qilish", 0),
      AppealModel("+998996036311", "Yunisobod tumani", "10.01.2023", "TATUni qayta rekonstruksiya qilish", 0),
      AppealModel("+998996036311", "Yunisobod tumani", "10.01.2023", "TATUni qayta rekonstruksiya qilish", 0),
      AppealModel("+998996036311", "Yunisobod tumani", "10.01.2023", "TATUni qayta rekonstruksiya qilish", 0),
      AppealModel("+998996036311", "Yunisobod tumani", "10.01.2023", "TATUni qayta rekonstruksiya qilish", 0),
    ];

    // String data =
    // await DefaultAssetBundle.of(context).loadString("assets/capitals.json");
    // final jsonResult = jsonDecode(data);
    //
    // List<Word> capitals = jsonResult.map<Word>((data) {
    //   return Word.fromJson(data);
    // }).toList();

    for (var appeal in listAppeal) {
      await insert(appeal);
    }
    saveState();
    print("DATABASE LOADED");
  }

  Future<void> saveState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constants.IS_DATABASE_INIT, true);
  }


  Future<AppealModel> insert(AppealModel appeal) async {
    final data = await db;
    appeal.id = await data?.insert(tableName, appeal.toMap());
    return appeal;
  }

  Future<List<Map<String, Object?>>?> getAppealMap() async {
    final data = await db;
    final List<Map<String, Object?>>? result = await data?.query(tableName);
    return result;
  }

  // Future<List<Map<String, Object?>>?> getAppealMap(
  //     {String? appeal, bool? allowed}) async {
  //   final data = await db;
  //   final List<Map<String, Object?>>? result;
  //   if (appeal == null) {
  //     result = await data?.query(tableName);
  //   } else {
  //     result = await data?.query(
  //       tableName,
  //       where: allowed! ? '$c LIKE ?' : '$colCountry LIKE ?',
  //       whereArgs: ["$appeal%"],
  //     );
  //   }
  //   return result;
  // }

  Future<List<AppealModel>> getAppeals() async {
    final List<Map<String, Object?>>? appealMap = await getAppealMap();
    final List<AppealModel> appeals = [];
    appealMap?.forEach((element) {
      appeals.add(AppealModel.fromMap(element));
    });
    return appeals;
  }

  Future<List<AppealModel>> getAppealsAllowed() async {
    final List<Map<String, Object?>>? appealMap = await getAppealMap();
    final List<AppealModel> appeals = [];
    appealMap?.forEach((element) {
      if(AppealModel.fromMap(element).allowed == 1){
        appeals.add(AppealModel.fromMap(element));
      }
    });
    return appeals;
  }

  Future<List<AppealModel>> getAppealsNotAllowed() async {
    final List<Map<String, Object?>>? appealMap = await getAppealMap();
    final List<AppealModel> appeals = [];
    appealMap?.forEach((element) {
      if(AppealModel.fromMap(element).allowed == 0){
        appeals.add(AppealModel.fromMap(element));
      }
    });
    return appeals;
  }



  Future<int?> update(AppealModel appeal) async {
    final data = await db;
    return await data?.update(tableName, appeal.toMap(),
        where: '$colId = ?', whereArgs: [appeal.id]);
  }

  Future<int?> delete(int appealId) async {
    final data = await db;
    return await data?.delete(
      tableName,
      where: '$colId = ?',
      whereArgs: [appealId],
    );
  }

  // Future<List<AppealModel>> getWordLike(String word, bool isCity) async {
  //   final List<Map<String, Object?>>? wordMap =
  //   await getAppealMap(word: word, isCity: isCity);
  //   final List<AppealModel> words = [];
  //   wordMap?.forEach((element) {
  //     words.add(Word.fromMap(element));
  //   });
  //   return words;
  // }
}
