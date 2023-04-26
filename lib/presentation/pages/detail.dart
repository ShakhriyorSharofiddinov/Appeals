import 'package:appeal/data/database_helper.dart';
import 'package:appeal/model/appeal.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main_provider.dart';

class DetailPage extends StatefulWidget {
  final AppealModel appeal;
  const DetailPage(this.appeal, {Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isAllowed = false;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Consumer<MainProvider>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: mainProvider.getThemeColor()
              ? Colors.black87
              : Colors.grey.shade200,
          elevation: 0,
          foregroundColor: mainProvider.getThemeColor()
              ? Colors.grey.shade200
              : Colors.black54,
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
                listTile("Phone number:".tr(), widget.appeal.phone.toString()),
                listTile("District:".tr(), widget.appeal.district.toString()),
                listTile("Description:".tr(),widget.appeal.description.toString()),
                listTile("Request:".tr(), widget.appeal.request.toString()),
                listTile("Allowed Condition:".tr(), isAllowed || widget.appeal.allowed == 1 ? "Accepted".tr() : "Acceptance is pending".tr() ),
                const SizedBox(height: 100,),
                (isAllowed || widget.appeal.allowed == 1) ? Container() : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 46)
                  ),
                  onPressed: ()async{
                    AppealModel newAppeal = AppealModel.withId(
                        widget.appeal.id,widget.appeal.phone,widget.appeal.district,widget.appeal.request,widget.appeal.description,1);
                    await DatabaseHelper.instance.update(newAppeal);
                    mainProvider.updateAppealList();
                    setState(() {
                      isAllowed = !isAllowed;
                    });
                  },
                  child: Text("Allow appeal".tr(), style: TextStyle(fontSize: 20),),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget listTile(String title, String subtitle) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.blue, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(14),
        child: Text(
          subtitle,
          style: TextStyle(
            color: mainProvider.getThemeColor() ? Colors.white : Colors.black54,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
