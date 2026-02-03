enum ThemeModel {
  light('light'),
  dark('dark');
  const ThemeModel(this.source);
  final String source;

  static ThemeModel? fromSource(String? source) {
    for (var theme in ThemeModel.values) {
      if (theme.source == source) {
        return theme;
      }
    }
    return null;
  }
}