import 'package:appeal/model/appeal.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/database_helper.dart';
import '../../main_provider.dart';

class AddAppealPage extends StatefulWidget {
  const AddAppealPage({Key? key}) : super(key: key);

  @override
  State<AddAppealPage> createState() => _AddAppealPageState();
}

class _AddAppealPageState extends State<AddAppealPage> {

  final TextEditingController _phone = TextEditingController();
  final TextEditingController _districtName = TextEditingController();
  final TextEditingController _description = TextEditingController();

  DateTime now = DateTime.now();
  bool isAllowed = false;


  @override
  Widget build(BuildContext context) {
    _phone.text = "+998";
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Consumer<MainProvider>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Add Appeal".tr()),
        ),
        body: Container(
          width: double.infinity,
          color: mainProvider.getThemeColor()
              ? Colors.black87
              : Colors.grey.shade200,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                ListTile(
                    title: Text(
                      "Phone number:".tr(),
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: _phone,
                          keyboardType: TextInputType.phone,
                          minLines: 1,
                          cursorHeight: 24,
                          style: TextStyle(
                            fontSize: 22,
                            color: mainProvider.getThemeColor()
                                ? Colors.white
                                : Colors.black54,
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),
                      ),
                    )),
                ListTile(
                    title: Text(
                      "District:".tr(),
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: _districtName,
                          keyboardType: TextInputType.name,
                          minLines: 1,
                          cursorHeight: 24,
                          style: TextStyle(
                            fontSize: 22,
                            color: mainProvider.getThemeColor()
                                ? Colors.white
                                : Colors.black54,
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),
                      ),
                    )),
                ListTile(
                    title: Text(
                      "Description:".tr(),
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SizedBox(
                        height: 180,
                        child: TextField(
                          controller: _description,
                          keyboardType: TextInputType.text,
                          minLines: 4,
                          maxLines: null,
                          cursorHeight: 24,
                          style: TextStyle(
                            fontSize: 22,
                            color: mainProvider.getThemeColor()
                                ? Colors.white
                                : Colors.black54,
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 46),
                  ),
                  onPressed: () {
                    if(_phone.text.isNotEmpty && _description.text.isNotEmpty && _districtName.text.isNotEmpty){
                      createAppeal();
                      mainProvider.updateAppealList();
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Allow appeal".tr(),
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
  void createAppeal() async {
    AppealModel newAppeal = AppealModel(
        _phone.text,_districtName.text,"${now.day}.${now.month}.${now.year}",_description.text,0);
    await DatabaseHelper.instance.insert(newAppeal);
  }
}

