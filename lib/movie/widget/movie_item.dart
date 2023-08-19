import 'package:flutter/material.dart';
import 'package:toonflix/movie/model/movie_model.dart';
import 'package:toonflix/movie/screen/detail_screen.dart';

class MovieItem extends StatelessWidget {
  final String listTitle;
  final MovieModel movie;
  final bool isTopType;

  const MovieItem({
    required this.listTitle,
    required this.movie,
    required this.isTopType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              id: movie.id,
              title: movie.title,
              listTitle: listTitle,
              thumbUrl: movie.thumbUrl(),
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: isTopType
          ? Hero(
              tag: "${movie.id}#$listTitle",
              child: Container(
                width: 280,
                margin: const EdgeInsets.only(right: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    movie.thumbUrl(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: "${movie.id}#$listTitle",
                  child: Container(
                    width: 134,
                    height: 140,
                    margin: const EdgeInsets.only(right: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        movie.thumbUrl(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 120,
                  child: Text(
                    movie.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
