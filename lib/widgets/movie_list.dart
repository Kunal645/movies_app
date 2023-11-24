import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/movies_model.dart';
import '../screens/second_screen.dart';
import '../utils/colors.dart';
import 'cached_image.dart';

class MovieList extends StatelessWidget {
  final MoviesModel movies;

  const MovieList({super.key, required this.movies});
  @override
  Widget build(BuildContext context) {
    return movies.results != null
        ? GridView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                mainAxisExtent: MediaQuery.of(context).size.height / 5),
            itemCount: movies.results!.length,
            itemBuilder: (context, index) {
              Results results = movies.results![index];
              return Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: white)),
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => SecondScreen(results));
                    },
                    child: Column(
                      children: [
                        results.backdropPath != null
                            ? cachedImage(
                                'https://image.tmdb.org/t/p/original${results.backdropPath.toString()}')
                            : Container(),
                        const Spacer(),
                        Text(
                          results.title.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: white),
                        ),
                      ],
                    ),
                  ));
            },
          )
        : const Text('No data');
  }
}
