import 'package:flutter/material.dart';
import 'package:xiecheng/navigator/tab_navigator.dart';
//import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());
// const CITY_NAMES = {
//   '北京':['东城区','西城区','朝阳区','海淀区','顺义区'],
//   '上海':['黄浦区','徐汇区','静安区','虹口区'],
//   '广州':['越秀','海珠','荔湾'],
//   '深圳':['南山','福田','罗湖'],
//   '杭州':['上城区','下城区']
// };

// var cityNames=['北京','上海','深圳','广州','杭州','天津','重庆','太原','武汉','成都','拉萨'];

// class MyApp extends StatefulWidget {
//   MyApp({Key key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     _scrollController.addListener((){
//       if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
//         _loadData();
//       }
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final title = '列表展开与收起';

//     return MaterialApp(
//       title: title,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(title),
//         ),
//         body: RefreshIndicator(
//           //scrollDirection: Axis.horizontal,     //水平滚动
//           onRefresh: _handleRefresh,
//           child: ListView(
//             children: _buildList(),
//           ),
//         ),
//       ),
//     );
//   }

//   _loadData() async {
//     await Future.delayed(Duration(milliseconds: 200));
//     setState(() {
//       List<String> list = List<String>.from(cityNames);
//       list.addAll(cityNames);
//       cityNames = list;
//     });
//   }


//   Future<Null> _handleRefresh() async{
//     await Future.delayed(Duration(seconds:2));
//     setState(() {
//       cityNames = cityNames.reversed.toList();
//     });
//     return null;
//   }

//   List<Widget> _buildList(){
//     return cityNames.map((city)=>_item(city)).toList();
//   }

//   Widget _item(String city){
//     return Container(
//       height: 80,
//       margin: EdgeInsets.only(bottom: 5),
//       alignment: Alignment.center,
//       decoration: BoxDecoration(color: Colors.teal),
//       child: Text(
//         city,
//         style:TextStyle(color: Colors.white,fontSize:20),
//       ),
//     );
//   }

//   Widget _buildSub(String subCity){
//     return FractionallySizedBox(
//       widthFactor: 1,
//       child: Container(
//         height: 50,
//         margin: EdgeInsets.only(bottom: 5),
//         decoration: BoxDecoration(color: Colors.lightBlueAccent),
//         child: Text(subCity),
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final title = '列表展开与收起';

//     return MaterialApp(
//       title: title,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(title),
//         ),
//         body: ListView(
//           //scrollDirection: Axis.horizontal,     //水平滚动
//           children: _buildList(),
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildList(){
//     List<Widget> widgets = [];
//     CITY_NAMES.keys.forEach((key){
//       widgets.add(_item(key,CITY_NAMES[key]));
//     });
//     return widgets;
//   }

//   Widget _item(String city,List<String> subCities){
//     return ExpansionTile(
//       title: Text(
//         city,
//         style: TextStyle(color: Colors.black54,fontSize: 20),
//       ),children: subCities.map((subCity)=>_buildSub(subCity)).toList(),
//     );
//   }

//   Widget _buildSub(String subCity){
//     return FractionallySizedBox(
//       widthFactor: 1,
//       child: Container(
//         height: 50,
//         margin: EdgeInsets.only(bottom: 5),
//         decoration: BoxDecoration(color: Colors.lightBlueAccent),
//         child: Text(subCity),
//       ),
//     );
//   }
// }
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:TabNavigator(),
    );
  }
}

