import 'package:flutter/material.dart';
import 'package:toonflix/movie/widget/top_movie_listview.dart';

// Home 스크린은 아래와 같은 기능을 갖고있어야 합니다.
// - [ ] 가장 인기 있는 영화 목록이 표시되어야 합니다.
// - [ ] 극장에서 상영 중인 영화 목록이 표시되어야 합니다.
// - [ ] 곧 개봉할 영화 목록이 표시되어야 합니다.
// - [ ] movie를 탭하면 세부정보 화면으로 이동해야 합니다.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text("POMOTIMER"),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            MovieListview(
              title: "Popular Movies",
              isTopType: true,
            ),
            MovieListview(
              title: "Now in Cinemas",
            ),
            MovieListview(
              title: "Coming Soon",
            ),
          ],
        ),
      ),
    );
  }
}
