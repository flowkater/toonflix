import 'dart:async';
import 'package:flutter/material.dart';

// Requirements
// - 유저가 타이머의 시간(15, 20, 25, 30, 35)을 선택할 수 있어야 합니다.
// - 유저가 타이머를 재설정 (리셋)할 수 있어야 합니다.
// - 유저가 한 사이클을 완료한 횟수를 카운트해야 합니다.
// - 유저가 4개의 사이클(1라운드)를 완료한 횟수를 카운트해야 합니다.
// - 각 라운드가 끝나면 사용자가 5분간 휴식을 취할 수 있어야 합니다.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const timeRange = [15 * 60, 20 * 60, 25 * 60, 30 * 60, 35 * 60];
  int timeRangeIndex = 2;
  bool isRunning = false;
  int totalPomodoros = 0;
  late int totalSeconds = timeRange[timeRangeIndex];
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = timeRange[timeRangeIndex];
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
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
      totalSeconds = timeRange[timeRangeIndex];
    });
  }

  void onSelectedTimeRange(int index) {
    timer.cancel();

    setState(() {
      timeRangeIndex = index;
      totalSeconds = timeRange[timeRangeIndex];
    });
  }

  String format(int seconds) {
    final duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'POMOTIMER',
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: timeRange.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () => onSelectedTimeRange(index),
                      child: Container(
                        width: 60,
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
                              fontWeight: FontWeight.w600,
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
              child: IconButton(
                iconSize: 120,
                color: Theme.of(context).cardColor,
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: Icon(
                  isRunning
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoro',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
