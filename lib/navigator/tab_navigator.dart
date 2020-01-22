import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/my_page.dart';
import '../pages/search_page.dart';
import '../pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  TabNavigator({Key key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[HomePage(), SearchPage(), TravelPage(), MyPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,    //去除动画效果
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index){
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _defaultColor,
            ),
            title: Text(
              '首页',
              style: TextStyle(
                  color: _currentIndex != 0 ? _defaultColor : _activeColor),
            ),
            activeIcon: Icon(
              Icons.home,
              color: _activeColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _defaultColor,
            ),
            title: Text(
              '搜索',
              style: TextStyle(
                  color: _currentIndex != 1 ? _defaultColor : _activeColor),
            ),
            activeIcon: Icon(
              Icons.search,
              color: _activeColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera,
              color: _defaultColor,
            ),
            title: Text(
              '旅拍',
              style: TextStyle(
                  color: _currentIndex != 2 ? _defaultColor : _activeColor),
            ),
            activeIcon: Icon(
              Icons.camera,
              color: _activeColor,
            ),
          ),BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: _defaultColor,
            ),
            title: Text(
              '我的',
              style: TextStyle(
                  color: _currentIndex != 3 ? _defaultColor : _activeColor),
            ),
            activeIcon: Icon(
              Icons.account_circle,
              color: _activeColor,
            ),
          )
        ],
      ),
    );
  }
}
