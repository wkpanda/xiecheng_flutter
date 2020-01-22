import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'https://dimg04.c-ctrip.com/images/zg0s180000014rym6B157.jpg',
    'https://dimg04.c-ctrip.com/images/zg0q1b000001bt46tA9B9.jpg',
    'https://dimg04.c-ctrip.com/images/zg0q1b000001aoz7a2BA8.jpg',
    'https://dimg04.c-ctrip.com/images/zg0h1c000001d1kigEB29.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 197.28,
              child: Swiper(
                itemCount: _imageUrls.length,
                autoplay: true,
                itemBuilder: (BuildContext context,int index){
                  return Image.network(_imageUrls[index],fit: BoxFit.fill,);
                },
                pagination: SwiperPagination(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
