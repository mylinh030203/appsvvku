import 'package:flutter/material.dart';

class AvatarComponent extends StatelessWidget {
  final double size;
  final String imageUrl;

  const AvatarComponent({
    super.key,
    this.size = 60.0,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
