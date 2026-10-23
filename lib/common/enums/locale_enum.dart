enum SupportLocale {
  vi('Tiếng Việt'),
  en('English');

  final String label;
  const SupportLocale(this.label);

  static SupportLocale fromCode(String? code) {
    return SupportLocale.values.firstWhere(
      (e) => e.name == code,
      orElse: () => SupportLocale.vi,
    );
  }
}
