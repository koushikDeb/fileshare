
import 'package:fileshare/ui/folder.dart';
import 'package:fileshare/utils/navigate.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Item extends StatelessWidget {

  final String title;
  final String path;
  final Color color;
  final IconData icon;


  Item({
    required this.title,
    required this.path,
    required this.color,
    required this.icon,

  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigate.pushPage(
          context,
          Folder(title: title, path: path),
        );
      },
      contentPadding: EdgeInsets.only(right: 20),
      leading: Container(
        height: 40,
        width: 40,
        child: Center(
          child: Icon(icon, color: color),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title),
        ],
      ),
    );
  }
}
