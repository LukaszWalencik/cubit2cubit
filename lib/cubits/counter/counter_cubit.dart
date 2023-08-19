import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cubit2cubit/cubits/color/color_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  int incrementSize = 1;
  final ColorCubit colorCubit;
  late final StreamSubscription colorSubscription;
  CounterCubit(
    this.colorCubit,
    this.colorSubscription,
  ) : super(CounterState.initial()) {
    colorSubscription = colorCubit.stream.listen((ColorState colorState) {
      if (colorState.color == Colors.red) {
        incrementSize = 1;
      } else if (colorState == Colors.green) {
        incrementSize = 10;
      } else if (colorState == Colors.blue) {
        incrementSize = 100;
      } else if (colorState == Colors.black) {
        emit(state.copyWith(counter: state.counter - 100));
        incrementSize = -100;
      }
    });
  }

  void changeCounter() {
    emit(state.copyWith(counter: state.counter + incrementSize));
  }

  @override
  Future<void> close() {
    colorSubscription.cancel();
    return super.close();
  }
}
