import 'package:flutter/material.dart';
import 'package:movies_application/bottom_navigation/witch_page.dart';
import 'package:movies_application/model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ImagePage extends StatefulWidget {
  final Movie moviesData;

  const ImagePage({
    Key? key,
    required this.moviesData,
  }) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  String runtime = "";

//This is for minutes into hours and minutes
// vriable nameကြေငြာတဲ့place
  String durationToString(int runtime) {
    //hour to minut  ပြောင်းထားသည်
    var d = Duration(minutes: runtime);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')} hr : ${parts[1].padLeft(2, '0')} min';
  }

  @override
  void initState() {
    runtime = (durationToString(widget.moviesData.runtime));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                overflow: Overflow.visible,
                children: [
                SizedBox(
                  width: double.infinity,
                  height: 230,
                  child: Image.network(
                    widget.moviesData.backgroundImage,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                    top: 160,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Padding(padding: EdgeInsets.all(12)),
                            SizedBox(
                              width: 130,
                              height: 300,
                              child: Image.network(
                                  widget.moviesData.mediumCoverImage),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:200,
                                  child: Text(
                                    widget.moviesData.titleLong,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Container(
                                  //star review
                                  child: RatingBarIndicator(
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                    rating: widget.moviesData.rating,
                                    itemBuilder: (BuildContext context, index) =>
                                        const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                                Text(
                                  runtime,
                                  style: const TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )),
              ]),
              const SizedBox(height: 200,),
              Container(
                padding: const EdgeInsets.only(left: 12,right: 12),
                child: Text(
                  widget.moviesData.summary,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => const WitchPage())));
                    },
                    child: const Text('Watch Now')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
