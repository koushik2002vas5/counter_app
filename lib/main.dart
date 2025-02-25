import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

void main() {
  setupWindow();
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MyApp(),
    ),
  );
}

const double windowWidth = 360;
const double windowHeight = 640;
void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Counter');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

/// [ChangeNotifier] is a class in flutter:foundation. [Counter] does
/// not depend on Provider.
class Counter with ChangeNotifier {
  int value = 0;
  void increment() {
    value += 1;
    notifyListeners();
  }

  void decrement() {
    if (value > 0) {
      value -= 1;
    }
    notifyListeners();
  }

  void setvalue(double val) {
    value = val.toInt();
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  Map<String, dynamic> _getAgeCategory(int age) {
    if (age <= 12) {
      return {
        'message': "You're a child!,Welcome to childhood fun!",
        'color': const Color.fromARGB(255, 135, 202, 233)
      };
    } else if (age <= 19) {
      return {
        'message': "Teenager time!,Embrace the chaos of teenage years!",
        'color': const Color.fromARGB(255, 158, 212, 95)
      };
    } else if (age <= 30) {
      return {
        'message': "You're a young adult!,Embrace the adventure of adulthood!",
        'color': const Color.fromARGB(255, 247, 238, 74)
      };
    } else if (age <= 50) {
      return {
        'message': "You're an adult now!,The prime of your life!",
        'color': const Color.fromARGB(255, 210, 152, 64)
      };
    } else {
      return {
        'message': "Golden years!,golden memories!",
        'color': const Color.fromARGB(255, 151, 150, 150)
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Counter>(
      builder: (context, counter, child) {
        var ageCategory = _getAgeCategory(counter.value);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Age Counter'),
            backgroundColor: Colors.lightBlueAccent,
          ),
          backgroundColor: ageCategory['color'],
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'I am ${counter.value} years old',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 10),
                Text(
                  ageCategory['message'],
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    var counter = context.read<Counter>();
                    counter.increment();
                  },
                  child: Text('Increase age'),
                ),
                ElevatedButton(
                  onPressed: () {
                    var counter = context.read<Counter>();
                    counter.decrement();
                  },
                  child: Text('Decrease age'),
                ),
                Slider(
                    min: 0,
                    max: 100,
                    value: context.read<Counter>().value.toDouble(),
                    onChanged: (double value) {
                      var counter = context.read<Counter>();
                      counter.setvalue(value);
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
