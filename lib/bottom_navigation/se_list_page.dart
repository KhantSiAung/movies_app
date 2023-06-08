import 'package:flutter/material.dart';
import 'package:movies_application/bottom_navigation/detail_page.dart';
import 'package:movies_application/model.dart';
import 'package:movies_application/network.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SeeAllPage extends StatefulWidget {
  const SeeAllPage({Key? key}) : super(key: key);

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  NetworkCall networkCall = NetworkCall();
  @override
  void initStat() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text('Movies All'),
          centerTitle: true,
        ),
        backgroundColor: Colors.black87,
        body: FutureBuilder(
          future: networkCall.fetchMoviesData(page: 5),
          builder: ((context, AsyncSnapshot<MoviesData> asyncSnapshot) {
            print(asyncSnapshot.data);
            if (asyncSnapshot.hasData) {
              return SizedBox(
                  child: MasonryGridView.count(
                      //masonrygridview in flutter ရေးထားသည်
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      itemCount: asyncSnapshot.data!.data.movies.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: SizedBox(
                              width: 130,
                              height: 200,
                              child: Image.network(
                                asyncSnapshot
                                    .data!.data.movies[index].mediumCoverImage,
                                fit: BoxFit.fill,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => ImagePage(
                                      moviesData: asyncSnapshot
                                          .data!.data.movies[index]))));
                            },
                          ),
                        );
                      }));
            }
            return SizedBox(
              height: double.infinity,
              child: MasonryGridView.count(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => Shimmer.fromColors(
                      child: Container(
                          width: 200, height: 200, color: Colors.white),
                      baseColor: Colors.grey,
                      highlightColor: Colors.white),
                  itemCount: 10),
            );
          }),
        ));
  }
}
