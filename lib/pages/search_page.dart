//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:xiecheng/dao/search_dao.dart';
import 'package:xiecheng/model/sesarch_model.dart';
import 'package:xiecheng/widgets/search_bar.dart';
import 'package:xiecheng/widgets/webview.dart';

const SEARCH_URL =
    'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'curise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];

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
          _appBar(context),
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                  flex: 1,
                  child: ListView.builder(
                      itemCount: searchModel?.data?.length ?? 0,
                      itemBuilder: ((BuildContext context, int position) {
                        return _item(context, position);
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
    SearchDao.fetch(keyword, text).then((SearchModel model) {
      //只有当当前输入的内容和服务端返回的内容一致时才渲染
      setState(() {
        searchModel = model;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Widget _appBar(BuildContext context) {
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

  Widget _item(BuildContext context, int position) {
    if (searchModel == null || searchModel.data == null) {
      return null;
    }
    SearchItem item = searchModel.data[position];
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          WebView(url: item.url, title: '详情');
        }));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey)),
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(1),
              child: Image(
                height: 26,
                width: 26,
                image: AssetImage(_typeImage(item.type)),
              ),
            ),
            Column(
              children: <Widget>[
                Container(width: 300,child:Text('${item.word} ${item.districtname??''} ${item.zonename??''}')),
                Container(width: 300,child:Text('${item.price??''} ${item.type??''}'))
                // Container(width: 300, child: _title(item)),
                // Container(
                //   width: 300,
                //   child: _subTitle(item),
                //   margin: EdgeInsets.only(top: 5),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }

  _typeImage(String type) {
    if (type == null) return 'assets/images/type_travelgroup.png';
    String path = "travelgroup";
    for (final val in TYPES) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return "assets/images/type_${path}.png";
  }

  _title(SearchItem item) {
    if (item == null) {
      return null;
    }
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, searchModel.keyword));
    spans.add(TextSpan(
        text: ' ' + (item.districtname ?? '') + ' ' + (item.zonename ?? ''),
        style: TextStyle(fontSize: 12, color: Colors.grey)));
    return RichText(
      text: TextSpan(children: spans),
    );
  }

  //搜索副标题
  Widget _subTitle(SearchItem item) {
    if (item == null) return null;
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: item.price ?? '',
            style: TextStyle(fontSize: 16, color: Colors.orange)),
        TextSpan(
            text: ' ' + (item.type ?? ''),
            style: TextStyle(fontSize: 12, color: Colors.grey))
      ]),
    );
  }

  //关键字高亮处理
  List<TextSpan> _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) return spans;
    List<String> arr = word.split(keyword);
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    //'wordwoc'.split('w') -> [, ord, oc]
    int preIndex = 0;
    for (int i = 0; i < arr.length; i++) {
      if (i != 0) {
        //搜索关键字高亮忽略大小写
        preIndex = word.indexOf(keyword, preIndex);
        spans.add(TextSpan(
            text: word.substring(preIndex, preIndex + keyword.length),
            style: keywordStyle));
      }
      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
