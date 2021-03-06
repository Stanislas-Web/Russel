import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ufm/screens/favoris.dart';
import 'package:ufm/screens/home.dart';
import 'package:ufm/screens/profil.dart';
import 'package:ufm/screens/recherche.dart';
import 'dart:io';
import 'package:toast/toast.dart';
import 'package:ufm/size_config.dart';

class RouteStack extends StatefulWidget {
  RouteStack({Key key, this.label}) : super(key: key);
  final String label;

  @override
  _RouteStackState createState() => _RouteStackState();
}

class _RouteStackState extends State<RouteStack> {
  int _selectedIndex = 0;
  PageController pageController = PageController();
  bool _tryAgain = false;
  bool connectState = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnection();
  }

  Future checkConnection() async {
    try {
      setState(() {
        _tryAgain = true;
      });
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        setState(() {
          connectState = true;
          setState(() {
            _tryAgain = false;
          });
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      setState(() {
        connectState = false;
        _tryAgain = false;
        // setState(() {
        //   _tryAgain = false;
        // });
      });
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _screens = [MyHomePage(), Profil(), Recherche(), Favoris()];

  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return connectState == true
        ? Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            body: PageView(
              controller: pageController,
              onPageChanged: _onPageChanged,
              children: _screens,
              physics: NeverScrollableScrollPhysics(),
            ),
            bottomNavigationBar:
                bottomNavigationBar(_selectedIndex, _onItemTapped))
        : _tryAgain == true
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: SpinKitRipple(
                    color: Color(0xFFFFEB3B),
                    size: 100,
                  ),
                ),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          checkConnection();
                          Toast.show(
                              "v??rifiez votre connexion internet ", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        },
                        child: Column(
                          children: [
                            Image(
                                image: AssetImage(
                                  'assets/images/pasconnection.png',
                                ),
                                width: getProportionateScreenWidth(100),
                                height: getProportionateScreenWidth(100)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(
                                  (20),
                                ),
                              ),
                              child: Text(
                                "R??seau mobile ou Wifi non d??tect??.Cliquez sur le Bouton pour Actualiser ",
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(17),
                                    fontWeight: FontWeight.w300),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenWidth(30),
                            ),
                            Container(
                              height: getProportionateScreenWidth(50),
                              width: getProportionateScreenWidth(200),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    getProportionateScreenWidth(30),
                                  ),
                                  border: Border.all(color: Colors.yellow)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Actualiser",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      // fontSize: getProportionateScreenWidth(10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}

Widget bottomNavigationBar(_selectedIndex, _onItemTapped) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(40),
      topLeft: Radius.circular(40),
    ),
    child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFFFEB3B),
        selectedItemColor: Color(0xFF262F56),
        unselectedItemColor: Color(0xFF262F56).withOpacity(.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: new Text('Home', style: TextStyle(color: Color(0xFF262F56))),
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              height: _selectedIndex == 0 ? 20.0 : 15,
              width: _selectedIndex == 0 ? 20.0 : 15,
              color: _selectedIndex == 0
                  ? Color(0xFF262F56)
                  : Color(0xFF262F56).withOpacity(.5),
            ),
          ),
          BottomNavigationBarItem(
            title:
                new Text('Profil', style: TextStyle(color: Color(0xFF262F56))),
            icon: SvgPicture.asset(
              'assets/icons/profil.svg',
              height: _selectedIndex == 1 ? 20.0 : 15,
              width: _selectedIndex == 1 ? 20.0 : 15,
              color: _selectedIndex == 1
                  ? Color(0xFF262F56)
                  : Color(0xFF262F56).withOpacity(.5),
            ),
          ),
          BottomNavigationBarItem(
            title: new Text('Recherche',
                style: TextStyle(color: Color(0xFF262F56))),
            icon: SvgPicture.asset(
              'assets/icons/recherche.svg',
              height: _selectedIndex == 2 ? 20.0 : 15,
              width: _selectedIndex == 2 ? 20.0 : 15,
              color: _selectedIndex == 2
                  ? Color(0xFF262F56)
                  : Color(0xFF262F56).withOpacity(.5),
            ),
          ),
          BottomNavigationBarItem(
            title:
                new Text('Favoris', style: TextStyle(color: Color(0xFF262F56))),
            icon: SvgPicture.asset(
              'assets/icons/heart-icon.svg',
              height: _selectedIndex == 3 ? 20.0 : 15,
              width: _selectedIndex == 3 ? 20.0 : 15,
              color: _selectedIndex == 3
                  ? Color(0xFF262F56)
                  : Color(0xFF262F56).withOpacity(.5),
            ),
          ),
        ]),
  );
}
