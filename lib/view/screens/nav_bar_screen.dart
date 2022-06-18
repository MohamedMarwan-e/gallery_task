import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_task/controller/nav_bar_provider.dart';
import 'package:gallery_task/core/helper/colors.dart';
import 'package:gallery_task/view/screens/favorite_screen.dart';
import 'package:gallery_task/view/screens/home_screen.dart';
import 'package:gallery_task/view/screens/search_screen.dart';
import 'package:gallery_task/view/widgets/custom_text.dart';
import 'package:provider/provider.dart';


class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key? key}) : super(key: key);

  @override
  _NavBarScreenState createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {

  final List<Widget> _widgetOption = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    final ref = Provider.of<BottomNavigationProvider>(context);
    Future<bool> displayLogoutDialog(
        BuildContext context,
        String title,
        String body,
        ) async {
      return await showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
                title: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "Cairo",
                    fontSize: 13,
                  ),
                ),
                content: CustomText(text:body, fontSize: 13),
                actions: <Widget>[
                  CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child:  const CustomText(
                          text:"No",
                          fontSize: 13
                      )
                  ),
                  CupertinoButton(
                      onPressed: () {
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else if (Platform.isIOS) {
                          exit(0);
                        }
                      },
                      child: const CustomText(
                          text:"Yes",
                           fontSize: 13
                      )
                  )
                ]);
          }
      );

    }

    return  WillPopScope(
      onWillPop:() => displayLogoutDialog(context,"Close the application",""),
      child: Scaffold(
          body: _widgetOption.elementAt(ref.selectedIndex),
          bottomNavigationBar:Container(
            height: 49,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 2),
              ],
            ),
            child:  BottomNavigationBar(
              backgroundColor: MyColors.white,
              currentIndex: ref.selectedIndex,
              onTap: (index) {
                ref.onItemTapped(index);
              },
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: MyColors.primary,
              unselectedItemColor: MyColors.grey,
              selectedLabelStyle: const TextStyle(
                fontSize: 0,
              ),
              unselectedLabelStyle:  const TextStyle(
                fontSize: 0,
              ),

              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.home,size: 20),
                  label:'',
                ),
                BottomNavigationBarItem(

                    icon:Icon(FontAwesomeIcons.search,size: 19),
                    label: ''
                ),
                BottomNavigationBarItem(
                  icon:Icon(FontAwesomeIcons.heart,size: 20),
                  label: '',
                ),

              ],
            ),

          )),
    );
  }


}
