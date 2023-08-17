import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Requirements
// - [x] 유저가 타이머의 시간(15, 20, 25, 30, 35)을 선택할 수 있어야 합니다.
// - [x] 유저가 타이머를 재설정 (리셋)할 수 있어야 합니다.
// - [ ] 유저가 한 사이클을 완료한 횟수를 카운트해야 합니다.
// - [ ] 유저가 4개의 사이클(1라운드)를 완료한 횟수를 카운트해야 합니다.
// - [ ] 각 라운드가 끝나면 사용자가 5분간 휴식을 취할 수 있어야 합니다.

// Design
// - [x] POMOTIMER
// - [x] Timer
// - [x] Selection Time
// - [x] Pause Button
// - [x] Reset Button
// - [x] Bottom
// - [ ] Layout detail

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const timeRange = [15 * 60, 20 * 60, 25 * 60, 30 * 60, 35 * 60];
  static const restTime = 5 * 60;
  double currentTimeRangeIndex = 2;

  int totalCycle = 4;
  int totalGoal = 12;

  int currentCycle = 0;
  int currentGoal = 0;

  int timeRangeIndex = 2;
  bool isRunning = false;
  int totalPomodoros = 0;

  bool isResting = false;

  late int totalSeconds = timeRange[timeRangeIndex];
  late Timer timer;

  final pageController = PageController(
    initialPage: 2,
    viewportFraction: 0.2,
  );

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        currentTimeRangeIndex = pageController.page!;
      });
    });
    super.initState();
  }

  bool isRunningOnTick() {
    return timeRange[timeRangeIndex] > totalSeconds;
  }

  void checkRound() {
    if (currentCycle == totalCycle - 1) {
      setState(() {
        currentCycle = 0;
        currentGoal = currentGoal + 1;
      });
    } else {
      setState(() {
        currentCycle = currentCycle + 1;
      });
    }
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      print("onTick == isRunning: $isRunning, isResting: $isResting");
      if (isResting) {
        setState(() {
          isRunning = false;
          isResting = false;
          totalSeconds = timeRange[timeRangeIndex];
        });
      } else if (isRunning) {
        setState(() {
          totalPomodoros = totalPomodoros + 1;
          isRunning = false;
          isResting = true;
          totalSeconds = restTime;
          checkRound();
        });
      }
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    print("onStartPressed == isRunning: $isRunning, isResting: $isResting");
    timer = Timer.periodic(
      const Duration(milliseconds: 5),
      onTick,
    );

    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();

    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();

    setState(() {
      isRunning = false;
      isResting = false;
      totalSeconds = timeRange[timeRangeIndex];
    });
  }

  void onSelectedTimeRange(int index) {
    if (isRunning) timer.cancel();

    setState(() {
      timeRangeIndex = index;
      totalSeconds = timeRange[timeRangeIndex];
      isRunning = false;
    });

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  List<String> _format(int seconds) {
    final duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7).split(":");
  }

  String minutesFormat(int seconds) {
    return _format(seconds)[0];
  }

  String secondsFormat(int seconds) {
    return _format(seconds)[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text("POMOTIMER"),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StackedCards(
                    time: minutesFormat(totalSeconds),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Text(
                      ":",
                      style: TextStyle(
                        color: Colors.white30,
                        fontSize: 58,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  StackedCards(
                    time: secondsFormat(totalSeconds),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              height: 45,
              child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                itemCount: timeRange.length,
                itemBuilder: ((context, index) {
                  final double diff = (index - currentTimeRangeIndex).abs();
                  final double halfLength = timeRange.length / 2;
                  final double opacity = 1 - (diff / halfLength).clamp(0, 1);

                  return Opacity(
                    opacity: opacity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: GestureDetector(
                        onTap: () => onSelectedTimeRange(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: index == timeRangeIndex
                                ? Theme.of(context).cardColor
                                : null,
                            border: Border.all(
                              color: Theme.of(context).cardColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              '${timeRange[index] ~/ 60}',
                              style: TextStyle(
                                color: index == timeRangeIndex
                                    ? Theme.of(context).colorScheme.background
                                    : Theme.of(context).cardColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 100,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    icon: Icon(
                      isRunning ? Icons.pause_circle : Icons.play_circle,
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isRunningOnTick() || isRunning
                        ? IconButton(
                            iconSize: 100,
                            color: Theme.of(context).cardColor,
                            onPressed: onResetPressed,
                            icon: const Icon(
                              Icons.restore,
                            ),
                          )
                        : const SizedBox(
                            height: 115,
                          ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomInfo(
                  currentNumber: currentCycle,
                  totalNumber: totalCycle,
                  title: "ROUND",
                ),
                BottomInfo(
                  currentNumber: currentGoal,
                  totalNumber: totalGoal,
                  title: "GOAL",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomInfo extends StatelessWidget {
  final int currentNumber;
  final int totalNumber;
  final String title;

  const BottomInfo({
    required this.currentNumber,
    required this.totalNumber,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$currentNumber/$totalNumber",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Colors.white.withAlpha(160),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class StackedCards extends StatelessWidget {
  final String time;

  const StackedCards({
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 10,
            child: Card(
              elevation: 0,
              color: Colors.white.withAlpha(120),
              child: const SizedBox(
                width: 110,
                height: 150,
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Card(
              elevation: 0,
              color: Colors.white.withAlpha(180),
              child: const SizedBox(
                width: 120,
                height: 150,
              ),
            ),
          ),
          Positioned(
            top: 10,
            child: Card(
              elevation: 0,
              color: Colors.white,
              child: SizedBox(
                width: 130,
                height: 150,
                child: Center(
                  child: Text(
                    time,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontSize: 68,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
