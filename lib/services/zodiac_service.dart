enum ChineseZodiac {
  rat('🐭'),
  ox('🐂'),
  tiger('🐯'),
  rabbit('🐰'),
  dragon('🐲'),
  snake('🐍'),
  horse('🐴'),
  goat('🐐'),
  monkey('🐒'),
  rooster('🐓'),
  dog('🐶'),
  pig('🐷');

  const ChineseZodiac(this.emoji);
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

  String descriptionFor(String locale) => switch (locale) {
    'ja' => _descJa,
    'zh' => _descZh,
    'ko' => _descKo,
    'it' => _descIt,
    'fr' => _descFr,
    'de' => _descDe,
    'en' => _descEn,
    _ => _descEs,
  };

  String get _descZh => switch (this) {
    ChineseZodiac.rat => '聪明机智，随机应变。总能找到创意解决方案。充满活力与魅力。',
    ChineseZodiac.ox => '勤劳可靠，默默奉献。是支撑所有人的力量。忠诚到底。',
    ChineseZodiac.tiger => '勇猛热情，自由奔放。精力旺盛，永不言败。',
    ChineseZodiac.rabbit => '温柔幸运，带来平静与和谐。优雅善良。',
    ChineseZodiac.dragon => '最具威望的生肖。魅力十足，志向远大，独一无二的能量。生来耀眼。',
    ChineseZodiac.snake => '睿智直觉，深谋远虑。深邃神秘，拥有深厚的内在智慧。',
    ChineseZodiac.horse => '精力充沛，独立自主。热爱自由与冒险。活泼爱社交。',
    ChineseZodiac.goat => '富有创造力，心地善良。具有艺术气质，欣赏美好事物。',
    ChineseZodiac.monkey => '聪慧活泼，学什么都快。机智幽默，充满趣味。',
    ChineseZodiac.rooster => '有条不紊，守时守信。尽职尽责，细心认真。',
    ChineseZodiac.dog => '最忠诚的生肖。诚实可靠，保护所爱。永远在身边的朋友。',
    ChineseZodiac.pig => '慷慨善良，福缘深厚。爱情运佳，诚实受人爱戴。',
  };

  String get _descKo => switch (this) {
    ChineseZodiac.rat => '영리하고 적응력이 뛰어나요. 항상 창의적인 해결책을 찾아요. 매력적이고 에너지 넘쳐요.',
    ChineseZodiac.ox => '부지런하고 믿음직해요. 모두를 지탱하는 조용한 힘. 끝까지 충성해요.',
    ChineseZodiac.tiger => '용감하고 열정적이에요. 멈출 수 없는 에너지의 자유로운 영혼. 절대 포기하지 않아요.',
    ChineseZodiac.rabbit => '상냥하고 운이 좋아요. 주변에 평화와 조화를 가져다줘요. 우아하고 친절해요.',
    ChineseZodiac.dragon => '가장 강력한 띠예요. 카리스마 넘치고, 야망 있고, 독특한 에너지로 가득해요. 빛나기 위해 태어났어요.',
    ChineseZodiac.snake => '지혜롭고 직관적이에요. 행동 전에 깊이 생각해요. 깊고 신비로운 내면의 지혜를 가졌어요.',
    ChineseZodiac.horse => '활기차고 독립적이에요. 자유와 모험을 사랑해요. 사교적이고 항상 움직여요.',
    ChineseZodiac.goat => '창의적이고 친절해요. 아름다움을 감상하는 예술적인 영혼. 온화하고 마음이 넓어요.',
    ChineseZodiac.monkey => '영리하고 장난기 넘쳐요. 뭐든지 금방 배워요. 재치 있고 유머러스해요.',
    ChineseZodiac.rooster => '체계적이고 시간을 잘 지켜요. 항상 약속을 지켜요. 꼼꼼하고 성실해요.',
    ChineseZodiac.dog => '가장 충성스러운 띠예요. 정직하고, 보호적이고, 신의 있어요. 항상 곁에 있는 친구예요.',
    ChineseZodiac.pig => '관대하고 마음이 따뜻해요. 사랑에 운이 좋아요. 정직하고 모든 사람의 사랑을 받아요.',
  };

  String get _descEs => switch (this) {
    ChineseZodiac.rat => 'Inteligente y adaptable. Siempre encuentra soluciones creativas. Carismático y lleno de energía.',
    ChineseZodiac.ox => 'Trabajador y confiable. Fuerza tranquila que sostiene a todos. Leal hasta el final.',
    ChineseZodiac.tiger => 'Valiente y apasionado. Espíritu libre con una energía arrolladora. Nunca se rinde.',
    ChineseZodiac.rabbit => 'Gentil y afortunado. Trae paz y armonía a su entorno. Elegante y amable.',
    ChineseZodiac.dragon => 'El más poderoso del zodiaco. Carismático, ambicioso y lleno de energía única. Nació para brillar.',
    ChineseZodiac.snake => 'Sabio e intuitivo. Piensa antes de actuar. Profundo y misterioso con gran sabiduría interior.',
    ChineseZodiac.horse => 'Enérgico e independiente. Ama la libertad y la aventura. Sociable y siempre en movimiento.',
    ChineseZodiac.goat => 'Creativo y amable. Alma artística que aprecia la belleza. Gentil y con gran corazón.',
    ChineseZodiac.monkey => 'Inteligente y juguetón. Aprende todo rapidísimo. Ingenioso y lleno de humor.',
    ChineseZodiac.rooster => 'Organizado y puntual. Siempre cumple lo que promete. Detallista y trabajador.',
    ChineseZodiac.dog => 'El más leal del zodiaco. Honesto, protector y fiel. El amigo que siempre está.',
    ChineseZodiac.pig => 'Generoso y de buen corazón. Afortunado en el amor. Honesto y muy querido por todos.',
  };

  String get _descEn => switch (this) {
    ChineseZodiac.rat => 'Smart and adaptable. Always finds creative solutions. Charming and full of energy.',
    ChineseZodiac.ox => 'Hardworking and reliable. Quiet strength that supports everyone. Loyal to the end.',
    ChineseZodiac.tiger => 'Brave and passionate. A free spirit with unstoppable energy. Never gives up.',
    ChineseZodiac.rabbit => 'Gentle and lucky. Brings peace and harmony to their surroundings. Elegant and kind.',
    ChineseZodiac.dragon => 'The most powerful sign. Charismatic, ambitious and full of unique energy. Born to shine.',
    ChineseZodiac.snake => 'Wise and intuitive. Thinks before acting. Deep and mysterious with great inner wisdom.',
    ChineseZodiac.horse => 'Energetic and independent. Loves freedom and adventure. Sociable and always on the move.',
    ChineseZodiac.goat => 'Creative and kind. An artistic soul who appreciates beauty. Gentle with a big heart.',
    ChineseZodiac.monkey => 'Smart and playful. Learns everything super fast. Witty and full of humor.',
    ChineseZodiac.rooster => 'Organized and punctual. Always keeps promises. Detail-oriented and hardworking.',
    ChineseZodiac.dog => 'The most loyal sign. Honest, protective and faithful. The friend who is always there.',
    ChineseZodiac.pig => 'Generous and kind-hearted. Lucky in love. Honest and loved by everyone.',
  };

  String get _descJa => switch (this) {
    ChineseZodiac.rat => '賢くて適応力がある。いつも創造的な解決策を見つける。魅力的でエネルギッシュ。',
    ChineseZodiac.ox => '勤勉で頼りになる。静かな強さで周りを支える。最後まで忠実。',
    ChineseZodiac.tiger => '勇敢で情熱的。止まらないエネルギーを持つ自由な魂。絶対に諦めない。',
    ChineseZodiac.rabbit => '優しくて幸運。周囲に平和と調和をもたらす。上品で親切。',
    ChineseZodiac.dragon => '最も強力な干支。魅力的で野心的、唯一無二のエネルギー。輝くために生まれた。',
    ChineseZodiac.snake => '賢くて直感的。行動する前によく考える。深みのある神秘的な知恵。',
    ChineseZodiac.horse => 'エネルギッシュで自立心が強い。自由と冒険を愛する。社交的で常に動き回る。',
    ChineseZodiac.goat => '創造的で親切。美しさを愛する芸術的な魂。優しく大きな心の持ち主。',
    ChineseZodiac.monkey => '賢くて遊び好き。何でもすぐに覚える。機知に富んでユーモアたっぷり。',
    ChineseZodiac.rooster => '几帳面で時間を守る。約束を必ず守る。細部にこだわる努力家。',
    ChineseZodiac.dog => '最も忠実な干支。正直で保護的、誠実。いつもそこにいる友達。',
    ChineseZodiac.pig => '寛大で優しい心の持ち主。恋愛運が強い。正直でみんなから愛される。',
  };

  String get _descIt => switch (this) {
    ChineseZodiac.rat => 'Intelligente e adattabile. Trova sempre soluzioni creative. Carismatico e pieno di energia.',
    ChineseZodiac.ox => 'Laborioso e affidabile. Forza silenziosa che sostiene tutti. Leale fino alla fine.',
    ChineseZodiac.tiger => 'Coraggioso e appassionato. Spirito libero con energia inarrestabile. Non si arrende mai.',
    ChineseZodiac.rabbit => 'Gentile e fortunato. Porta pace e armonia intorno a sé. Elegante e premuroso.',
    ChineseZodiac.dragon => 'Il più potente dello zodiaco. Carismatico, ambizioso e pieno di energia unica. Nato per brillare.',
    ChineseZodiac.snake => 'Saggio e intuitivo. Pensa prima di agire. Profondo e misterioso con grande saggezza.',
    ChineseZodiac.horse => 'Energico e indipendente. Ama la libertà e l\'avventura. Socievole e sempre in movimento.',
    ChineseZodiac.goat => 'Creativo e gentile. Anima artistica che apprezza la bellezza. Dolce con un grande cuore.',
    ChineseZodiac.monkey => 'Intelligente e giocoso. Impara tutto velocissimo. Spiritoso e pieno di umorismo.',
    ChineseZodiac.rooster => 'Organizzato e puntuale. Mantiene sempre le promesse. Preciso e instancabile.',
    ChineseZodiac.dog => 'Il segno più leale. Onesto, protettivo e fedele. L\'amico che c\'è sempre.',
    ChineseZodiac.pig => 'Generoso e di buon cuore. Fortunato in amore. Onesto e amato da tutti.',
  };

  String get _descFr => switch (this) {
    ChineseZodiac.rat => 'Intelligent et adaptable. Trouve toujours des solutions créatives. Charismatique et plein d\'énergie.',
    ChineseZodiac.ox => 'Travailleur et fiable. Force tranquille qui soutient tout le monde. Loyal jusqu\'au bout.',
    ChineseZodiac.tiger => 'Courageux et passionné. Esprit libre à l\'énergie irrésistible. Ne renonce jamais.',
    ChineseZodiac.rabbit => 'Doux et chanceux. Apporte paix et harmonie autour de lui. Élégant et bienveillant.',
    ChineseZodiac.dragon => 'Le plus puissant du zodiaque. Charismatique, ambitieux et plein d\'énergie unique. Né pour briller.',
    ChineseZodiac.snake => 'Sage et intuitif. Réfléchit avant d\'agir. Profond et mystérieux avec une grande sagesse.',
    ChineseZodiac.horse => 'Énergique et indépendant. Aime la liberté et l\'aventure. Sociable et toujours en mouvement.',
    ChineseZodiac.goat => 'Créatif et gentil. Âme artistique qui apprécie la beauté. Doux avec un grand cœur.',
    ChineseZodiac.monkey => 'Intelligent et joueur. Apprend tout très vite. Plein d\'esprit et d\'humour.',
    ChineseZodiac.rooster => 'Organisé et ponctuel. Tient toujours ses promesses. Méticuleux et travailleur.',
    ChineseZodiac.dog => 'Le signe le plus loyal. Honnête, protecteur et fidèle. L\'ami qui est toujours là.',
    ChineseZodiac.pig => 'Généreux et bon cœur. Chanceux en amour. Honnête et aimé de tous.',
  };

  String get _descDe => switch (this) {
    ChineseZodiac.rat => 'Klug und anpassungsfähig. Findet immer kreative Lösungen. Charismatisch und voller Energie.',
    ChineseZodiac.ox => 'Fleißig und zuverlässig. Stille Kraft, die alle trägt. Loyal bis zum Ende.',
    ChineseZodiac.tiger => 'Mutig und leidenschaftlich. Freier Geist mit unaufhaltbarer Energie. Gibt niemals auf.',
    ChineseZodiac.rabbit => 'Sanft und glücklich. Bringt Frieden und Harmonie. Elegant und freundlich.',
    ChineseZodiac.dragon => 'Das mächtigste Zeichen. Charismatisch, ehrgeizig und voller einzigartiger Energie. Zum Glänzen geboren.',
    ChineseZodiac.snake => 'Weise und intuitiv. Denkt nach bevor er handelt. Tief und geheimnisvoll mit großer Weisheit.',
    ChineseZodiac.horse => 'Energisch und unabhängig. Liebt Freiheit und Abenteuer. Gesellig und immer in Bewegung.',
    ChineseZodiac.goat => 'Kreativ und freundlich. Künstlerische Seele, die Schönheit schätzt. Sanft mit großem Herz.',
    ChineseZodiac.monkey => 'Klug und verspielt. Lernt alles superschnell. Witzig und voller Humor.',
    ChineseZodiac.rooster => 'Organisiert und pünktlich. Hält immer Versprechen. Detailbewusst und fleißig.',
    ChineseZodiac.dog => 'Das treueste Zeichen. Ehrlich, schützend und treu. Der Freund, der immer da ist.',
    ChineseZodiac.pig => 'Großzügig und gutherzig. Glücklich in der Liebe. Ehrlich und von allen geliebt.',
  };

  String get _es => switch (this) {
    ChineseZodiac.rat => 'Rata',
    ChineseZodiac.ox => 'Buey',
    ChineseZodiac.tiger => 'Tigre',
    ChineseZodiac.rabbit => 'Conejo',
    ChineseZodiac.dragon => 'Dragón',
    ChineseZodiac.snake => 'Serpiente',
    ChineseZodiac.horse => 'Caballo',
    ChineseZodiac.goat => 'Cabra',
    ChineseZodiac.monkey => 'Mono',
    ChineseZodiac.rooster => 'Gallo',
    ChineseZodiac.dog => 'Perro',
    ChineseZodiac.pig => 'Cerdo',
  };

  String get _en => switch (this) {
    ChineseZodiac.rat => 'Rat',
    ChineseZodiac.ox => 'Ox',
    ChineseZodiac.tiger => 'Tiger',
    ChineseZodiac.rabbit => 'Rabbit',
    ChineseZodiac.dragon => 'Dragon',
    ChineseZodiac.snake => 'Snake',
    ChineseZodiac.horse => 'Horse',
    ChineseZodiac.goat => 'Goat',
    ChineseZodiac.monkey => 'Monkey',
    ChineseZodiac.rooster => 'Rooster',
    ChineseZodiac.dog => 'Dog',
    ChineseZodiac.pig => 'Pig',
  };

  String get _zh => switch (this) {
    ChineseZodiac.rat => '鼠',
    ChineseZodiac.ox => '牛',
    ChineseZodiac.tiger => '虎',
    ChineseZodiac.rabbit => '兔',
    ChineseZodiac.dragon => '龙',
    ChineseZodiac.snake => '蛇',
    ChineseZodiac.horse => '马',
    ChineseZodiac.goat => '羊',
    ChineseZodiac.monkey => '猴',
    ChineseZodiac.rooster => '鸡',
    ChineseZodiac.dog => '狗',
    ChineseZodiac.pig => '猪',
  };

  String get _ko => switch (this) {
    ChineseZodiac.rat => '쥐',
    ChineseZodiac.ox => '소',
    ChineseZodiac.tiger => '호랑이',
    ChineseZodiac.rabbit => '토끼',
    ChineseZodiac.dragon => '용',
    ChineseZodiac.snake => '뱀',
    ChineseZodiac.horse => '말',
    ChineseZodiac.goat => '양',
    ChineseZodiac.monkey => '원숭이',
    ChineseZodiac.rooster => '닭',
    ChineseZodiac.dog => '개',
    ChineseZodiac.pig => '돼지',
  };

  String get _ja => switch (this) {
    ChineseZodiac.rat => '子（ねずみ）',
    ChineseZodiac.ox => '丑（うし）',
    ChineseZodiac.tiger => '寅（とら）',
    ChineseZodiac.rabbit => '卯（うさぎ）',
    ChineseZodiac.dragon => '辰（たつ）',
    ChineseZodiac.snake => '巳（へび）',
    ChineseZodiac.horse => '午（うま）',
    ChineseZodiac.goat => '未（ひつじ）',
    ChineseZodiac.monkey => '申（さる）',
    ChineseZodiac.rooster => '酉（とり）',
    ChineseZodiac.dog => '戌（いぬ）',
    ChineseZodiac.pig => '亥（いのしし）',
  };

  String get _it => switch (this) {
    ChineseZodiac.rat => 'Topo',
    ChineseZodiac.ox => 'Bue',
    ChineseZodiac.tiger => 'Tigre',
    ChineseZodiac.rabbit => 'Coniglio',
    ChineseZodiac.dragon => 'Drago',
    ChineseZodiac.snake => 'Serpente',
    ChineseZodiac.horse => 'Cavallo',
    ChineseZodiac.goat => 'Capra',
    ChineseZodiac.monkey => 'Scimmia',
    ChineseZodiac.rooster => 'Gallo',
    ChineseZodiac.dog => 'Cane',
    ChineseZodiac.pig => 'Maiale',
  };

  String get _fr => switch (this) {
    ChineseZodiac.rat => 'Rat',
    ChineseZodiac.ox => 'Bœuf',
    ChineseZodiac.tiger => 'Tigre',
    ChineseZodiac.rabbit => 'Lapin',
    ChineseZodiac.dragon => 'Dragon',
    ChineseZodiac.snake => 'Serpent',
    ChineseZodiac.horse => 'Cheval',
    ChineseZodiac.goat => 'Chèvre',
    ChineseZodiac.monkey => 'Singe',
    ChineseZodiac.rooster => 'Coq',
    ChineseZodiac.dog => 'Chien',
    ChineseZodiac.pig => 'Cochon',
  };

  String get _de => switch (this) {
    ChineseZodiac.rat => 'Ratte',
    ChineseZodiac.ox => 'Büffel',
    ChineseZodiac.tiger => 'Tiger',
    ChineseZodiac.rabbit => 'Hase',
    ChineseZodiac.dragon => 'Drache',
    ChineseZodiac.snake => 'Schlange',
    ChineseZodiac.horse => 'Pferd',
    ChineseZodiac.goat => 'Ziege',
    ChineseZodiac.monkey => 'Affe',
    ChineseZodiac.rooster => 'Hahn',
    ChineseZodiac.dog => 'Hund',
    ChineseZodiac.pig => 'Schwein',
  };
}

enum WesternZodiac {
  aries('♈', '🐏'),
  taurus('♉', '🐂'),
  gemini('♊', '👯'),
  cancer('♋', '🦀'),
  leo('♌', '🦁'),
  virgo('♍', '🌾'),
  libra('♎', '⚖️'),
  scorpio('♏', '🦂'),
  sagittarius('♐', '🏹'),
  capricorn('♑', '🐐'),
  aquarius('♒', '🌊'),
  pisces('♓', '🐟');

  const WesternZodiac(this.glyph, this.emoji);
  final String glyph;
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

  String descriptionFor(String locale) => switch (locale) {
    'ja' => _descJa,
    'zh' => _descZh,
    'ko' => _descKo,
    'it' => _descIt,
    'fr' => _descFr,
    'de' => _descDe,
    'en' => _descEn,
    _ => _descEs,
  };

  String get _zh => switch (this) {
    WesternZodiac.aries => '白羊座',
    WesternZodiac.taurus => '金牛座',
    WesternZodiac.gemini => '双子座',
    WesternZodiac.cancer => '巨蟹座',
    WesternZodiac.leo => '狮子座',
    WesternZodiac.virgo => '处女座',
    WesternZodiac.libra => '天秤座',
    WesternZodiac.scorpio => '天蝎座',
    WesternZodiac.sagittarius => '射手座',
    WesternZodiac.capricorn => '摩羯座',
    WesternZodiac.aquarius => '水瓶座',
    WesternZodiac.pisces => '双鱼座',
  };

  String get _ko => switch (this) {
    WesternZodiac.aries => '양자리',
    WesternZodiac.taurus => '황소자리',
    WesternZodiac.gemini => '쌍둥이자리',
    WesternZodiac.cancer => '게자리',
    WesternZodiac.leo => '사자자리',
    WesternZodiac.virgo => '처녀자리',
    WesternZodiac.libra => '천칭자리',
    WesternZodiac.scorpio => '전갈자리',
    WesternZodiac.sagittarius => '사수자리',
    WesternZodiac.capricorn => '염소자리',
    WesternZodiac.aquarius => '물병자리',
    WesternZodiac.pisces => '물고기자리',
  };

  String get _descZh => switch (this) {
    WesternZodiac.aries => '勇敢热情，天生的领袖，行动果断。精力无限，拥有冠军的心。',
    WesternZodiac.taurus => '忠诚耐心，热爱美好事物和宁静时光。如大地般坚定稳重。',
    WesternZodiac.gemini => '好奇聪慧，善于交际，创意无限。学什么都驾轻就熟。',
    WesternZodiac.cancer => '深情保护，直觉敏锐，全心投入。家庭的灵魂所在。',
    WesternZodiac.leo => '魅力非凡，慷慨大度。生来耀眼，为身边的人带来快乐。',
    WesternZodiac.virgo => '注重细节，聪慧过人。乐于助人，充满爱心的完美主义者。',
    WesternZodiac.libra => '迷人平衡，热爱和谐与公正。走到哪里都能交到朋友。',
    WesternZodiac.scorpio => '热情深邃，忠诚无比。一旦爱上，便全身心投入。',
    WesternZodiac.sagittarius => '冒险乐观，热爱自由与知识。整个世界都是家园。',
    WesternZodiac.capricorn => '野心勃勃，意志坚定。凭耐心与专注实现所有目标。',
    WesternZodiac.aquarius => '独特创新，思维超前。梦想创造一个更美好的世界。',
    WesternZodiac.pisces => '敏感多才，充满梦想。拥有无比宽广的心，对世界感受深刻。',
  };

  String get _descKo => switch (this) {
    WesternZodiac.aries => '용감하고 열정적이에요. 머뭇거리지 않고 행동하는 타고난 리더예요. 끝없는 에너지와 챔피언의 심장.',
    WesternZodiac.taurus => '충실하고 인내심이 강해요. 아름다운 것들과 조용한 순간을 사랑해요. 대지처럼 든든해요.',
    WesternZodiac.gemini => '호기심 많고 똑똑해요. 사교적이고 아이디어가 넘쳐요. 놀라울 정도로 쉽게 모든 것을 배워요.',
    WesternZodiac.cancer => '깊이 사랑하고 보호적이에요. 직관이 뛰어나고 헌신적이에요. 집의 영혼이에요.',
    WesternZodiac.leo => '카리스마 있고 너그러워요. 빛나기 위해 태어났고 주변 모두에게 기쁨을 가져다줘요.',
    WesternZodiac.virgo => '세심하고 영리해요. 마음이 넓고 도움을 주는 사랑스러운 완벽주의자예요.',
    WesternZodiac.libra => '매력적이고 균형 잡혀 있어요. 조화와 공정함을 사랑해요. 어디서든 친구를 만들어요.',
    WesternZodiac.scorpio => '강렬하고 열정적이에요. 깊이 충성스러워요. 사랑할 때는 온 존재를 다해 사랑해요.',
    WesternZodiac.sagittarius => '모험적이고 낙관적이에요. 자유와 지식을 사랑해요. 온 세상이 집이에요.',
    WesternZodiac.capricorn => '야망 있고 규율적이에요. 인내와 헌신으로 모든 목표를 이루어요.',
    WesternZodiac.aquarius => '독창적이고 혁신적이에요. 다르게 생각하고 더 나은 세상을 꿈꿔요.',
    WesternZodiac.pisces => '감수성 풍부하고 창의적이에요. 거대한 마음을 가진 몽상가예요. 세상을 깊이 느껴요.',
  };

  String get _descEs => switch (this) {
    WesternZodiac.aries => 'Valiente y apasionado. Líder nato que actúa sin dudar. Energía inagotable y corazón de campeón.',
    WesternZodiac.taurus => 'Fiel y paciente. Ama las cosas bellas y los momentos tranquilos. Firme como la tierra.',
    WesternZodiac.gemini => 'Curioso y brillante. Sociable y lleno de ideas. Aprende todo con asombrosa facilidad.',
    WesternZodiac.cancer => 'Profundamente amoroso y protector. Intuitivo y devoto a los suyos. El alma del hogar.',
    WesternZodiac.leo => 'Carismático y generoso. Nació para brillar y llenar de alegría a todos los que lo rodean.',
    WesternZodiac.virgo => 'Detallista e inteligente. Servicial con un gran corazón. Perfeccionista lleno de amor.',
    WesternZodiac.libra => 'Encantador y equilibrado. Amante de la armonía y la justicia. Hace amigos en todas partes.',
    WesternZodiac.scorpio => 'Intenso y apasionado. Profundamente leal. Cuando ama, lo hace con todo su ser.',
    WesternZodiac.sagittarius => 'Aventurero y optimista. Ama la libertad y el conocimiento. El mundo entero es su hogar.',
    WesternZodiac.capricorn => 'Ambicioso y disciplinado. Logra todo lo que se propone con paciencia y dedicación.',
    WesternZodiac.aquarius => 'Original e innovador. Piensa diferente y sueña con hacer del mundo un lugar mejor.',
    WesternZodiac.pisces => 'Sensible y creativo. Soñador con un corazón enorme. Siente el mundo con gran intensidad.',
  };

  String get _descEn => switch (this) {
    WesternZodiac.aries => 'Brave and passionate. A born leader who acts without hesitation. Boundless energy and a champion\'s heart.',
    WesternZodiac.taurus => 'Loyal and patient. Loves beauty and quiet moments. Steady and solid as the earth.',
    WesternZodiac.gemini => 'Curious and brilliant. Social and full of ideas. Learns everything with amazing ease.',
    WesternZodiac.cancer => 'Deeply loving and protective. Intuitive and devoted. The heart and soul of home.',
    WesternZodiac.leo => 'Charismatic and generous. Born to shine and bring joy to everyone around them.',
    WesternZodiac.virgo => 'Detail-oriented and smart. Helpful with a big heart. A caring perfectionist full of love.',
    WesternZodiac.libra => 'Charming and balanced. Lover of harmony and justice. Makes friends absolutely everywhere.',
    WesternZodiac.scorpio => 'Intense and passionate. Deeply loyal. When they love, they love with their entire being.',
    WesternZodiac.sagittarius => 'Adventurous and optimistic. Loves freedom and knowledge. The whole world is home.',
    WesternZodiac.capricorn => 'Ambitious and disciplined. Achieves everything they set their mind to with patience.',
    WesternZodiac.aquarius => 'Original and innovative. Thinks differently and dreams of making the world a better place.',
    WesternZodiac.pisces => 'Sensitive and creative. A dreamer with an enormous heart. Feels the world deeply.',
  };

  String get _descJa => switch (this) {
    WesternZodiac.aries => '勇敢で情熱的。迷わず行動する生まれながらのリーダー。無限のエネルギーと勝者の心。',
    WesternZodiac.taurus => '忠実で辛抱強い。美しいものと穏やかな時間を愛する。大地のように揺るぎない。',
    WesternZodiac.gemini => '好奇心旺盛で聡明。社交的でアイデアいっぱい。何でも驚くほど速く覚える。',
    WesternZodiac.cancer => '深い愛情と保護心。直感が鋭く家族に献身的。家の魂そのもの。',
    WesternZodiac.leo => '魅力的で寛大。輝くために生まれ、周りの人に喜びをもたらす。',
    WesternZodiac.virgo => '細かいことに気づく賢さ。思いやりがあり愛情深い完璧主義者。',
    WesternZodiac.libra => '魅力的でバランス感覚が抜群。調和と公正を愛し、どこでも友達を作る。',
    WesternZodiac.scorpio => '情熱的で深い愛。真の忠誠心。愛する時は全存在で愛する。',
    WesternZodiac.sagittarius => '冒険好きで楽観的。自由と知識を愛する。世界全体が故郷。',
    WesternZodiac.capricorn => '野心的で規律正しい。忍耐と努力で何でも成し遂げる。',
    WesternZodiac.aquarius => '独創的で革新的。違う視点で考え、より良い世界を夢見る。',
    WesternZodiac.pisces => '繊細でクリエイティブ。大きな心を持つ夢想家。世界を深く感じる。',
  };

  String get _descIt => switch (this) {
    WesternZodiac.aries => 'Coraggioso e appassionato. Leader nato che agisce senza esitare. Energia infinita e cuore da campione.',
    WesternZodiac.taurus => 'Fedele e paziente. Ama le cose belle e i momenti tranquilli. Solido come la terra.',
    WesternZodiac.gemini => 'Curioso e brillante. Socievole e pieno di idee. Impara tutto con straordinaria facilità.',
    WesternZodiac.cancer => 'Profondamente amorevole e protettivo. Intuitivo e devoto. L\'anima della casa.',
    WesternZodiac.leo => 'Carismatico e generoso. Nato per brillare e portare gioia a tutti intorno.',
    WesternZodiac.virgo => 'Attento ai dettagli e intelligente. Premuroso con un grande cuore. Perfezionista con amore.',
    WesternZodiac.libra => 'Affascinante ed equilibrato. Amante dell\'armonia e della giustizia. Fa amici ovunque.',
    WesternZodiac.scorpio => 'Intenso e appassionato. Profondamente leale. Quando ama, ama con tutto sé stesso.',
    WesternZodiac.sagittarius => 'Avventuroso e ottimista. Ama la libertà e la conoscenza. Il mondo intero è casa sua.',
    WesternZodiac.capricorn => 'Ambizioso e disciplinato. Raggiunge tutto ciò che si prefigge con pazienza e dedizione.',
    WesternZodiac.aquarius => 'Originale e innovativo. Pensa diversamente e sogna di rendere il mondo migliore.',
    WesternZodiac.pisces => 'Sensibile e creativo. Sognatore con un cuore enorme. Sente il mondo con grande intensità.',
  };

  String get _descFr => switch (this) {
    WesternZodiac.aries => 'Courageux et passionné. Leader né qui agit sans hésiter. Énergie inépuisable et cœur de champion.',
    WesternZodiac.taurus => 'Loyal et patient. Aime les belles choses et les moments tranquilles. Solide comme la terre.',
    WesternZodiac.gemini => 'Curieux et brillant. Sociable et plein d\'idées. Apprend tout avec une facilité étonnante.',
    WesternZodiac.cancer => 'Profondément aimant et protecteur. Intuitif et dévoué. L\'âme de la maison.',
    WesternZodiac.leo => 'Charismatique et généreux. Né pour briller et apporter de la joie à tous autour.',
    WesternZodiac.virgo => 'Attentif aux détails et intelligent. Serviable avec un grand cœur. Perfectionniste plein d\'amour.',
    WesternZodiac.libra => 'Charmant et équilibré. Amoureux de l\'harmonie et de la justice. Fait des amis partout.',
    WesternZodiac.scorpio => 'Intense et passionné. Profondément loyal. Quand il aime, c\'est de tout son être.',
    WesternZodiac.sagittarius => 'Aventurier et optimiste. Aime la liberté et la connaissance. Le monde entier est sa maison.',
    WesternZodiac.capricorn => 'Ambitieux et discipliné. Atteint tout ce qu\'il se fixe avec patience et dévouement.',
    WesternZodiac.aquarius => 'Original et innovant. Pense différemment et rêve de rendre le monde meilleur.',
    WesternZodiac.pisces => 'Sensible et créatif. Rêveur avec un cœur énorme. Ressent le monde avec grande intensité.',
  };

  String get _descDe => switch (this) {
    WesternZodiac.aries => 'Mutig und leidenschaftlich. Geborener Anführer, der ohne Zögern handelt. Unerschöpfliche Energie.',
    WesternZodiac.taurus => 'Loyal und geduldig. Liebt schöne Dinge und ruhige Momente. Fest wie die Erde.',
    WesternZodiac.gemini => 'Neugierig und brillant. Gesellig und voller Ideen. Lernt alles mit erstaunlicher Leichtigkeit.',
    WesternZodiac.cancer => 'Tief liebend und schützend. Intuitiv und ergeben. Die Seele des Zuhauses.',
    WesternZodiac.leo => 'Charismatisch und großzügig. Zum Glänzen geboren und bringt allen Freude.',
    WesternZodiac.virgo => 'Detailbewusst und klug. Hilfsbereit mit großem Herz. Liebevoller Perfektionist.',
    WesternZodiac.libra => 'Charmant und ausgewogen. Liebt Harmonie und Gerechtigkeit. Macht überall Freunde.',
    WesternZodiac.scorpio => 'Intensiv und leidenschaftlich. Tief loyal. Wenn er liebt, liebt er mit ganzem Herzen.',
    WesternZodiac.sagittarius => 'Abenteuerlustig und optimistisch. Liebt Freiheit und Wissen. Die ganze Welt ist Heimat.',
    WesternZodiac.capricorn => 'Ehrgeizig und diszipliniert. Erreicht alles mit Geduld und Hingabe.',
    WesternZodiac.aquarius => 'Original und innovativ. Denkt anders und träumt von einer besseren Welt.',
    WesternZodiac.pisces => 'Sensibel und kreativ. Träumer mit riesigem Herz. Fühlt die Welt mit großer Intensität.',
  };

  String get _es => switch (this) {
    WesternZodiac.aries => 'Aries',
    WesternZodiac.taurus => 'Tauro',
    WesternZodiac.gemini => 'Géminis',
    WesternZodiac.cancer => 'Cáncer',
    WesternZodiac.leo => 'Leo',
    WesternZodiac.virgo => 'Virgo',
    WesternZodiac.libra => 'Libra',
    WesternZodiac.scorpio => 'Escorpio',
    WesternZodiac.sagittarius => 'Sagitario',
    WesternZodiac.capricorn => 'Capricornio',
    WesternZodiac.aquarius => 'Acuario',
    WesternZodiac.pisces => 'Piscis',
  };

  String get _en => switch (this) {
    WesternZodiac.aries => 'Aries',
    WesternZodiac.taurus => 'Taurus',
    WesternZodiac.gemini => 'Gemini',
    WesternZodiac.cancer => 'Cancer',
    WesternZodiac.leo => 'Leo',
    WesternZodiac.virgo => 'Virgo',
    WesternZodiac.libra => 'Libra',
    WesternZodiac.scorpio => 'Scorpio',
    WesternZodiac.sagittarius => 'Sagittarius',
    WesternZodiac.capricorn => 'Capricorn',
    WesternZodiac.aquarius => 'Aquarius',
    WesternZodiac.pisces => 'Pisces',
  };

  String get _ja => switch (this) {
    WesternZodiac.aries => '牡羊座',
    WesternZodiac.taurus => '牡牛座',
    WesternZodiac.gemini => '双子座',
    WesternZodiac.cancer => '蟹座',
    WesternZodiac.leo => '獅子座',
    WesternZodiac.virgo => '乙女座',
    WesternZodiac.libra => '天秤座',
    WesternZodiac.scorpio => '蠍座',
    WesternZodiac.sagittarius => '射手座',
    WesternZodiac.capricorn => '山羊座',
    WesternZodiac.aquarius => '水瓶座',
    WesternZodiac.pisces => '魚座',
  };

  String get _it => switch (this) {
    WesternZodiac.aries => 'Ariete',
    WesternZodiac.taurus => 'Toro',
    WesternZodiac.gemini => 'Gemelli',
    WesternZodiac.cancer => 'Cancro',
    WesternZodiac.leo => 'Leone',
    WesternZodiac.virgo => 'Vergine',
    WesternZodiac.libra => 'Bilancia',
    WesternZodiac.scorpio => 'Scorpione',
    WesternZodiac.sagittarius => 'Sagittario',
    WesternZodiac.capricorn => 'Capricorno',
    WesternZodiac.aquarius => 'Acquario',
    WesternZodiac.pisces => 'Pesci',
  };

  String get _fr => switch (this) {
    WesternZodiac.aries => 'Bélier',
    WesternZodiac.taurus => 'Taureau',
    WesternZodiac.gemini => 'Gémeaux',
    WesternZodiac.cancer => 'Cancer',
    WesternZodiac.leo => 'Lion',
    WesternZodiac.virgo => 'Vierge',
    WesternZodiac.libra => 'Balance',
    WesternZodiac.scorpio => 'Scorpion',
    WesternZodiac.sagittarius => 'Sagittaire',
    WesternZodiac.capricorn => 'Capricorne',
    WesternZodiac.aquarius => 'Verseau',
    WesternZodiac.pisces => 'Poissons',
  };

  String get _de => switch (this) {
    WesternZodiac.aries => 'Widder',
    WesternZodiac.taurus => 'Stier',
    WesternZodiac.gemini => 'Zwillinge',
    WesternZodiac.cancer => 'Krebs',
    WesternZodiac.leo => 'Löwe',
    WesternZodiac.virgo => 'Jungfrau',
    WesternZodiac.libra => 'Waage',
    WesternZodiac.scorpio => 'Skorpion',
    WesternZodiac.sagittarius => 'Schütze',
    WesternZodiac.capricorn => 'Steinbock',
    WesternZodiac.aquarius => 'Wassermann',
    WesternZodiac.pisces => 'Fische',
  };
}

class ZodiacService {
  static ChineseZodiac getChineseZodiac(DateTime date) {
    // Simplified: uses Gregorian year (±1 month error around Chinese New Year)
    final index = (date.year - 4) % 12;
    return ChineseZodiac.values[index < 0 ? index + 12 : index];
  }

  static WesternZodiac getWesternZodiac(DateTime date) {
    final m = date.month;
    final d = date.day;
    if ((m == 3 && d >= 21) || (m == 4 && d <= 19)) return WesternZodiac.aries;
    if ((m == 4 && d >= 20) || (m == 5 && d <= 20)) return WesternZodiac.taurus;
    if ((m == 5 && d >= 21) || (m == 6 && d <= 20)) return WesternZodiac.gemini;
    if ((m == 6 && d >= 21) || (m == 7 && d <= 22)) return WesternZodiac.cancer;
    if ((m == 7 && d >= 23) || (m == 8 && d <= 22)) return WesternZodiac.leo;
    if ((m == 8 && d >= 23) || (m == 9 && d <= 22)) return WesternZodiac.virgo;
    if ((m == 9 && d >= 23) || (m == 10 && d <= 22)) return WesternZodiac.libra;
    if ((m == 10 && d >= 23) || (m == 11 && d <= 21)) return WesternZodiac.scorpio;
    if ((m == 11 && d >= 22) || (m == 12 && d <= 21)) return WesternZodiac.sagittarius;
    if ((m == 12 && d >= 22) || (m == 1 && d <= 19)) return WesternZodiac.capricorn;
    if ((m == 1 && d >= 20) || (m == 2 && d <= 18)) return WesternZodiac.aquarius;
    return WesternZodiac.pisces;
  }

  static String chineseElementFor(DateTime date, String locale) {
    final idx = (date.year - 4) % 10;
    final i = idx < 0 ? idx + 10 : idx;
    return switch (locale) {
      'ja' || 'zh' => ['木', '木', '火', '火', '土', '土', '金', '金', '水', '水'][i],
      'ko' => ['목(木)', '목(木)', '화(火)', '화(火)', '토(土)', '토(土)', '금(金)', '금(金)', '수(水)', '수(水)'][i],
      'it' => ['Legno', 'Legno', 'Fuoco', 'Fuoco', 'Terra', 'Terra', 'Metallo', 'Metallo', 'Acqua', 'Acqua'][i],
      'fr' => ['Bois', 'Bois', 'Feu', 'Feu', 'Terre', 'Terre', 'Métal', 'Métal', 'Eau', 'Eau'][i],
      'de' => ['Holz', 'Holz', 'Feuer', 'Feuer', 'Erde', 'Erde', 'Metall', 'Metall', 'Wasser', 'Wasser'][i],
      'en' => ['Wood', 'Wood', 'Fire', 'Fire', 'Earth', 'Earth', 'Metal', 'Metal', 'Water', 'Water'][i],
      _ => ['Madera', 'Madera', 'Fuego', 'Fuego', 'Tierra', 'Tierra', 'Metal', 'Metal', 'Agua', 'Agua'][i],
    };
  }
}
