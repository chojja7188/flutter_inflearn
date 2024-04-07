import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double height;
  final double weight;
  const ResultScreen({super.key, required this.height, required this.weight});

  String _calcBmi(double bmi) {
    String result = '저체중';
    if (bmi >= 35) {
      result = '고도 비만';
    } else if (bmi >= 30) {
      result = '2단계 비만';
    } else if (bmi >= 25) {
      result = '1단계 비만';
    } else if (bmi >= 23) {
      result = '과체중';
    } else if (bmi >= 18.5) {
      result = '정상';
    }
    return result;
  }

  String _getBmiMessage(double bmi) {
    String message = '';
    if (bmi > 23) {
      message = 'BMI를 ${(bmi-23).toStringAsFixed(2)} 줄이셔야 정상 BMI가 되십니다.';
    } else if(bmi < 18.5) {
      message = 'BMI를 ${(18.5-bmi).toStringAsFixed(2)} 높이셔야 정상 BMI가 되십니다.';
    }
    return message;
  }

  Widget _buildIcon(double bmi) {
    Icon icon = const Icon(Icons.sentiment_dissatisfied, color: Colors.orange, size: 100,);
    if (bmi >= 23) {
      icon = Icon(Icons.sentiment_very_dissatisfied, color: Colors.red, size: 100,);
    } else if (bmi >= 18.5) {
      icon = Icon(Icons.sentiment_satisfied, color: Colors.green, size: 100,);
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    final double bmi = weight / ((height / 100.0) * (height / 100.0));

    return Scaffold(
      appBar: AppBar(
        title: Text('결과'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                _getBmiMessage(bmi),
              style: TextStyle(fontSize: 20),
            ),
            Text(
              _calcBmi(bmi),
              style: TextStyle(fontSize: 36),
            ),
            _buildIcon(bmi)
          ],
        ),
      ),
    );
  }
}
