import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double dividerHeight;
  final double dividerThickness;
  final Color titleColor;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.dividerHeight = 2.0,
    this.dividerThickness = 2.0,
    this.titleColor = Colors.black26,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: titleColor),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(dividerHeight),
        child: Divider(
          height: dividerHeight,
          thickness: dividerThickness,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + dividerHeight);
}
