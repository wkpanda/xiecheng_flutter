import 'package:flutter/material.dart';
import 'package:xiecheng/dao/search_dao.dart';
import 'package:xiecheng/model/sesarch_model.dart';
import 'package:xiecheng/widgets/search_bar.dart';

const SEARCH_URL =
    'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

class SearchPage extends StatefulWidget {
  SearchPage(
      {Key key,
      this.hideLeft,
      this.hint,
      this.keyword,
      this.searchUrl = SEARCH_URL})
      : super(key: key);
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel;
  String keyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('搜索')),
      body: Column(
        children: <Widget>[
          _appBar(),
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                  flex: 1,
                  child: ListView.builder(
                      itemCount: searchModel?.data?.length ?? 0,
                      itemBuilder: ((BuildContext context, int position) {
                        return _item(position);
                      }))))
        ],
      ),
    );
  }

  _onTextChanged(String text) {
    keyword = text;
    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    String url = widget.searchUrl + text;
    SearchDao.fetch(url, text).then((SearchModel model) {
      //只有当当前输入的内容和服务端返回的内容一致时才渲染
      if (model.keyword == keyword) {
        setState(() {
          searchModel = model;
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  _appBar() {
    return Column(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 30),
          height: 80,
          decoration: BoxDecoration(color: Colors.white),
          child: SearchBar(
            hideLeft: widget.hideLeft,
            defaultText: '北京',
            hint: '北京',
            leftButtonClick: () {
              Navigator.pop(context);
            },
            onChanged: _onTextChanged,
          ),
        ),
      )
    ]);
  }

  _item(int position) {
    if (searchModel == null || searchModel.data == null) {
      return null;
    }
    SearchItem item = searchModel.data[position];
    return Text(item.word);
  }
}
