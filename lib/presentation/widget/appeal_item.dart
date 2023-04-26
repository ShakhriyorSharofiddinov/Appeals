import 'package:appeal/model/appeal.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/database_helper.dart';
import '../../main_provider.dart';
import '../pages/detail.dart';

class AppealItem extends StatefulWidget {
  final AppealModel appeal;

  const AppealItem(this.appeal, {Key? key}) : super(key: key);

  @override
  State<AppealItem> createState() => _AppealItemState();
}

class _AppealItemState extends State<AppealItem> {

  final TextEditingController _phone = TextEditingController();
  final TextEditingController _districtName = TextEditingController();
  final TextEditingController _description = TextEditingController();
  DateTime now = DateTime.now();


  @override
  Widget build(BuildContext context) {

    _phone.text = widget.appeal.phone.toString();
    _districtName.text = widget.appeal.district.toString();
    _description.text = widget.appeal.description.toString();

    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Consumer<MainProvider>(builder: (context, data, child) {
      return Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          color: mainProvider.getThemeColor()
              ? Colors.grey.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: widget.appeal.allowed == 0
                              ? Colors.blue
                              : Colors.redAccent,
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        "#${widget.appeal.id}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                  PopupMenuButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text(
                            "Edit".tr(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {},
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text(
                            'Delete'.tr(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ];
                    },
                    onSelected: (String value) {
                      if (value == 'edit') {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor:  mainProvider.getThemeColor() ? Colors.grey.shade700 : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            actions: [
                              TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel".tr()),
                              ),
                              TextButton(
                                onPressed: ()async{
                                  AppealModel newAppeal = AppealModel.withId(
                                      widget.appeal.id,_phone.text,_districtName.text,"${now.day}.${now.month}.${now.year}",_description.text,widget.appeal.allowed);
                                  await DatabaseHelper.instance.update(newAppeal);
                                  mainProvider.updateAppealList();
                                  Navigator.pop(context);
                                },
                                child: Text("OK".tr()),
                              )
                            ],
                            content: SizedBox(
                              height: 300,
                              child: Column(
                                children: [

                                  ListTile(
                                      title: Text(
                                        "Phone number:".tr(),
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: SizedBox(
                                          height: 30,
                                          child: TextField(
                                            controller: _phone,
                                            keyboardType: TextInputType.phone,
                                            minLines: 1,
                                            style: TextStyle(
                                              fontSize: 14,
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
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: SizedBox(
                                          height: 30,
                                          child: TextField(
                                            controller: _districtName,
                                            keyboardType: TextInputType.name,
                                            minLines: 1,
                                            style: TextStyle(
                                              fontSize: 14,
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
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: SizedBox(
                                          height: 100,
                                          child: TextField(
                                            controller: _description,
                                            keyboardType: TextInputType.text,
                                            minLines: 4,
                                            maxLines: null,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: mainProvider.getThemeColor()
                                                  ? Colors.white
                                                  : Colors.black54,
                                            ),
                                            decoration: InputDecoration(
                                              border: const OutlineInputBorder(
                                              gapPadding: 0,
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
                                ],
                              ),
                            ),
                            ));
                      }
                      else if(value == "delete"){
                        deleteTask(context);
                      }
                    },
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getRow("Phone number:".tr(), widget.appeal.phone.toString()),
                      getRow("District:".tr(),
                          widget.appeal.district.toString()),
                      getRow("Description:".tr(),
                          widget.appeal.description.toString()),
                      getRow("Request:".tr(),
                          widget.appeal.request.toString())
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(30, 25),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailPage(widget.appeal)));
                  },
                  child: Text("Detail".tr()),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  void deleteTask(context)async{
    await DatabaseHelper.instance.delete(widget.appeal.id!);
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.updateAppealList();
  }


  Widget getRow(String title, String subtitle) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.blue, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 10),
            child: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: mainProvider.getThemeColor()
                    ? Colors.white
                    : Colors.black54,
                fontSize: 17,
              ),
            ),
          ),
        )
      ],
    );
  }
}
