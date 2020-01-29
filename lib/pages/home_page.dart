import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:xiecheng/dao/home_dao.dart';
import 'package:xiecheng/model/common_model.dart';
import 'package:xiecheng/model/grid_nav_model.dart';
import 'dart:convert';

import 'package:xiecheng/model/home_model.dart';
import 'package:xiecheng/widgets/grid_nav.dart';
import 'package:xiecheng/widgets/local_nav.dart';

const APPBAR_SCROLL_OFFSET = 100;

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
  List<CommonModel> localNavList = [];
  GridNavModel gridNavModel;
  double appBarAlpha = 0; //自定义appbar的透明度

  @override
  void initState() { 
    super.initState();
    loadData();
  }

  _onScroll(offset) {
    double alpha = offset/APPBAR_SCROLL_OFFSET;
    if(alpha<0){
      alpha=0;
    }else if(alpha>1){
      alpha=1;
    }
    setState(() {
      appBarAlpha=alpha;
    });
    print(appBarAlpha);
  }

  loadData() async{
    // HomeDao.fetch().then((result){
    //   setState((){
    //     resultString = json.encode(result); //将result转换成string
    //   });
    // }).catchError((e){
    //   setState((){
    //     resultString = e.toString();
    //   });
    // });
    try{
      HomeModel model = await HomeDao.fetch();
      setState((){
          localNavList = model.localNavList; //将model转换成string
          gridNavModel = model.gridNav;
        });
    }catch (e){
      print(e);
    }
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffff2f2f2),
        body: Stack(
          children: <Widget>[
            MediaQuery.removePadding(
              //除去上方的padding
              removeTop: true,
              context: context,
              child: Center(
                child: NotificationListener(
                //监听滚动
                  onNotification: (ScrollNotification) {
                  if (ScrollNotification is ScrollUpdateNotification &&
                  ScrollNotification.depth == 0) {
                  //滚动并且是列表滚动时：
                  _onScroll(ScrollNotification.metrics.pixels);
                   }
                  },
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 197.28,
                        child: Swiper(
                          itemCount: _imageUrls.length,
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              _imageUrls[index],
                              fit: BoxFit.fill,
                            );
                          },
                          pagination: SwiperPagination(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                        child: LocalNav(
                        localNavList: localNavList,
                       ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7,0,7,4),
                        child:GridNav(gridNavModel: gridNavModel,)
                      )
                    ],
                  ),
                )),
            ),
            Opacity(
              opacity: appBarAlpha,
              child: Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Center(child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),),
              ),
            )
          ],
        )
    );
  }
}
