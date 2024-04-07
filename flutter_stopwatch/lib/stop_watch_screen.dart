import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({Key? key}) : super(key: key);

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Timer? _timer;
  int _time = 0;
  bool _isRunning = false;

  final List<String> _lapTimes = [];

  void _clickButton() {
    _isRunning = !_isRunning;

    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  void _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }
  void _pause() {
    _timer?.cancel();
  }

  void _reset() {
    _isRunning = false;
    _timer?.cancel();
    _lapTimes.clear();
    _time = 0;
  }

  void _recordLapTime(String time) {
    _lapTimes.insert(0, '${_lapTimes.length + 1}등 $time');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int sec = _time ~/ 100;
    String hundredth = '${_time % 100}'.padLeft(2, '0');

    return Scaffold(
      backgroundColor: Color(0xff303134),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            const Text('Simple StopWatch ', style: TextStyle(color: Colors.white)),
            Icon(Icons.timer_outlined, color: Colors.white,)
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 120),
          Container(
            padding: EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Color(0xff202124),
              shape: BoxShape.circle,
              border: Border.all(color: Color(0x0ff28292a), width: 4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 16,
                ),
                Text(
                  '$sec',
                  style: const TextStyle(fontSize: 50, color: Colors.white),
                ),
                Text(
                  hundredth, style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            decoration: BoxDecoration(
                color: Color(0xff202124),
                borderRadius: BorderRadius.circular(16)
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300,
                maxHeight: 200,
              ),
              child: Scrollbar(
                child: ListView(
                  shrinkWrap: true,
                    reverse: true,
                    children: _lapTimes.map((e) =>
                        Center(
                            child: Text(e,
                                style: TextStyle(color: Colors.white)),
                            )
                        )
                        .toList()
                  ),
              ),
            ),
            ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.orange,
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
                child: const Icon(Icons.refresh),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _clickButton();
                  });
                },
                child: _isRunning
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
              ),
              FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  setState(() {
                    _recordLapTime('$sec.$hundredth');
                  });
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}
