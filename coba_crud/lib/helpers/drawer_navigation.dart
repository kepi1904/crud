import 'package:coba_crud/screens/categories_screen.dart';
import 'package:coba_crud/screens/home_screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Drawer_navigation extends StatefulWidget {
  @override
  _Drawer_navigationState createState() => _Drawer_navigationState();
}

class _Drawer_navigationState extends State<Drawer_navigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: Container(
                child: Image.asset('images/yy.png'),
                // backgroundImage: Image.asset('images/yy.png'),
                // backgroundImage: NetworkImage(
                // 'https://cdn.vox-cdn.com/thumbor/gcVHhhZ4VwVswvbDPvI-RfQ7ECQ=/1400x1050/filters:format(png)/cdn.vox-cdn.com/uploads/chorus_asset/file/19721018/Tanjiro__Demon_Slayer_.png'),
              ),
              accountName: Text('Chevy Nanda'),
              accountEmail: Text('chevynanda@gmail.com'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriesScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
