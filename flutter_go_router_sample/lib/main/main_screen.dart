import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    load();
  }

  @override
  void dispose() {
    save();

    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('height', double.parse(_heightController.text));
    await prefs.setDouble('weight', double.parse(_weightController.text));
  }

  Future load() async {
    final prefs = await SharedPreferences.getInstance();
    final double? height = prefs.getDouble('height');
    final double? weight = prefs.getDouble('weight');

    if (height != null && weight != null) {
      _heightController.text = '$height';
      _weightController.text = '$weight';
    }
  }

  bool _valid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비만도 계산기'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(
                  label: Text('키'),
                  suffixText: 'cm',
                  border: OutlineInputBorder(),
                  hintText: '키'
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '키를 입력하세요';
                  }
                  if (double.tryParse(value) is !double) {
                    return '숫자를 입력하세요';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (_formKey.currentState?.validate() == true) {
                    setState(() {
                      _valid = true;
                    });
                  } else {
                    setState(() {
                      _valid = false;
                    });
                  }
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(
                    label: Text('몸무게'),
                    suffixText: 'kg',
                    border: OutlineInputBorder(),
                    hintText: '몸무게'
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '몸무게를 입력하세요';
                  }
                  if (double.tryParse(value) is !double) {
                    return '숫자를 입력하세요';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (_formKey.currentState?.validate() == true) {
                    setState(() {
                      _valid = true;
                    });
                  } else {
                    setState(() {
                      _valid = false;
                    });
                  }
                }
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: !_valid ? null : () {
                  if (_formKey.currentState?.validate() == false) {
                    return;
                  }

                  context.push(Uri(
                    path: '/result',
                    queryParameters: {
                      'height': _heightController.text,
                      'weight': _weightController.text
                    }
                  ).toString());
                },
                child: Text('결과'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
