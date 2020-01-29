import 'package:flutter/material.dart';
import 'package:xiecheng/model/common_model.dart';
import 'package:xiecheng/model/grid_nav_model.dart';
import 'package:xiecheng/widgets/webview.dart';

//网格卡片
class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  const GridNav({Key key, @required this.gridNavModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,    //透明
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    if (gridNavModel.hotel != null) {
      items.add(_gridNavItem(context,gridNavModel.hotel,true));
    }
    if (gridNavModel.flight != null) {
      items.add(_gridNavItem(context,gridNavModel.flight,false));
    }
    if (gridNavModel.travel != null) {
      items.add(_gridNavItem(context,gridNavModel.travel,false));
    }
    return items;
  }

  Widget _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first) {
    //因为第一个与上边的导航有间距，所以要接收参数
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1,gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3,gridNavItem.item4));
    List<Widget> expandItems = [];
    items.forEach((item){
      expandItems.add(Expanded(child: item,flex: 1,));
    });
    Color startColor = gridNavItem.startColor!=null ? Color(int.parse('0xff${gridNavItem.startColor}')):Colors.white;
    Color endColor = gridNavItem.endColor !=null ? Color(int.parse('0xff${gridNavItem.endColor}')):Colors.white;
    return Container(
      height: 88,
      margin: first?null:EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        //线性渐变
        gradient: LinearGradient(
          colors: [startColor,endColor]
        )
      ),
      child: Row(
        children:expandItems,
      ),
    );
  }

  Widget _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Image.network(
              model.icon,
              fit: BoxFit.contain,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              margin: EdgeInsets.only(top:11),
              child: Text(model.title,
                style: TextStyle(fontSize: 14, color: Colors.white)),
            )
          ],
        ),
        model);
  } //MainItem

  _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context,topItem,true),
        ),
        Expanded(
          child: _item(context,bottomItem,false),
        )
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel item, bool first) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1, //宽度撑满父布局
      child: Container(
          decoration: BoxDecoration(
              border: Border(
            left: borderSide,
            bottom: first ? borderSide : BorderSide.none,
          )),
          child: _wrapGesture(
              context,
              Center(
                child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              item)),
    );
  }

  Widget _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      title: model.title,
                      url: model.url,
                      statusBarColor: model.statusBarColor,
                      hideAppBar: model.hideAppBar,
                    )));
      },
      child: widget,
    );
  }
}
