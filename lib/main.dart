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
        BlocProvider(create: (context) => CounterCubit()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cubit 2 Cubit',
          home: HomePage()),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int incrementSize = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ColorCubit>().state.color,
      body: BlocListener<ColorCubit, ColorState>(
        listener: (context, state) {
          if (state.color == Colors.red) {
            incrementSize = 1;
          } else if (state.color == Colors.green) {
            incrementSize = 10;
          } else if (state.color == Colors.blue) {
            incrementSize = 100;
          } else if (state.color == Colors.black) {
            context.read<CounterCubit>().changeCounter(-100);
            incrementSize = -100;
          }
        },
        child: Center(
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
                    context.read<CounterCubit>().changeCounter(incrementSize);
                  },
                  child: Text(
                    'Increment counter',
                    style: TextStyle(fontSize: 24),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
