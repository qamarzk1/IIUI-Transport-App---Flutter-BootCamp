import 'package:flutter/material.dart';
import 'package:iiui_transport_app/view/Bus%20Details/bus_details.dart';
import 'package:iiui_transport_app/view/Profile%20Screen/profile_screen.dart';
import 'package:iiui_transport_app/view/Settings/settings.dart';
import 'package:iiui_transport_app/view/User%20List/userlist_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      const ProfileSceen(),
      const BusdetailsScreen(),
      const UserlistScreen(),
      const SettingsScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.person,
          color: Colors.white,
        ),
        inactiveIcon: const Icon(
          Icons.person,
          color: Colors.black45,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.bus_alert,
          color: Colors.white,
        ),
        inactiveIcon: const Icon(
          Icons.bus_alert,
          color: Colors.black45,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
        inactiveIcon: const Icon(
          Icons.chat,
          color: Colors.black45,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.switch_access_shortcut_outlined,
          color: Colors.white,
        ),
        inactiveIcon: const Icon(
          Icons.switch_access_shortcut_outlined,
          color: Colors.black45,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen(), //Array for screens.
      items: _navBarItem(),
      controller: controller,

      decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(1),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(115, 33, 34, 34),
              Color.fromRGBO(255, 255, 255, 0.349),
            ],
          )),
      navBarStyle: NavBarStyle.style6,
    );
  }
}
