import 'package:appeal/presentation/pages/profile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main_provider.dart';
import 'history_appeals.dart';
import 'new_appeals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {




  int _selectPage = 0;
  List pages = const [
    NewAppealsPage(),
    HistoryAppealsPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Consumer<MainProvider>(builder: (context, data, child){
      return Scaffold(
        body: pages[_selectPage],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.library_add),label: "New Appeals".tr()),
            BottomNavigationBarItem(icon: Icon(Icons.library_books),label: "History Appeals".tr()),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: "Profile".tr()),
          ],
          currentIndex: _selectPage,
          unselectedItemColor: mainProvider.getThemeColor() ? Colors.white : Colors.black54,
          backgroundColor: mainProvider.getThemeColor() ? Colors.black.withOpacity(0.8) : Colors.white,
          elevation: 0,
          onTap: (index){
            setState(() {
              _selectPage = index;
            });
          },
        ),
      );
    });
  }
}
