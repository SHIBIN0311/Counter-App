import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ValueNotifier<int> counterNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    storeValue();
  }

  Future<void> storeValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    counterNotifier.value = preferences.getInt('counter') ?? 0;
  }

  Future<void> incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    counterNotifier.value++;
    await prefs.setInt('counter', counterNotifier.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 8.0,
            ),
            ValueListenableBuilder(
              valueListenable: counterNotifier,
              builder: (context, value, child) {
                return Text(
                  value.toString(),
                  style: const TextStyle(fontSize: 30),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
