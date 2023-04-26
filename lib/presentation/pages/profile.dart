import 'package:appeal/main_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/lang.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}



class _ProfilePageState extends State<ProfilePage> {
  bool isSwitch = true;
  int? selectLang;
  late String currentOption;
  List<Lang> languages = [
    Lang("uz", true),
    Lang("ru", false),
    Lang("en", false),
  ];


   
  
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    setCurrentLangButton();
    for (var element in languages) {
      if(element.isActive!){
        currentOption = element.isActive.toString();
      }
    }
    return Consumer<MainProvider>(builder: (context, data, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Profile".tr()),
        ),
        body: Container(
          color: mainProvider.getThemeColor()
              ? Colors.black87
              : Colors.grey.shade200,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.92,
                decoration: BoxDecoration(
                  color: mainProvider.getThemeColor()
                      ? Colors.grey.withOpacity(0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                              backgroundColor: mainProvider.getThemeColor() ? Colors.grey.shade700 : Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 0,
                              children: [
                                RadioListTile(
                                  title: Text(
                                    "Uzbek",
                                    style: TextStyle(
                                      color: mainProvider.getThemeColor() ? Colors.white : Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  value: languages[0].isActive.toString(),
                                  groupValue: currentOption,
                                  onChanged: (value) {
                                    setState(() {
                                      currentOption = value.toString();
                                      context.setLocale(const Locale("uz", "UZ"));
                                      mainProvider.langChanged();
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile(
                                  title: Text(
                                    "Russian",
                                    style: TextStyle(
                                      color: mainProvider.getThemeColor()
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  value: languages[1].isActive.toString(),
                                  groupValue: currentOption,
                                  onChanged: (value) {
                                    setState(() {
                                      currentOption = value.toString();
                                      mainProvider.langChanged();
                                      context.setLocale(const Locale("ru", "RU"));
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile(
                                  title: Text(
                                    "English",
                                    style: TextStyle(
                                      color: mainProvider.getThemeColor()
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                  value: languages[2].isActive.toString(),
                                  groupValue: currentOption,
                                  onChanged: (value) {
                                    setState(() {
                                      currentOption = value.toString();
                                      mainProvider.langChanged();
                                      context.setLocale(const Locale("en", "US"));
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.language, color: Colors.white),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Language".tr(),
                          style: TextStyle(
                            fontSize: 20,
                            color: mainProvider.getThemeColor()
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.92,
                decoration: BoxDecoration(
                  color: mainProvider.getThemeColor()
                      ? Colors.grey.withOpacity(0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: mainProvider.getThemeColor()
                              ? const Icon(
                                  Icons.nightlight_sharp,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.sunny,
                                  color: Colors.white,
                                )),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        mainProvider.getThemeColor()
                            ? "Night mode".tr()
                            : "Light mode".tr(),
                        style: TextStyle(
                          fontSize: 20,
                          color: mainProvider.getThemeColor()
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Switch(
                          value: isSwitch,
                          onChanged: (value) {
                            setState(() {
                              isSwitch = value;
                              mainProvider.changeTheme();
                            });
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void setCurrentLangButton() {
    switch (context.locale.toString()) {
      case "uz_UZ":
        {
          for (var element in languages) {
            if (element.name == "uz") {
              element.isActive = true;
            } else {
              element.isActive = false;
            }
          }
        }
        break;
      case "ru_RU":
        {
          for (var element in languages) {
            if (element.name == "ru") {
              element.isActive = true;
            } else {
              element.isActive = false;
            }
          }
        }
        break;
      case "en_US":
        {
          for (var element in languages) {
            if (element.name == "en") {
              element.isActive = true;
            } else {
              element.isActive = false;
            }
          }
        }
        break;
    }
  }

  // Widget langBuild() {
  //   final mainProvider = Provider.of<MainProvider>(context, listen: false);
  //   setCurrentLangButton();
  //
  //   return Column(
  //     children: [
  //       ToggleButtons(
  //         isSelected: languages.map((e) => e.isActive!).toList(),
  //         direction: Axis.vertical,
  //         borderColor: Colors.transparent,
  //         fillColor: Colors.transparent,
  //         highlightColor: Colors.transparent,
  //         selectedBorderColor: Colors.transparent,
  //         onPressed: (int index) {
  //           setState(() {
  //             for (var element in languages) {
  //               element.isActive = false;
  //             }
  //             switch (index) {
  //               case 0:
  //                 {
  //                   context.setLocale(const Locale("uz", "UZ"));
  //                   mainProvider.langChanged();
  //                 }
  //                 break;
  //               case 1:
  //                 {
  //                   mainProvider.langChanged();
  //                   context.setLocale(const Locale("ru", "RU"));
  //                 }
  //                 break;
  //               case 2:
  //                 {
  //                   mainProvider.langChanged();
  //                   context.setLocale(const Locale("en", "US"));
  //                 }
  //                 break;
  //             }
  //             languages[index].isActive = true;
  //           });
  //         },
  //         children: [
  //           langButton(languages[0]),
  //           langButton(languages[1]),
  //           langButton(languages[2]),
  //         ],
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget langButton(Lang lang) {
  //   return Container(
  //     width: 40,
  //     height: 40,
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       color: lang.isActive! ? const Color(0xff206498) : Colors.white10,
  //     ),
  //     child: Center(
  //       child: Text(
  //         lang.name!,
  //         style: const TextStyle(
  //           color: Colors.white,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
