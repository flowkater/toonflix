import 'package:flutter/material.dart';
import 'package:toonflix/movie/model/movie_detail_model.dart';
import 'package:toonflix/movie/services/api_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

// 세부정보 화면에는 다음이 표시되어야 합니다.
// - [x] 영화의 포스터
// - [x] 영화의 제목
// - [x] 영화의 등급
// - [x] 영화의 개요
// - [x] 영화의 장르

class DetailScreen extends StatefulWidget {
  final int id;
  final String title, thumbUrl, listTitle;

  const DetailScreen({
    required this.id,
    required this.title,
    required this.listTitle,
    required this.thumbUrl,
    super.key,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movieDetail;

  @override
  void initState() {
    movieDetail = ApiService.getMovieById(id: widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: "${widget.id}#${widget.listTitle}",
          child: Image.network(
            widget.thumbUrl,
            opacity: const AlwaysStoppedAnimation(0.6),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leadingWidth: 150,
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'Back to list',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 36),
            child: FutureBuilder(
                future: movieDetail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var movie = snapshot.data!;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -1.5,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        makeStarRatings(movie.grade),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "${movie.minutesToString()} | ${movie.genresToString()}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const Text(
                          "Storyline",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            movie.overview,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await launchUrlString(movie.homepage);
                          },
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 24),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 64,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "Buy Ticket",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ],
    );
  }

  Widget makeStarRatings(int grade) {
    final rest = 5 - grade;

    return Row(
      children: [
        for (var i = 0; i < grade; i++)
          const Icon(Icons.star, color: Colors.yellow),
        for (var i = 0; i < rest; i++)
          Icon(
            Icons.star,
            color: Colors.white.withAlpha(80),
          ),
      ],
    );
  }
}
