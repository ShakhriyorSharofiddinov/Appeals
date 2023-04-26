import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/database_helper.dart';
import '../../main_provider.dart';
import '../../model/appeal.dart';
import '../widget/appeal_item.dart';

class HistoryAppealsPage extends StatefulWidget {
  const HistoryAppealsPage({Key? key}) : super(key: key);

  @override
  State<HistoryAppealsPage> createState() => _HistoryAppealsPageState();
}

class _HistoryAppealsPageState extends State<HistoryAppealsPage> {
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Consumer<MainProvider>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          title:  Text("History Appeals".tr()),
        ),
        body: Container(
          width: double.infinity,
          color: mainProvider.getThemeColor()
              ? Colors.black87
              : Colors.grey.shade200,
          child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FutureBuilder(
                  future: DatabaseHelper.instance.getAppealsAllowed(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List<AppealModel>> snapshot) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 10),
                      itemBuilder: (context, index) {
                        return AppealItem(snapshot.data![index]);
                      },
                      itemCount: snapshot.data?.length ?? 0,
                    );
                  })
          ),
        ),
      );
    });
  }
}
