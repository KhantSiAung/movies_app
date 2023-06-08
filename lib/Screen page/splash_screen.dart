import 'package:flutter/material.dart';
import 'package:movies_application/bottom_navigation/home_page.dart';
import 'package:movies_application/login_list/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}
 class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      bool status = await readString();
      Navigator.pushAndRemoveUntil(
        context,
                    MaterialPageRoute(
                        builder: ((context) => status ? const HomePage() : const LoginPage())),
                    (route) => false);}
          );
      
    }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: 400,
            height: 600,
            child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl9LigqKKgn4nM0xDogsylIq7VS3QXjr238A&usqp=CAU")),
      ),
    );
  }


  Future<bool> readString() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    print("Is user logged in? $isLoggedIn");
    return isLoggedIn;
  }
 }
