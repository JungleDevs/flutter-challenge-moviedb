import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/screens/search_screen.dart';
import 'package:moviedb/tabs/home_tab.dart';
import 'package:moviedb/tabs/movies_tab.dart';
import 'package:moviedb/tabs/ranking_tab.dart';
import 'package:moviedb/tabs/trends_tab.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<BottomNavigationBarItem> itemsNavigationBar = [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.emoji_events_outlined), label: 'Ranking'),
    BottomNavigationBarItem(icon: Icon(Icons.movie_outlined), label: 'Movies'),
    BottomNavigationBarItem(
        icon: Icon(Icons.trending_up_rounded), label: 'Trends'),
  ];

  int _currentTab = 1;

  List<Widget> _tabs = [HomeTab(), RankingTab(), MoviesTab(), TrendsTab()];

  List<String> titlesAppBar = ['Home', 'Top Movies', 'Movies', 'Trends'];

  late Stream subscritionConnectivity;

  @override
  void initState() {
    super.initState();

    subscritionConnectivity =
        Connectivity().onConnectivityChanged.asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titlesAppBar[_currentTab],
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            icon: Icon(CupertinoIcons.search),
            color: Color.fromARGB(255, 205, 206, 209),
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 7, 8, 24),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        backgroundColor: Color.fromARGB(255, 27, 28, 42),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Color.fromARGB(255, 0, 124, 255),
        unselectedItemColor: Colors.white,
        items: itemsNavigationBar,
        currentIndex: _currentTab,
      ),
      body: StreamBuilder(
          stream: subscritionConnectivity,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == ConnectivityResult.mobile ||
                  snapshot.data == ConnectivityResult.wifi) {
                return _tabs[_currentTab];
              } else {
                return Center(
                  child: Text('Não há conexão com a internet'),
                );
              }
            } else {
              return Center(
                child: RefreshProgressIndicator(),
              );
            }
          }),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    //subscritionConnectivity.cancel();
  }
}
