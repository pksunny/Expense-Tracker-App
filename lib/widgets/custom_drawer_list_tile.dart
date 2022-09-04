import 'package:flutter/material.dart';
import 'package:money_tracker_app/utils/txt_style.dart';

class CustomDrawerListTile extends StatefulWidget {
  CustomDrawerListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap
  });

  IconData icon;
  String title;
  void Function() onTap;

  @override
  State<CustomDrawerListTile> createState() => _CustomDrawerListTileState();
}

class _CustomDrawerListTileState extends State<CustomDrawerListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.icon, size: 25,),
      title: Text(widget.title, style: TxtStyle.headLineStyle3),
      onTap: widget.onTap,
    );
  }
}