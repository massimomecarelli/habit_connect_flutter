import 'package:flutter/material.dart';
import 'package:habit_connect_flutter/login_page.dart';
import 'package:habit_connect_flutter/tutorial.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'tasks.dart';
import 'community.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'util/auth_page.dart';


/* nel main apriamo la box di hive così nelle altre classi dobbiamo solo
chiamarla con box e non riaprirla con openBox
 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // init the hive
  await Hive.initFlutter();
  // open a box
  var box = await Hive.openBox('taskbox');
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
// lista di widget che rappresentano le schermate, da assegnare poi agli item della bottom nav bar
    List<Widget> _buildScreens() {
      return [
        Tutorial(),
        Tasks(),
       // Community(),
        AuthPage(), // pagina che smista l'accesso a seconda se l'utente è loggato oppure no
      ];
    }
    // bottom nav bar persistente
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.question_mark),
          title: ("Tutorial"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.blueGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.blueGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.chat),
          title: ("Community"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.blueGrey,
        ),
      ];
    }
    // aggiungo uno screen controller persistente come la bottom nav bar
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 1);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
