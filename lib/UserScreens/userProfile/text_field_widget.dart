import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icon.dart';

class MyTile extends StatelessWidget {
  String? text;
  IconData? leadIcon;
  IconData? traiIcon;

  Function()? ontap1;
  MyTile({Key? key, this.leadIcon, this.text, this.ontap1, this.traiIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ontap1!(),
      child: ListTile(
        // title: Text(titleText),

        // onTap: (){ontap();},
        trailing: Icon(traiIcon),
        iconColor: Color(0xFF880e4f),
        tileColor: Color(0xFFffeeff),
        title: Text(
          "$text",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(leadIcon),
      ),
    );
  }
}
