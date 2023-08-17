// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'color_cubit.dart';

class ColorState {
  final Color color;

  ColorState(this.color);

  factory ColorState.initial() {
    return ColorState(Colors.red);
  }

  ColorState copyWith({
    Color? color,
  }) {
    return ColorState(
      color ?? this.color,
    );
  }

  @override
  String toString() => 'ColorState(color: $color)';
}
