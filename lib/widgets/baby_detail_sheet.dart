import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app_theme.dart';
import '../data/pregnancy_data.dart';
import '../models/event.dart';
import '../providers/locale_provider.dart';

void showBabyDetailSheet(BuildContext context, WeekInfo weekInfo, int week) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => BabyDetailSheet(weekInfo: weekInfo, week: week),
  );
}

class BabyDetailSheet extends ConsumerStatefulWidget {
  const BabyDetailSheet({super.key, required this.weekInfo, required this.week});
  final WeekInfo weekInfo;
  final int week;

  @override
  ConsumerState<BabyDetailSheet> createState() => _BabyDetailSheetState();
}

class _BabyDetailSheetState extends ConsumerState<BabyDetailSheet>
    with TickerProviderStateMixin {
  late AnimationController _enterCtrl;
  late AnimationController _pulseCtrl;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;
  late Animation<double> _slideAnim;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _enterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _scaleAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _enterCtrl, curve: Curves.elasticOut),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _enterCtrl, curve: const Interval(0.0, 0.4, curve: Curves.easeIn)),
    );
    _slideAnim = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _enterCtrl, curve: const Interval(0.2, 0.8, curve: Curves.easeOut)),
    );
    _pulseAnim = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );

    _enterCtrl.forward();
  }

  @override
  void dispose() {
    _enterCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  String _bodyDescription(String locale) {
    final w = widget.week;
    final descriptions = {
      'es': _bodyDescEs(w),
      'en': _bodyDescEn(w),
      'fr': _bodyDescFr(w),
      'de': _bodyDescDe(w),
      'it': _bodyDescIt(w),
      'ja': _bodyDescJa(w),
      'zh': _bodyDescZh(w),
      'ko': _bodyDescKo(w),
    };
    return descriptions[locale] ?? descriptions['en']!;
  }

  static String _bodyDescEs(int w) {
    if (w <= 7) return 'Forma de C diminuta. El corazón ya late. Cabeza y cola apenas distinguibles. No llega a 1 cm.';
    if (w <= 12) return 'Cabeza enorme en proporción al cuerpo. Nariz, boca y ojos formándose. Los dedos están separándose.';
    if (w <= 20) return 'Posición fetal con brazos y piernas doblados. Piel traslúcida rojiza. Puede chuparse el pulgar.';
    if (w <= 28) return 'Forma de bebé recognocible. Piel arrugada y cubierta de vérnix. Ojos pueden abrirse. Tiene cejas y cabello.';
    return 'Bebé casi listo. Piel suave y rosada, con pliegues de grasa. Posición de parto, cabeza abajo. Uñas y cabello completos.';
  }

  static String _bodyDescEn(int w) {
    if (w <= 7) return 'Tiny C-shape. Heart already beating. Head and tail barely distinguishable. Under 1 cm.';
    if (w <= 12) return 'Head huge relative to body. Nose, mouth and eyes forming. Fingers starting to separate.';
    if (w <= 20) return 'Fetal position with arms and legs folded. Translucent reddish skin. Can suck thumb.';
    if (w <= 28) return 'Recognizable baby form. Wrinkled skin covered in vernix. Eyes can open. Has eyebrows and hair.';
    return 'Baby almost ready. Smooth pink skin with fat folds. Head-down birthing position. Full nails and hair.';
  }

  static String _bodyDescFr(int w) {
    if (w <= 7) return 'Minuscule forme en C. Le cœur bat déjà. Tête et queue à peine distinguables. Moins de 1 cm.';
    if (w <= 12) return 'Tête énorme par rapport au corps. Nez, bouche et yeux en formation. Les doigts commencent à se séparer.';
    if (w <= 20) return 'Position fœtale avec bras et jambes repliés. Peau rougeâtre translucide. Peut sucer son pouce.';
    if (w <= 28) return 'Forme de bébé reconnaissable. Peau ridée couverte de vernix. Les yeux peuvent s\'ouvrir. A des sourcils et des cheveux.';
    return 'Bébé presque prêt. Peau douce et rose avec plis de graisse. Position tête en bas. Ongles et cheveux complets.';
  }

  static String _bodyDescDe(int w) {
    if (w <= 7) return 'Winzige C-Form. Das Herz schlägt bereits. Kopf und Schwanz kaum unterscheidbar. Unter 1 cm.';
    if (w <= 12) return 'Riesiger Kopf im Verhältnis zum Körper. Nase, Mund und Augen bilden sich. Finger beginnen sich zu trennen.';
    if (w <= 20) return 'Fötusposition mit angewinkelten Armen und Beinen. Rötliche durchscheinende Haut. Kann am Daumen lutschen.';
    if (w <= 28) return 'Erkennbare Babyform. Faltige mit Käseschmiere bedeckte Haut. Augen können sich öffnen. Hat Augenbrauen und Haare.';
    return 'Baby fast fertig. Weiche rosa Haut mit Fettfalten. Kopf unten Geburtsposition. Volle Nägel und Haare.';
  }

  static String _bodyDescIt(int w) {
    if (w <= 7) return 'Minuscola forma a C. Il cuore batte già. Testa e coda appena distinguibili. Meno di 1 cm.';
    if (w <= 12) return 'Testa enorme rispetto al corpo. Naso, bocca e occhi in formazione. Le dita iniziano a separarsi.';
    if (w <= 20) return 'Posizione fetale con braccia e gambe piegate. Pelle rossastra traslucida. Può succhiarsi il pollice.';
    if (w <= 28) return 'Forma di bambino riconoscibile. Pelle rugosa coperta di vernix. Gli occhi possono aprirsi. Ha sopracciglia e capelli.';
    return 'Bambino quasi pronto. Pelle morbida e rosa con pieghe di grasso. Posizione testa in giù. Unghie e capelli completi.';
  }

  static String _bodyDescJa(int w) {
    if (w <= 7) return '小さなC字型。心臓はすでに鼓動しています。頭と尾がわずかに区別できます。1cm未満。';
    if (w <= 12) return '体に比べて頭が非常に大きい。鼻・口・目が形成中。指が分離し始めています。';
    if (w <= 20) return '腕と脚を折り畳んだ胎児姿勢。赤みがかった半透明の皮膚。親指を吸えます。';
    if (w <= 28) return '赤ちゃんとわかる形に。胎脂に覆われた皮膚。目が開けます。眉毛と髪があります。';
    return 'もうすぐ準備完了。柔らかくピンクの肌、脂肪の皺あり。頭を下に向けた出産位置。爪と髪が完成。';
  }

  static String _bodyDescZh(int w) {
    if (w <= 7) return '微小的C形。心脏已经跳动。头部和尾部勉强可辨。不足1厘米。';
    if (w <= 12) return '头部相对于身体非常大。鼻子、嘴巴和眼睛正在形成。手指开始分离。';
    if (w <= 20) return '手臂和腿弯曲的胎儿姿势。半透明的红色皮肤。可以吸吮拇指。';
    if (w <= 28) return '可识别的宝宝形态。皮肤有皱纹并覆盖着胎脂。眼睛可以睁开。有眉毛和头发。';
    return '宝宝几乎准备好了。柔软粉嫩的皮肤，有脂肪褶皱。头朝下分娩姿势。指甲和头发完整。';
  }

  static String _bodyDescKo(int w) {
    if (w <= 7) return '작은 C자 형태. 심장이 이미 뛰고 있어요. 머리와 꼬리가 겨우 구분됩니다. 1cm 미만.';
    if (w <= 12) return '몸에 비해 머리가 매우 큽니다. 코, 입, 눈이 형성 중. 손가락이 분리되기 시작합니다.';
    if (w <= 20) return '팔과 다리를 접은 태아 자세. 반투명한 붉은 피부. 엄지손가락을 빨 수 있어요.';
    if (w <= 28) return '알아볼 수 있는 아기 형태. 태지로 덮인 주름진 피부. 눈을 뜰 수 있습니다. 눈썹과 머리카락이 있어요.';
    return '아기가 거의 준비됐어요. 부드럽고 분홍빛 피부에 지방 주름이 있습니다. 머리를 아래로 한 분만 자세. 손톱과 머리카락이 완성됐습니다.';
  }

  @override
  Widget build(BuildContext context) {
    final l = ref.watch(l10nProvider);
    final colors = AppTheme.colorsFor(EventType.pregnancy);
    final weekStr = l.locale == 'ja' || l.locale == 'zh' || l.locale == 'ko'
        ? '${l.weekLabel}${widget.week}週'
        : '${l.weekLabel} ${widget.week}';

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.88,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.96),
                colors.lighter.withValues(alpha: 0.97),
              ],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Drag handle
                Container(
                  margin: const EdgeInsets.only(top: 14, bottom: 4),
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.light,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 36),
                  child: Column(
                    children: [
                      // Baby illustration — animated entrance
                      FadeTransition(
                        opacity: _fadeAnim,
                        child: ScaleTransition(
                          scale: _scaleAnim,
                          child: AnimatedBuilder(
                            animation: _pulseAnim,
                            builder: (_, child) => Transform.scale(
                              scale: _pulseAnim.value,
                              child: child,
                            ),
                            child: _BabyIllustration(week: widget.week),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Week title
                      AnimatedBuilder(
                        animation: _slideAnim,
                        builder: (_, child) => Transform.translate(
                          offset: Offset(0, _slideAnim.value),
                          child: FadeTransition(opacity: _fadeAnim, child: child),
                        ),
                        child: Column(
                          children: [
                            Text(
                              weekStr,
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: colors.dark,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                              decoration: BoxDecoration(
                                color: colors.primary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${widget.weekInfo.fruitEmoji}  ${widget.weekInfo.fruitFor(l.locale)}',
                                style: TextStyle(
                                  color: colors.dark,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Size & weight chips
                      FadeTransition(
                        opacity: _fadeAnim,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _StatChip(
                              icon: '📏',
                              value: widget.weekInfo.size,
                              label: l.sizeLabel,
                              color: colors.primary,
                            ),
                            const SizedBox(width: 12),
                            _StatChip(
                              icon: '⚖️',
                              value: widget.weekInfo.weight,
                              label: l.weightLabel,
                              color: colors.primary,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Body shape description
                      FadeTransition(
                        opacity: _fadeAnim,
                        child: _InfoCard(
                          icon: '🫀',
                          title: l.babyShape,
                          content: _bodyDescription(l.locale),
                          color: colors,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Development this week
                      FadeTransition(
                        opacity: _fadeAnim,
                        child: _InfoCard(
                          icon: '✨',
                          title: l.thisWeek,
                          content: widget.weekInfo.developmentFor(l.locale),
                          color: colors,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Baby Illustration ────────────────────────────────────────────────────────

class _BabyIllustration extends StatelessWidget {
  const _BabyIllustration({required this.week});
  final int week;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 170,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-0.2, -0.3),
          colors: [
            AppTheme.pinkLight.withValues(alpha: 0.6),
            AppTheme.pinkLighter,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.pink.withValues(alpha: 0.28),
            blurRadius: 32,
            spreadRadius: 6,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            blurRadius: 8,
            spreadRadius: -4,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: CustomPaint(
        painter: _BabyShapePainter(week: week),
      ),
    );
  }
}

class _BabyShapePainter extends CustomPainter {
  const _BabyShapePainter({required this.week});
  final int week;

  int get _stage {
    if (week <= 7) return 1;
    if (week <= 12) return 2;
    if (week <= 20) return 3;
    if (week <= 28) return 4;
    return 5;
  }

  Paint get _bodyPaint => Paint()
    ..color = AppTheme.pinkDark.withValues(alpha: 0.72)
    ..style = PaintingStyle.fill;

  Paint get _limbPaint => Paint()
    ..color = AppTheme.pink.withValues(alpha: 0.52)
    ..style = PaintingStyle.fill;

  Paint get _highlightPaint => Paint()
    ..color = Colors.white.withValues(alpha: 0.35)
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    switch (_stage) {
      case 1: _drawEmbryo(canvas, cx, cy);
      case 2: _drawEarlyFetus(canvas, cx, cy);
      case 3: _drawMidFetus(canvas, cx, cy);
      case 4: _drawLateFetus(canvas, cx, cy);
      default: _drawNearTerm(canvas, cx, cy);
    }
  }

  // Stage 1 — tiny C-shape embryo (wk 4-7)
  void _drawEmbryo(Canvas canvas, double cx, double cy) {
    final path = Path();
    // C-curve: arc from top to bottom
    path.moveTo(cx + 10, cy - 20);
    path.cubicTo(cx + 28, cy - 20, cx + 28, cy + 20, cx + 10, cy + 20);
    path.cubicTo(cx + 2, cy + 20, cx - 4, cy + 14, cx - 4, cy + 6);
    path.cubicTo(cx - 4, cy - 2, cx - 2, cy - 8, cx + 4, cy - 14);
    path.close();
    canvas.drawPath(path, _bodyPaint);
    // head bump
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + 6, cy - 22), width: 18, height: 16),
      _bodyPaint,
    );
  }

  // Stage 2 — big head, tiny body (wk 8-12)
  void _drawEarlyFetus(Canvas canvas, double cx, double cy) {
    // Head (large)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy - 22), width: 52, height: 56),
      _bodyPaint,
    );
    // Highlight on head
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx - 10, cy - 32), width: 18, height: 14),
      _highlightPaint,
    );
    // Body (small, curved below)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + 4, cy + 22), width: 28, height: 26),
      _limbPaint,
    );
    // Tiny arm buds
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 14, cy + 18), width: 12, height: 8), _limbPaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + 18, cy + 18), width: 12, height: 8), _limbPaint);
  }

  // Stage 3 — fetal C-shape, more defined (wk 13-20)
  void _drawMidFetus(Canvas canvas, double cx, double cy) {
    // Head
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx - 6, cy - 34), width: 44, height: 48),
      _bodyPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx - 16, cy - 42), width: 16, height: 12),
      _highlightPaint,
    );
    // Neck
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + 4, cy - 10), width: 16, height: 14),
      _bodyPaint,
    );
    // Body/torso
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + 8, cy + 12), width: 30, height: 38),
      _bodyPaint,
    );
    // Arms (folded)
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 10, cy + 8), width: 14, height: 22), _limbPaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 16, cy + 20), width: 12, height: 10), _limbPaint);
    // Legs (curled)
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + 14, cy + 36), width: 22, height: 14), _limbPaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 2, cy + 44), width: 20, height: 12), _limbPaint);
  }

  // Stage 4 — developed fetal position (wk 21-28)
  void _drawLateFetus(Canvas canvas, double cx, double cy) {
    // Head
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx - 10, cy - 38), width: 42, height: 46),
      _bodyPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx - 20, cy - 46), width: 14, height: 12),
      _highlightPaint,
    );
    // Neck
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + 2, cy - 13), width: 18, height: 13),
      _bodyPaint,
    );
    // Torso
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + 6, cy + 10), width: 32, height: 42),
      _bodyPaint,
    );
    // Upper arm
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 14, cy + 4), width: 14, height: 26), _limbPaint);
    // Forearm & hand
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 10, cy + 24), width: 16, height: 10), _limbPaint);
    // Upper legs
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + 16, cy + 34), width: 20, height: 14), _limbPaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 4, cy + 42), width: 18, height: 13), _limbPaint);
    // Lower legs
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + 8, cy + 50), width: 16, height: 10), _limbPaint);
  }

  // Stage 5 — near-term, full baby (wk 29-42)
  void _drawNearTerm(Canvas canvas, double cx, double cy) {
    // Head (more round, less exaggerated)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx - 10, cy - 38), width: 44, height: 48),
      _bodyPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx - 20, cy - 48), width: 16, height: 12),
      _highlightPaint,
    );
    // Neck
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + 3, cy - 12), width: 20, height: 14),
      _bodyPaint,
    );
    // Torso (rounder with fat)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + 7, cy + 12), width: 36, height: 44),
      _bodyPaint,
    );
    // Upper arm
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 16, cy + 6), width: 16, height: 28), _limbPaint);
    // Forearm
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 10, cy + 26), width: 18, height: 12), _limbPaint);
    // Hand (tiny circle)
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 2, cy + 28), width: 10, height: 8), _limbPaint);
    // Upper legs
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + 18, cy + 36), width: 20, height: 16), _limbPaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 4, cy + 44), width: 20, height: 14), _limbPaint);
    // Lower legs
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + 10, cy + 52), width: 18, height: 12), _limbPaint);
    // Feet
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + 2, cy + 58), width: 14, height: 9), _limbPaint);
  }

  @override
  bool shouldRepaint(_BabyShapePainter old) => old.week != week;
}

// ─── Info Card ────────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
    required this.color,
  });
  final String icon;
  final String title;
  final String content;
  final EventTypeColors color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.light.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.light.withValues(alpha: 0.6), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: color.dark,
                  fontSize: 14,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stat Chip ────────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });
  final String icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.25), width: 1.5),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: color,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color.withValues(alpha: 0.65),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
