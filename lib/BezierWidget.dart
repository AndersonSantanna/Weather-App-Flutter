import 'package:flutter/material.dart';

class BezierWidget extends StatelessWidget {
  String temp = "23";
  BezierWidget({this.temp});

  @override
  Widget build(BuildContext context) {
    print(temp);
    // TODO: implement build
    return ClipPath(
      clipper: ClipHome(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.5,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/raining.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // UnDraw(
            //   color: Colors.white,
            //   height: MediaQuery.of(context).size.height * 0.5,
            //   illustration: UnDrawIllustration.weather_app,
            //   placeholder: Text(
            //       "Illustration is loading..."), //optional, default is the CircularProgressIndicator().
            //   errorWidget: Icon(Icons.error_outline,
            //       color: Colors.red,
            //       size:
            //           50), //optional, default is the Text('Could not load illustration!').
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 50,
                      bottom: MediaQuery.of(context).size.height * 0.15),
                  child: Text(
                    temp,
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ClipHome extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * .97);
    var firstControlPoint =
        Offset(size.width / 3, size.height); //First control point
    var firstEndPoint =
        Offset(size.width / 1.5, size.height / 1.2); //endPonit on straight
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width * 1.25, size.height / 1.95); //Second control point
    var secondEndPoint =
        Offset(size.width, size.height / 0.9); //endPonit on straight
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width / 0.198, 0);
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
