import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  const IconWidget({Key? key, required this.color, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Icon(color: Colors.white, icon),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final image;
  final Name;
  final email;
  const ImageWidget(
      {Key? key, required this.Name, required this.image, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(image),
        radius: 50,
      ),
    );
  }
}
