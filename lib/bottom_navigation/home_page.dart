import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_application/bottom_navigation/detail_page.dart';
import 'package:movies_application/bottom_navigation/se_list_page.dart';
import 'package:movies_application/login_list/login_page.dart';
import 'package:movies_application/network.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activePage = 1;
  late PageController _pageController;
  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgV1xfSwE2F6-e4oo1x1rP14t6cRAyjypkVg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5dtdtA7pyY-VLzj7GteZn_BH3vvR7hd_2uA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnjxGg4I0N6_za1Kdz6m36PT7eytmUkSV5bA&usqp=CAU",
  ];
  NetworkCall networkCall = NetworkCall();

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 8,
        height: 8,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff9BA4B5),
      appBar: AppBar(
        title: const Text("Movies"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xff8294C4),
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("isLoggedIn");
                await FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => const LoginPage())));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                        itemCount: images.length,
                        pageSnapping: true,
                        controller: _pageController,
                        onPageChanged: (page) {
                          setState(() {
                            activePage = page;
                          });
                        },
                        itemBuilder: (context, pagePosition) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            child: Image.network(
                              images[pagePosition],
                              fit: BoxFit.cover,
                            ),
                          );
                        }),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: indicators(images.length, activePage))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                        child: Text(
                      'Recent Watched',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )),
                    GestureDetector(
                      child: const SizedBox(
                          child: Text(
                        'See all',
                        style: TextStyle(color: Colors.black),
                      )),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const SeeAllPage())));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 280,
                child: FutureBuilder(
                  future: networkCall.fetchMoviesData(page: 2),
                  builder: ((context, AsyncSnapshot<MoviesData> asyncSnapshot) {
                    print(asyncSnapshot.data);
                    if (asyncSnapshot.hasData) {
                      return SizedBox(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: asyncSnapshot.data!.data.movies.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Padding(padding: EdgeInsets.all(12)),
                                  const SizedBox(width: 12),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      ImagePage(
                                                          moviesData:
                                                              asyncSnapshot
                                                                      .data!
                                                                      .data
                                                                      .movies[
                                                                  index]))));
                                        },
                                        child: Image.network(
                                          asyncSnapshot.data!.data.movies[index]
                                              .mediumCoverImage,
                                          fit: BoxFit.fill,
                                          width: 130,
                                          height: 170,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 130,
                                    child: Center(
                                      child: Text(
                                        asyncSnapshot
                                            .data!.data.movies[index].title,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                      );
                    }
                    //shimmer loading effect စမ်းရေးထားသည် ......
                    return SizedBox(
                      height: 100,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, index) => Shimmer.fromColors(
                              child: Container(
                                width: 150,
                                height: 100,
                                color: Colors.black,
                              ),
                              baseColor: Colors.grey,
                              highlightColor: Colors.white)),
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                                width: 10,
                              ),
                          itemCount: 10),
                    );
                  }),
                ),
              ),
              Padding(
                //title ရေးသည်...
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                        child: Text(
                      'My Favorites',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )),
                    GestureDetector(
                      child: const SizedBox(
                          child: Text(
                        'See all',
                        style: TextStyle(color: Colors.black),
                      )),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const SeeAllPage())));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 250,
                child: FutureBuilder(
                  future: networkCall.fetchMoviesData(page: 3),
                  builder: ((context, AsyncSnapshot<MoviesData> asyncSnapshot) {
                    print(asyncSnapshot.data);
                    if (asyncSnapshot.hasData) {
                      return SizedBox(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: asyncSnapshot.data!.data.movies.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  const Padding(padding: EdgeInsets.all(12)),
                                  const SizedBox(width: 12),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      ImagePage(
                                                          moviesData:
                                                              asyncSnapshot
                                                                      .data!
                                                                      .data
                                                                      .movies[
                                                                  index]))));
                                        },
                                        child: Image.network(
                                          asyncSnapshot.data!.data.movies[index]
                                              .mediumCoverImage,
                                          fit: BoxFit.fill,
                                          width: 130,
                                          height: 170,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 150,
                                    child: Center(
                                      child: Text(
                                        asyncSnapshot
                                            .data!.data.movies[index].title,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      );
                    }
                    return SizedBox(
                      height: 100,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Shimmer.fromColors(
                              child: Container(
                                  width: 150, height: 50, color: Colors.white),
                              baseColor: Colors.grey,
                              highlightColor: Colors.white),
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                                width: 10,
                              ),
                          itemCount: 10),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
