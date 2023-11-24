import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/controller.dart';
import '../model/movies_model.dart';
import '../utils/colors.dart';
import '../utils/style.dart';
import '../widgets/cached_image.dart';

class SecondScreen extends StatefulWidget {
  final Results results;
  const SecondScreen(this.results, {super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Controller controller = Get.find();
  bool fav = false;
  @override
  void initState() {
    controller.favMoviesId.forEach((element) {
      if (element == widget.results.id.toString()) {
        fav = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height / 2,
                  width: size.width,
                  child: cachedImage(
                    'https://image.tmdb.org/t/p/original${widget.results.backdropPath.toString()}',
                    height: size.height / 2,
                    width: size.width,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      backgroundColor: Colors.transparent.withOpacity(0.8),
                      child: const BackButton()),
                ),
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent.withOpacity(0.8),
                      child: InkWell(
                        onTap: () {
                          controller.addFavourite(widget.results.id.toString());
                          controller.favMoviesId.add(widget.results.id.toString());
                          setState(() {
                            fav = true;
                          });
                        },
                        child: Icon(Icons.favorite, color: fav ? Colors.red : white, size: 25.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  right: 10.0,
                  bottom: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.results.title.toString(),
                        style: titleText,
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: orange,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(widget.results.voteAverage.toString(), style: descText),
                          const Spacer(),
                          Icon(Icons.date_range, color: white),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(widget.results.releaseDate.toString(), style: descText),
                          const Spacer(),
                          Text(
                            '(${widget.results.voteCount.toString()} votes)',
                            style: descText,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Text(
                        'Overview',
                        style: titleText,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(widget.results.overview.toString(),
                          style: descText, textAlign: TextAlign.justify),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
