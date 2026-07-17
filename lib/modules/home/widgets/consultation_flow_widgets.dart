import 'package:flutter/material.dart';

// Clipper for Ticket Side Cutouts
class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    // Left notch
    path.lineTo(0, size.height * 0.6 - 10);
    path.arcToPoint(
      Offset(0, size.height * 0.6 + 10),
      radius: const Radius.circular(10),
      clockwise: true,
    );
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    // Right notch
    path.lineTo(size.width, size.height * 0.6 + 10);
    path.arcToPoint(
      Offset(size.width, size.height * 0.6 - 10),
      radius: const Radius.circular(10),
      clockwise: true,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
