part of 'theme_builder_cubit.dart';

class ThemeBuilderState extends Equatable {
  const ThemeBuilderState({this.appTheme = .light});

  final ThemeModel appTheme;

  @override
  List<Object> get props => [appTheme];

  ThemeBuilderState copyWith({
    ThemeModel? appTheme,
  }) {
    return ThemeBuilderState(
      appTheme: appTheme ?? this.appTheme,
    );
  }
}
