import 'package:appeal/model/appeal.dart';
import 'package:appeal/presentation/pages/add_appeal.dart';
import 'package:appeal/presentation/widget/appeal_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../data/database_helper.dart';
import '../../main_provider.dart';

class NewAppealsPage extends StatefulWidget {
  const NewAppealsPage({Key? key}) : super(key: key);

  @override
  State<NewAppealsPage> createState() => _NewAppealsPageState();
}

class _NewAppealsPageState extends State<NewAppealsPage> {
  @override
  void initState(){
    super.initState();
    loadDB();
  }

  Future<void> loadDB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoaded = prefs.getBool(Constants.IS_DATABASE_INIT) ?? false;

    if (!isLoaded) {
      await DatabaseHelper.instance.loadDB(context);
    }
    MainProvider().updateAppealList();
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Consumer<MainProvider>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("New Appeals".tr()),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AddAppealPage()));
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          color: mainProvider.getThemeColor()
              ? Colors.black87
              : Colors.grey.shade200,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FutureBuilder(
                future: DatabaseHelper.instance.getAppealsNotAllowed(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<AppealModel>> snapshot) {
                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 10),
                        itemBuilder: (context, index) {
                          return AppealItem(snapshot.data![index]);
                        },
                        itemCount: snapshot.data?.length ?? 0,
                      ) ;
                    })
          ),
        ),
      );
    });
  }
}
