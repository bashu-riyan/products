import 'package:flutter/cupertino.dart';

class CustomShapeClipper extends CustomClipper <Path>{
  @override
  Path getClip(Size size) {
    final  Path path =Path();

    path.lineTo(0.0, size.height);
    var firstEndpoint = Offset(size.width*.5, size.height - 28.0);
    var firstControlPoint = Offset(size.width*0.25,size.height - 50.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndpoint.dx, firstEndpoint.dy);
    var secondEndpoint = Offset(size.width ,size.height - 80.0);
    var secondControlPoint = Offset(size.width * .76, size.height - 10);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndpoint.dx, secondEndpoint.dy);



    path.lineTo(size.width,0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldCliper) => true;

}