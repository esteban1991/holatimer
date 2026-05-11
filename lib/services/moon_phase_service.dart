enum MoonPhase {
  newMoon('🌑'),
  waxingCrescent('🌒'),
  firstQuarter('🌓'),
  waxingGibbous('🌔'),
  fullMoon('🌕'),
  waningGibbous('🌖'),
  lastQuarter('🌗'),
  waningCrescent('🌘');

  const MoonPhase(this.emoji);
  final String emoji;

  String nameFor(String locale) => switch (locale) {
    'ja' => _ja,
    'zh' => _zh,
    'ko' => _ko,
    'it' => _it,
    'fr' => _fr,
    'de' => _de,
    'en' => _en,
    _ => _es,
  };

  String get _es => switch (this) {
    MoonPhase.newMoon => 'Luna nueva',
    MoonPhase.waxingCrescent => 'Luna creciente',
    MoonPhase.firstQuarter => 'Cuarto creciente',
    MoonPhase.waxingGibbous => 'Gibosa creciente',
    MoonPhase.fullMoon => 'Luna llena',
    MoonPhase.waningGibbous => 'Gibosa menguante',
    MoonPhase.lastQuarter => 'Cuarto menguante',
    MoonPhase.waningCrescent => 'Luna menguante',
  };

  String get _en => switch (this) {
    MoonPhase.newMoon => 'New Moon',
    MoonPhase.waxingCrescent => 'Waxing Crescent',
    MoonPhase.firstQuarter => 'First Quarter',
    MoonPhase.waxingGibbous => 'Waxing Gibbous',
    MoonPhase.fullMoon => 'Full Moon',
    MoonPhase.waningGibbous => 'Waning Gibbous',
    MoonPhase.lastQuarter => 'Last Quarter',
    MoonPhase.waningCrescent => 'Waning Crescent',
  };

  String get _ja => switch (this) {
    MoonPhase.newMoon => '新月',
    MoonPhase.waxingCrescent => '三日月',
    MoonPhase.firstQuarter => '上弦の月',
    MoonPhase.waxingGibbous => '十三夜月',
    MoonPhase.fullMoon => '満月',
    MoonPhase.waningGibbous => '十六夜',
    MoonPhase.lastQuarter => '下弦の月',
    MoonPhase.waningCrescent => '有明月',
  };

  String get _it => switch (this) {
    MoonPhase.newMoon => 'Luna nuova',
    MoonPhase.waxingCrescent => 'Luna crescente',
    MoonPhase.firstQuarter => 'Primo quarto',
    MoonPhase.waxingGibbous => 'Gibbosa crescente',
    MoonPhase.fullMoon => 'Luna piena',
    MoonPhase.waningGibbous => 'Gibbosa calante',
    MoonPhase.lastQuarter => 'Ultimo quarto',
    MoonPhase.waningCrescent => 'Luna calante',
  };

  String get _fr => switch (this) {
    MoonPhase.newMoon => 'Nouvelle lune',
    MoonPhase.waxingCrescent => 'Croissant montant',
    MoonPhase.firstQuarter => 'Premier quartier',
    MoonPhase.waxingGibbous => 'Gibbeuse croissante',
    MoonPhase.fullMoon => 'Pleine lune',
    MoonPhase.waningGibbous => 'Gibbeuse décroissante',
    MoonPhase.lastQuarter => 'Dernier quartier',
    MoonPhase.waningCrescent => 'Croissant décroissant',
  };

  String get _de => switch (this) {
    MoonPhase.newMoon => 'Neumond',
    MoonPhase.waxingCrescent => 'Zunehmende Sichel',
    MoonPhase.firstQuarter => 'Erstes Viertel',
    MoonPhase.waxingGibbous => 'Zunehmender Mond',
    MoonPhase.fullMoon => 'Vollmond',
    MoonPhase.waningGibbous => 'Abnehmender Mond',
    MoonPhase.lastQuarter => 'Letztes Viertel',
    MoonPhase.waningCrescent => 'Abnehmende Sichel',
  };

  String get _zh => switch (this) {
    MoonPhase.newMoon => '新月',
    MoonPhase.waxingCrescent => '蛾眉月',
    MoonPhase.firstQuarter => '上弦月',
    MoonPhase.waxingGibbous => '盈凸月',
    MoonPhase.fullMoon => '满月',
    MoonPhase.waningGibbous => '亏凸月',
    MoonPhase.lastQuarter => '下弦月',
    MoonPhase.waningCrescent => '残月',
  };

  String get _ko => switch (this) {
    MoonPhase.newMoon => '신월',
    MoonPhase.waxingCrescent => '초승달',
    MoonPhase.firstQuarter => '상현달',
    MoonPhase.waxingGibbous => '상현 보름',
    MoonPhase.fullMoon => '보름달',
    MoonPhase.waningGibbous => '하현 보름',
    MoonPhase.lastQuarter => '하현달',
    MoonPhase.waningCrescent => '그믐달',
  };
}

class MoonPhaseService {
  static const double _knownNewMoon = 2451550.1; // Jan 6, 2000 18:14 UTC
  static const double _synodicMonth = 29.53058867;

  static MoonPhase getPhase(DateTime date) {
    final age = _moonAge(date);
    if (age < 1.85) return MoonPhase.newMoon;
    if (age < 7.38) return MoonPhase.waxingCrescent;
    if (age < 11.07) return MoonPhase.firstQuarter;
    if (age < 14.77) return MoonPhase.waxingGibbous;
    if (age < 16.62) return MoonPhase.fullMoon;
    if (age < 22.15) return MoonPhase.waningGibbous;
    if (age < 25.84) return MoonPhase.lastQuarter;
    return MoonPhase.waningCrescent;
  }

  static double _moonAge(DateTime date) {
    final jd = _julianDay(date);
    return ((jd - _knownNewMoon) % _synodicMonth + _synodicMonth) % _synodicMonth;
  }

  static double _julianDay(DateTime date) {
    final y = date.year;
    final m = date.month;
    final d = date.day;
    final a = ((14 - m) / 12).floor();
    final yr = y + 4800 - a;
    final mo = m + 12 * a - 3;
    return d +
        ((153 * mo + 2) / 5).floor() +
        365 * yr +
        (yr / 4).floor() -
        (yr / 100).floor() +
        (yr / 400).floor() -
        32045.0;
  }
}
