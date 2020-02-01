import 'package:flutter/material.dart';
import 'package:xiecheng/widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('搜索')
      ),
       body:Column(
         children: <Widget>[
           SearchBar(
             hideLeft: true,
             defaultText: '哈哈',
             hint: '123',
             leftButtonClick: (){
               Navigator.pop(context);
             },
             onChanged: _onTextChanged,
           ),
         ],
       ),
     );
  }
  _onTextChanged(text){

  }
}