import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AgeCounter(),
      child: const MyApp(),
    ),
  );
}

class AgeCounter with ChangeNotifier {
  int age = 0;

  void increment() {
    age++;
    notifyListeners();
  }

  void decrement() {
    if (age > 0) {
      age--;
      notifyListeners();
    }
  }

  Color getBackgroundColor() {
    if (age <= 12) return Colors.lightBlue;
    if (age <= 19) return Colors.lightGreen;
    if (age <= 30) return Colors.yellow;
    if (age <= 50) return Colors.orange;
    return Colors.grey;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Counter',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AgeCounter>(
      builder: (context, ageCounter, child) => Scaffold(
        backgroundColor: ageCounter.getBackgroundColor(),
        appBar: AppBar(title: const Text('Age Counter')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'I am ${ageCounter.age} years old',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: ageCounter.increment,
                child: const Text('Increment Age'),
              ),
              ElevatedButton(
                onPressed: ageCounter.decrement,
                child: const Text('Decrement Age'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
