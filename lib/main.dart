import 'package:cubit2cubit/cubits/color/color_cubit.dart';
import 'package:cubit2cubit/cubits/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ColorCubit(),
        ),
        BlocProvider(
            create: (context) =>
                CounterCubit(colorCubit: context.read<ColorCubit>())),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cubit 2 Cubit',
          home: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ColorCubit>().state.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.read<ColorCubit>().changeColor();
                },
                child: Text(
                  'Change color',
                  style: TextStyle(fontSize: 24),
                )),
            SizedBox(height: 30),
            Text(
              // '0',
              '${context.watch<CounterCubit>().state.counter}',
              style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  context.read<CounterCubit>().changeCounter();
                },
                child: Text(
                  'Increment counter',
                  style: TextStyle(fontSize: 24),
                )),
          ],
        ),
      ),
    );
  }
}
