import 'package:flutter/material.dart';
import 'package:dosparkles/actions/user_info_operate.dart';
import 'package:dosparkles/utils/colors.dart';

class SparklesDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(
              color: HexColor("#182465"),
              // image: DecorationImage(
              //     image: AssetImage(""),
              //     fit: BoxFit.cover)
            ),
          ),
          ListTile(
            leading: const Icon(Icons.money),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('storeselectionpage');
            },
          ),
          ListTile(
            leading: const Icon(Icons.money),
            title: Text('My Profile'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('storeselectionpage');
            },
          ),
          ListTile(
            leading: const Icon(Icons.money),
            title: Text('Inbox'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('storeselectionpage');
            },
          ),
          ListTile(
            leading: const Icon(Icons.money),
            title: Text('Setting'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('storeselectionpage');
            },
          ),
          ListTile(
            leading: const Icon(Icons.money),
            title: Text('Share'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('storeselectionpage');
            },
          ),
           ListTile(
            leading: const Icon(Icons.money),
            title: Text('Help and Support'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('storeselectionpage');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: HexColor("#d93731")),
            title: Text(
              'Log out',
              style: TextStyle(color: HexColor("#d93731")),
            ),
            onTap: () async {
              UserInfoOperate.whenLogout();

              await Navigator.of(context).pushReplacementNamed('startpage');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
