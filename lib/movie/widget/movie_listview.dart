import 'package:flutter/material.dart';
import 'package:toonflix/movie/model/movie_model.dart';
import 'package:toonflix/movie/widget/movie_item.dart';

class MovieListview extends StatelessWidget {
  final String title;
  final Future<List<MovieModel>> movies;
  final bool isTopType;

  const MovieListview({
    required this.title,
    required this.movies,
    this.isTopType = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: isTopType ? 200 : 220,
            child: FutureBuilder(
                future: movies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var movie = snapshot.data![index];

                        return MovieItem(
                          listTitle: title,
                          movie: movie,
                          isTopType: isTopType,
                        );
                      },
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
