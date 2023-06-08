

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_application/Screen%20page/splash_screen.dart';
import 'package:movies_application/bottom_navigation/download_page.dart';
import 'package:movies_application/bottom_navigation/history_page.dart';
import 'package:movies_application/bottom_navigation/home_page.dart';
import 'package:movies_application/login_list/login_page.dart';
import 'package:movies_application/bottom_navigation/witch_page.dart';
import 'package:movies_application/network.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreenPage(),
  ));
}

class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  NetworkCall networkCall = NetworkCall();

  @override
  void initState() {
    super.initState();
  }
int _currentIndex=0;
final tab=[
 const HomePage(),
  const WitchPage(),
  const DownloadPage(),
  const HistoryPage(),
];
void _onItemTab(int index){setState(() {
  _currentIndex=index;
});}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.black87,
        title: const Text(
          'Movies',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      //bodyထည့်ရန်..သတိ အရေးကြီးသည်...(မမေ့ရန်..)
      bottomNavigationBar: BottomNavigationBar(
       
        backgroundColor: Colors.black87,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
          BottomNavigationBarItem(
              icon: Icon(Icons.ondemand_video), label: 'Witch'),
          BottomNavigationBarItem(icon: Icon(Icons.get_app), label: 'Download'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
         currentIndex: _currentIndex,
        onTap: _onItemTab,
      ),
      body: tab[_currentIndex],
      
    );
  }
}
