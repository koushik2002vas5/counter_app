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

  void updateAge(double newAge) {
    age = newAge.toInt();
    notifyListeners();
  }

  Color getBackgroundColor() {
    if (age <= 12) return Colors.lightBlue;
    if (age <= 19) return Colors.lightGreen;
    if (age <= 30) return Colors.yellow;
    if (age <= 50) return Colors.orange;
    return Colors.grey;
  }

  String getMessage() {
    if (age <= 12) return "You're a child! Welcome to childhood fun!";
    if (age <= 19) return "Teenager time! Embrace the chaos of teenage years!";
    if (age <= 30)
      return "You're a young adult! Embrace the adventure of adulthood!";
    if (age <= 50) return "You're an adult now! The prime of your life!";
    return "Golden years! Golden memories!";
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
              SizedBox(height: 10),
              Text(
                ageCounter.getMessage(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 20),
              Slider(
                value: ageCounter.age.toDouble(),
                min: 0,
                max: 99,
                divisions: 99,
                label: ageCounter.age.toString(),
                onChanged: (value) => ageCounter.updateAge(value),
              ),
              SizedBox(height: 20),
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
