import 'package:flutter/material.dart';

// 세부정보 화면에는 다음이 표시되어야 합니다.
// - [ ] 영화의 포스터
// - [ ] 영화의 제목
// - [ ] 영화의 등급
// - [ ] 영화의 개요
// - [ ] 영화의 장르

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
