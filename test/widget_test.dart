// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:toonflix/movie/model/movie_model.dart';
import 'package:toonflix/movie/services/api_service.dart';

void main() {
  test("getPopularMovies api Test", () async {
    final movies = await ApiService.getMovies(type: popular);

    // for (var movie in movies) {
    //   print(movie.toString());
    //   print(movie.thumbUrl());
    // }

    expect(movies, isA<List<MovieModel>>());
    expect(movies.length, greaterThan(0));
  });

  test("getNowComingMovies api Test", () async {
    final movies = await ApiService.getMovies(type: nowPlaying);

    // for (var movie in movies) {
    //   print(movie.toString());
    //   print(movie.thumbUrl());
    // }

    expect(movies, isA<List<MovieModel>>());
    expect(movies.length, greaterThan(0));
  });

  test("getComingSoonMovies api Test", () async {
    final movies = await ApiService.getMovies(type: comingSoon);

    // for (var movie in movies) {
    //   print(movie.toString());
    //   print(movie.thumbUrl());
    // }

    expect(movies, isA<List<MovieModel>>());
    expect(movies.length, greaterThan(0));
  });

  test("get MovieDetailModel api test", () async {
    final movie = await ApiService.getMovieById(id: "976573");

    expect(movie.id, 976573);
    expect(movie.title, 'Elemental');
    expect(
      movie.genresToString(),
      'Animation, Comedy, Family, Fantasy, Romance',
    );
  });

  test("math number round test", () {
    expect((7.76 / 2).round(), 4);
  });
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
}
