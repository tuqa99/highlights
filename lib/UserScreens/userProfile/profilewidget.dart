import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;
  const ProfileWidget(
      {Key? key,
      this.isEdit = false,
      required this.imagePath,
      required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(bottom: 0, right: 4, child: buildEditIcon(color)),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 130,
          height: 130,
          child: InkWell(
            onTap: onClicked,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 2,
        child: buildCircle(
          color: Color(0xFF880e4f),
          all: 0,
          child: IconButton(
            onPressed: onClicked,
            color: Colors.white,
            icon: Icon(
              isEdit ? Icons.add_a_photo : Icons.edit,
              size: 20,
            ),
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          width: 40,
          height: 40,
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
