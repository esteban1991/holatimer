class WeekInfo {
  const WeekInfo({
    required this.week,
    required this.fruitEmoji,
    required this.size,
    required this.weight,
    required this.fruits,
    required this.developments,
  });

  final int week;
  final String fruitEmoji;
  final String size;
  final String weight;
  final Map<String, String> fruits;
  final Map<String, String> developments;

  String get fruit => fruits['es']!;
  String get development => developments['es']!;

  String fruitFor(String locale) =>
      fruits[locale] ?? fruits['en'] ?? fruits['es']!;

  String developmentFor(String locale) =>
      developments[locale] ?? developments['en'] ?? developments['es']!;
}

const Map<int, WeekInfo> pregnancyData = {
  4: WeekInfo(week: 4, fruitEmoji: '🌱', size: '1 mm', weight: '< 1 g',
    fruits: {'es':'semilla de amapola','en':'poppy seed','ja':'ケシの種','it':'seme di papavero','fr':'graine de pavot','de':'Mohnsamen'},
    developments: {'es':'Se implanta en el útero. El corazón empieza a formarse.','en':'Implants in the uterus. The heart begins to form.','ja':'子宮に着床。心臓が形成し始めます。','it':'Si impianta nell\'utero. Il cuore comincia a formarsi.','fr':'S\'implante dans l\'utérus. Le cœur commence à se former.','de':'Nistet sich ein. Das Herz beginnt sich zu formen.'}),
  5: WeekInfo(week: 5, fruitEmoji: '🌱', size: '2 mm', weight: '< 1 g',
    fruits: {'es':'semilla de sésamo','en':'sesame seed','ja':'ゴマの種','it':'seme di sesamo','fr':'graine de sésame','de':'Sesamsamen'},
    developments: {'es':'Se forman el cerebro y la médula espinal.','en':'Brain and spinal cord begin to form.','ja':'脳と脊髄が形成されます。','it':'Cervello e midollo spinale si formano.','fr':'Le cerveau et la moelle épinière se forment.','de':'Gehirn und Rückenmark bilden sich.'}),
  6: WeekInfo(week: 6, fruitEmoji: '🫘', size: '6 mm', weight: '< 1 g',
    fruits: {'es':'lenteja','en':'lentil','ja':'レンズ豆','it':'lenticchia','fr':'lentille','de':'Linse'},
    developments: {'es':'El corazón late. Brotan los primeros rasgos faciales.','en':'Heart is beating. First facial features appear.','ja':'心拍が始まります。顔の輪郭が現れます。','it':'Il cuore batte. I primi lineamenti del viso appaiono.','fr':'Le cœur bat. Les premiers traits du visage apparaissent.','de':'Das Herz schlägt. Erste Gesichtszüge erscheinen.'}),
  7: WeekInfo(week: 7, fruitEmoji: '🫐', size: '10 mm', weight: '< 1 g',
    fruits: {'es':'arándano','en':'blueberry','ja':'ブルーベリー','it':'mirtillo','fr':'myrtille','de':'Blaubeere'},
    developments: {'es':'Brotes de brazos y piernas. El cerebro crece rápido.','en':'Arm and leg buds sprout. Brain grows rapidly.','ja':'手足の芽が出ます。脳が急成長します。','it':'Germogli di braccia e gambe. Il cervello cresce velocemente.','fr':'Les bourgeons des bras et jambes poussent. Le cerveau croît.','de':'Arm- und Beinknospen sprießen. Das Gehirn wächst schnell.'}),
  8: WeekInfo(week: 8, fruitEmoji: '🍒', size: '16 mm', weight: '1 g',
    fruits: {'es':'frambuesa','en':'raspberry','ja':'ラズベリー','it':'lampone','fr':'framboise','de':'Himbeere'},
    developments: {'es':'Los dedos empiezan a formarse. Los párpados se cierran.','en':'Fingers start forming. Eyelids close.','ja':'指が形成され始めます。まぶたが閉じます。','it':'Le dita iniziano a formarsi. Le palpebre si chiudono.','fr':'Les doigts commencent à se former. Les paupières se ferment.','de':'Finger beginnen sich zu formen. Augenlider schließen sich.'}),
  9: WeekInfo(week: 9, fruitEmoji: '🫒', size: '23 mm', weight: '2 g',
    fruits: {'es':'aceituna','en':'olive','ja':'オリーブ','it':'oliva','fr':'olive','de':'Olive'},
    developments: {'es':'Ya tiene los rasgos faciales básicos. Se mueve, aunque aún no se siente.','en':'Basic facial features formed. Starts to move, though not felt yet.','ja':'基本的な顔の形ができます。まだ感じられませんが動き始めます。','it':'I lineamenti base del viso sono formati. Comincia a muoversi.','fr':'Les traits faciaux de base sont formés. Commence à bouger.','de':'Grundlegende Gesichtszüge geformt. Beginnt sich zu bewegen.'}),
  10: WeekInfo(week: 10, fruitEmoji: '🍓', size: '31 mm', weight: '4 g',
    fruits: {'es':'fresa pequeña','en':'small strawberry','ja':'小さなイチゴ','it':'fragolina','fr':'petite fraise','de':'kleine Erdbeere'},
    developments: {'es':'Las articulaciones funcionan. Uñas y dientes empiezan a crecer.','en':'Joints work. Nails and teeth begin to grow.','ja':'関節が機能します。爪と歯が育ち始めます。','it':'Le articolazioni funzionano. Unghie e denti iniziano a crescere.','fr':'Les articulations fonctionnent. Ongles et dents commencent à pousser.','de':'Gelenke funktionieren. Nägel und Zähne beginnen zu wachsen.'}),
  11: WeekInfo(week: 11, fruitEmoji: '🫐', size: '41 mm', weight: '7 g',
    fruits: {'es':'higo','en':'fig','ja':'イチジク','it':'fico','fr':'figue','de':'Feige'},
    developments: {'es':'Ya puede abrir y cerrar las manos. Sus genitales están formándose.','en':'Can open and close hands. Genitals are forming.','ja':'手を開閉できます。性器が形成されています。','it':'Può aprire e chiudere le mani. I genitali si stanno formando.','fr':'Peut ouvrir et fermer les mains. Les organes génitaux se forment.','de':'Kann Hände öffnen und schließen. Genitalien bilden sich.'}),
  12: WeekInfo(week: 12, fruitEmoji: '🍋', size: '54 mm', weight: '14 g',
    fruits: {'es':'lima','en':'lime','ja':'ライム','it':'lime','fr':'citron vert','de':'Limette'},
    developments: {'es':'Todos los órganos vitales están formados. El riesgo de aborto baja mucho.','en':'All vital organs formed. Miscarriage risk drops significantly.','ja':'重要な臓器がすべて形成されます。流産リスクが大幅に低下します。','it':'Tutti gli organi vitali formati. Il rischio di aborto scende molto.','fr':'Tous les organes vitaux formés. Le risque de fausse couche diminue.','de':'Alle lebenswichtigen Organe gebildet. Fehlgeburtsrisiko sinkt stark.'}),
  13: WeekInfo(week: 13, fruitEmoji: '🫛', size: '74 mm', weight: '23 g',
    fruits: {'es':'guisante dulce','en':'snap pea','ja':'サヤエンドウ','it':'pisello dolce','fr':'pois gourmand','de':'Zuckerschote'},
    developments: {'es':'La huella dactilar ya está formada. Las cuerdas vocales se desarrollan.','en':'Fingerprints are formed. Vocal cords develop.','ja':'指紋ができます。声帯が発達します。','it':'L\'impronta digitale è formata. Le corde vocali si sviluppano.','fr':'L\'empreinte digitale est formée. Les cordes vocales se développent.','de':'Fingerabdruck geformt. Stimmlippen entwickeln sich.'}),
  14: WeekInfo(week: 14, fruitEmoji: '🍋', size: '87 mm', weight: '43 g',
    fruits: {'es':'limón','en':'lemon','ja':'レモン','it':'limone','fr':'citron','de':'Zitrone'},
    developments: {'es':'Puede hacer muecas. El pelo y las cejas comienzan a salir.','en':'Can make faces. Hair and eyebrows begin to grow.','ja':'表情を作れます。髪と眉毛が生え始めます。','it':'Può fare le smorfie. Capelli e sopracciglia iniziano a crescere.','fr':'Peut faire des grimaces. Cheveux et sourcils commencent à pousser.','de':'Kann Grimassen schneiden. Haare und Augenbrauen wachsen.'}),
  15: WeekInfo(week: 15, fruitEmoji: '🍎', size: '10 cm', weight: '70 g',
    fruits: {'es':'manzana','en':'apple','ja':'リンゴ','it':'mela','fr':'pomme','de':'Apfel'},
    developments: {'es':'Oye sonidos del mundo exterior. Sus pulmones practican respirar.','en':'Can hear outside sounds. Lungs practice breathing.','ja':'外の音が聞こえます。肺が呼吸の練習をします。','it':'Sente i suoni esterni. I polmoni praticano la respirazione.','fr':'Entend les sons extérieurs. Les poumons s\'exercent à respirer.','de':'Hört Außengeräusche. Lungen üben Atmen.'}),
  16: WeekInfo(week: 16, fruitEmoji: '🥑', size: '12 cm', weight: '100 g',
    fruits: {'es':'aguacate','en':'avocado','ja':'アボカド','it':'avocado','fr':'avocat','de':'Avocado'},
    developments: {'es':'Hace movimientos coordinados. El sistema nervioso madura.','en':'Makes coordinated movements. Nervous system matures.','ja':'協調した動きをします。神経系が成熟します。','it':'Fa movimenti coordinati. Il sistema nervoso matura.','fr':'Fait des mouvements coordonnés. Le système nerveux mature.','de':'Macht koordinierte Bewegungen. Nervensystem reift.'}),
  17: WeekInfo(week: 17, fruitEmoji: '🫚', size: '13 cm', weight: '140 g',
    fruits: {'es':'nabo','en':'turnip','ja':'カブ','it':'rapa','fr':'navet','de':'Rübe'},
    developments: {'es':'Se forma la grasa corporal. El cordón umbilical se fortalece.','en':'Body fat forms. Umbilical cord strengthens.','ja':'体脂肪が形成されます。へその緒が強くなります。','it':'Si forma il grasso corporeo. Il cordone ombelicale si rafforza.','fr':'La graisse corporelle se forme. Le cordon ombilical se renforce.','de':'Körperfett bildet sich. Nabelschnur wird stärker.'}),
  18: WeekInfo(week: 18, fruitEmoji: '🫑', size: '14 cm', weight: '190 g',
    fruits: {'es':'pimiento morrón','en':'bell pepper','ja':'パプリカ','it':'peperone','fr':'poivron','de':'Paprika'},
    developments: {'es':'Sus movimientos se vuelven más fuertes. El sistema nervioso se mieliniza.','en':'Movements grow stronger. Nervous system myelinates.','ja':'動きが強くなります。神経系の髄鞘化が進みます。','it':'I movimenti diventano più forti. Il sistema nervoso si mielinizza.','fr':'Les mouvements deviennent plus forts. Myélinisation du système nerveux.','de':'Bewegungen werden stärker. Nervensystem myelinisiert.'}),
  19: WeekInfo(week: 19, fruitEmoji: '🍅', size: '15 cm', weight: '240 g',
    fruits: {'es':'tomate','en':'tomato','ja':'トマト','it':'pomodoro','fr':'tomate','de':'Tomate'},
    developments: {'es':'Cubre su piel el vérnix caseoso. Los sentidos se desarrollan.','en':'Vernix caseosa covers skin. Senses develop.','ja':'胎脂が皮膚を覆います。感覚が発達します。','it':'Il vernix copre la pelle. I sensi si sviluppano.','fr':'Le vernix couvre la peau. Les sens se développent.','de':'Käseschmiere bedeckt die Haut. Sinne entwickeln sich.'}),
  20: WeekInfo(week: 20, fruitEmoji: '🍌', size: '16 cm', weight: '300 g',
    fruits: {'es':'plátano','en':'banana','ja':'バナナ','it':'banana','fr':'banane','de':'Banane'},
    developments: {'es':'¡Mitad del camino! Puede tragar. Tiene cejas y cabello.','en':'Halfway there! Can swallow. Has eyebrows and hair.','ja':'折り返し地点！飲み込めます。眉毛と髪があります。','it':'A metà strada! Può deglutire. Ha sopracciglia e capelli.','fr':'À mi-chemin ! Peut avaler. A des sourcils et des cheveux.','de':'Halbzeit! Kann schlucken. Hat Augenbrauen und Haare.'}),
  21: WeekInfo(week: 21, fruitEmoji: '🥕', size: '27 cm', weight: '360 g',
    fruits: {'es':'zanahoria','en':'carrot','ja':'ニンジン','it':'carota','fr':'carotte','de':'Karotte'},
    developments: {'es':'Las papilas gustativas funcionan. Ciclos de sueño y vigilia.','en':'Taste buds work. Sleep and wake cycles begin.','ja':'味蕾が機能します。睡眠・覚醒サイクルが始まります。','it':'Le papille gustative funzionano. Cicli sonno-veglia iniziano.','fr':'Les papilles gustatives fonctionnent. Cycles veille-sommeil commencent.','de':'Geschmacksknospen funktionieren. Schlaf-Wach-Zyklen beginnen.'}),
  22: WeekInfo(week: 22, fruitEmoji: '🍈', size: '28 cm', weight: '430 g',
    fruits: {'es':'papaya pequeña','en':'small papaya','ja':'小さなパパイヤ','it':'papaia piccola','fr':'petite papaye','de':'kleine Papaya'},
    developments: {'es':'El oído está completamente desarrollado. Responde a sonidos conocidos.','en':'Hearing fully developed. Responds to familiar sounds.','ja':'聴覚が完全に発達します。聞き慣れた音に反応します。','it':'L\'udito è completamente sviluppato. Risponde a suoni familiari.','fr':'L\'ouïe est complètement développée. Répond aux sons familiers.','de':'Gehör vollständig entwickelt. Reagiert auf vertraute Geräusche.'}),
  23: WeekInfo(week: 23, fruitEmoji: '🥭', size: '29 cm', weight: '500 g',
    fruits: {'es':'mango','en':'mango','ja':'マンゴー','it':'mango','fr':'mangue','de':'Mango'},
    developments: {'es':'Sus pulmones producen surfactante. Su cara está completamente formada.','en':'Lungs produce surfactant. Face is completely formed.','ja':'肺がサーファクタントを産生します。顔が完全に形成されます。','it':'I polmoni producono surfattante. Il viso è completamente formato.','fr':'Les poumons produisent du surfactant. Le visage est complètement formé.','de':'Lungen produzieren Surfactant. Gesicht vollständig geformt.'}),
  24: WeekInfo(week: 24, fruitEmoji: '🌽', size: '30 cm', weight: '600 g',
    fruits: {'es':'mazorca de maíz','en':'corn cob','ja':'トウモロコシ','it':'pannocchia','fr':'épi de maïs','de':'Maiskolben'},
    developments: {'es':'Viable fuera del útero con ayuda médica. El cerebro crece mucho.','en':'Viable outside womb with medical help. Brain grows fast.','ja':'医療の助けがあれば子宮外でも生存可能。脳が急成長します。','it':'Vitale fuori dall\'utero con assistenza medica. Il cervello cresce molto.','fr':'Viable hors de l\'utérus avec aide médicale. Le cerveau croît beaucoup.','de':'Lebensfähig mit medizinischer Hilfe. Gehirn wächst stark.'}),
  25: WeekInfo(week: 25, fruitEmoji: '🥦', size: '34 cm', weight: '660 g',
    fruits: {'es':'coliflor','en':'cauliflower','ja':'カリフラワー','it':'cavolfiore','fr':'chou-fleur','de':'Blumenkohl'},
    developments: {'es':'Responde a tu voz. Sus huesos se están endureciendo.','en':'Responds to your voice. Bones are hardening.','ja':'あなたの声に反応します。骨が固くなっています。','it':'Risponde alla tua voce. Le ossa si stanno indurendo.','fr':'Répond à ta voix. Les os se durcissent.','de':'Reagiert auf deine Stimme. Knochen härten sich.'}),
  26: WeekInfo(week: 26, fruitEmoji: '🥬', size: '36 cm', weight: '760 g',
    fruits: {'es':'lechuga romana','en':'romaine lettuce','ja':'ロメインレタス','it':'lattuga romana','fr':'laitue romaine','de':'Römersalat'},
    developments: {'es':'Sus ojos pueden abrirse. El cerebro registra el tacto y el dolor.','en':'Eyes can open. Brain registers touch and pain.','ja':'目が開けます。脳が触覚と痛みを感知します。','it':'Gli occhi possono aprirsi. Il cervello registra tatto e dolore.','fr':'Les yeux peuvent s\'ouvrir. Le cerveau enregistre le toucher et la douleur.','de':'Augen können sich öffnen. Gehirn registriert Berührung und Schmerz.'}),
  27: WeekInfo(week: 27, fruitEmoji: '🥦', size: '37 cm', weight: '900 g',
    fruits: {'es':'coliflor','en':'cauliflower','ja':'カリフラワー','it':'cavolfiore','fr':'chou-fleur','de':'Blumenkohl'},
    developments: {'es':'Duerme y se despierta con regularidad. Puede reconocer tu voz y la de papá.','en':'Sleeps and wakes regularly. Can recognize your voice and dad\'s.','ja':'規則的に眠り目を覚まします。あなたの声を認識できます。','it':'Dorme e si sveglia regolarmente. Può riconoscere la tua voce.','fr':'Dort et se réveille régulièrement. Reconnaît ta voix.','de':'Schläft und wacht regelmäßig. Kann deine Stimme erkennen.'}),
  28: WeekInfo(week: 28, fruitEmoji: '🍆', size: '38 cm', weight: '1 kg',
    fruits: {'es':'berenjena','en':'eggplant','ja':'ナス','it':'melanzana','fr':'aubergine','de':'Aubergine'},
    developments: {'es':'Parpadea y sueña. Sus pulmones están casi listos.','en':'Blinks and dreams. Lungs are almost ready.','ja':'瞬きし夢を見ます。肺はほぼ準備完了です。','it':'Sbatte le palpebre e sogna. I polmoni sono quasi pronti.','fr':'Cligne des yeux et rêve. Les poumons sont presque prêts.','de':'Blinzelt und träumt. Lungen sind fast fertig.'}),
  29: WeekInfo(week: 29, fruitEmoji: '🎃', size: '39 cm', weight: '1.15 kg',
    fruits: {'es':'butternut squash','en':'butternut squash','ja':'バターナッツかぼちゃ','it':'zucca butternut','fr':'courge butternut','de':'Butternusskürbis'},
    developments: {'es':'Los músculos y pulmones maduran. Puede patear fuerte.','en':'Muscles and lungs mature. Can kick hard.','ja':'筋肉と肺が成熟します。強く蹴れます。','it':'Muscoli e polmoni maturano. Può calciare forte.','fr':'Muscles et poumons maturent. Peut donner de forts coups de pied.','de':'Muskeln und Lungen reifen. Kann kräftig treten.'}),
  30: WeekInfo(week: 30, fruitEmoji: '🥬', size: '40 cm', weight: '1.3 kg',
    fruits: {'es':'repollo','en':'cabbage','ja':'キャベツ','it':'cavolo cappuccio','fr':'chou','de':'Kohl'},
    developments: {'es':'Su cerebro se arruga para ganar más superficie. Distingue luz y oscuridad.','en':'Brain folds to gain surface area. Can tell light from dark.','ja':'脳が表面積を増やすためにしわになります。明暗の区別ができます。','it':'Il cervello si increspa per guadagnare superficie. Distingue luce e buio.','fr':'Le cerveau se plisse pour gagner de la surface. Distingue lumière et obscurité.','de':'Gehirn faltet sich für mehr Oberfläche. Unterscheidet Hell und Dunkel.'}),
  31: WeekInfo(week: 31, fruitEmoji: '🥥', size: '41 cm', weight: '1.5 kg',
    fruits: {'es':'coco','en':'coconut','ja':'ヤシの実','it':'noce di cocco','fr':'noix de coco','de':'Kokosnuss'},
    developments: {'es':'Todos los sentidos funcionan. Procesa información del entorno.','en':'All senses work. Processes information from surroundings.','ja':'すべての感覚が機能します。周囲の情報を処理します。','it':'Tutti i sensi funzionano. Elabora informazioni dall\'ambiente.','fr':'Tous les sens fonctionnent. Traite les informations de l\'environnement.','de':'Alle Sinne funktionieren. Verarbeitet Umgebungsinformationen.'}),
  32: WeekInfo(week: 32, fruitEmoji: '🍠', size: '42 cm', weight: '1.7 kg',
    fruits: {'es':'jícama','en':'jicama','ja':'ヒカマ','it':'jicama','fr':'jicama','de':'Jicama'},
    developments: {'es':'Practica respirar y tragar. Su piel ya no es translúcida.','en':'Practices breathing and swallowing. Skin no longer translucent.','ja':'呼吸と飲み込みを練習します。皮膚がもう半透明ではありません。','it':'Pratica respirazione e deglutizione. La pelle non è più traslucida.','fr':'S\'entraîne à respirer et avaler. La peau n\'est plus translucide.','de':'Übt Atmen und Schlucken. Haut ist nicht mehr durchscheinend.'}),
  33: WeekInfo(week: 33, fruitEmoji: '🍍', size: '44 cm', weight: '1.9 kg',
    fruits: {'es':'piña pequeña','en':'small pineapple','ja':'小さなパイナップル','it':'ananas piccolo','fr':'petit ananas','de':'kleine Ananas'},
    developments: {'es':'Sus huesos se endurecen. El cerebro y el sistema nervioso maduran.','en':'Bones harden. Brain and nervous system mature.','ja':'骨が固くなります。脳と神経系が成熟します。','it':'Le ossa si induriscono. Cervello e sistema nervoso maturano.','fr':'Les os durcissent. Le cerveau et le système nerveux maturent.','de':'Knochen härten. Gehirn und Nervensystem reifen.'}),
  34: WeekInfo(week: 34, fruitEmoji: '🎃', size: '45 cm', weight: '2.1 kg',
    fruits: {'es':'calabaza acorn','en':'acorn squash','ja':'どんぐりかぼちゃ','it':'zucca ghianda','fr':'courge gland','de':'Eichelkürbis'},
    developments: {'es':'Su sistema inmune se fortalece. Acumula grasa para regular la temperatura.','en':'Immune system strengthens. Accumulates fat for temperature regulation.','ja':'免疫系が強くなります。体温調節のための脂肪を蓄えます。','it':'Il sistema immunitario si rafforza. Accumula grasso per la temperatura.','fr':'Le système immunitaire se renforce. Accumule de la graisse pour la température.','de':'Immunsystem stärkt sich. Sammelt Fett zur Temperaturregulierung.'}),
  35: WeekInfo(week: 35, fruitEmoji: '🍈', size: '46 cm', weight: '2.4 kg',
    fruits: {'es':'melón honeydew','en':'honeydew melon','ja':'ハニーデューメロン','it':'melone honeydew','fr':'melon honeydew','de':'Honigmelone'},
    developments: {'es':'Los riñones están completamente desarrollados. Posición de parto probable.','en':'Kidneys fully developed. Likely in birthing position.','ja':'腎臓が完全に発達します。おそらく出産位置に入っています。','it':'I reni sono completamente sviluppati. Probabilmente in posizione di parto.','fr':'Les reins sont pleinement développés. Probablement en position d\'accouchement.','de':'Nieren vollständig entwickelt. Wahrscheinlich in Geburtsposition.'}),
  36: WeekInfo(week: 36, fruitEmoji: '🥬', size: '47 cm', weight: '2.6 kg',
    fruits: {'es':'lechuga romana grande','en':'large romaine','ja':'大きなロメインレタス','it':'lattuga romana grande','fr':'grande laitue','de':'großer Römersalat'},
    developments: {'es':'Casi lista. Baja hacia la pelvis. Período neonatal temprano es seguro.','en':'Almost ready. Drops toward pelvis. Early neonatal period is safe.','ja':'もうすぐです。骨盤に下がります。早期新生児期は安全です。','it':'Quasi pronta. Scende verso il bacino. Il periodo neonatale precoce è sicuro.','fr':'Presque prête. Descend vers le bassin. La période néonatale précoce est sûre.','de':'Fast fertig. Senkt sich ins Becken. Frühe Neugeborenenzeit ist sicher.'}),
  37: WeekInfo(week: 37, fruitEmoji: '🥬', size: '48 cm', weight: '2.9 kg',
    fruits: {'es':'acelga','en':'Swiss chard','ja':'フダンソウ','it':'bietola','fr':'bette à carde','de':'Mangold'},
    developments: {'es':'A término temprano. Sus pulmones producen suficiente surfactante.','en':'Early term. Lungs produce enough surfactant.','ja':'早期正期産。肺が十分なサーファクタントを産生します。','it':'A termine precoce. I polmoni producono abbastanza surfattante.','fr':'Terme précoce. Les poumons produisent assez de surfactant.','de':'Frühes Termin. Lungen produzieren genug Surfactant.'}),
  38: WeekInfo(week: 38, fruitEmoji: '🧅', size: '49 cm', weight: '3.1 kg',
    fruits: {'es':'puerro','en':'leek','ja':'ネギ','it':'porro','fr':'poireau','de':'Lauch'},
    developments: {'es':'A término. Puede nacer cualquier día. Todo está listo.','en':'Full term. Can be born any day. Everything is ready.','ja':'正期産。いつでも生まれられます。すべて準備完了です。','it':'A termine. Può nascere qualsiasi giorno. Tutto è pronto.','fr':'À terme. Peut naître n\'importe quel jour. Tout est prêt.','de':'Termin. Kann jeden Tag geboren werden. Alles ist bereit.'}),
  39: WeekInfo(week: 39, fruitEmoji: '🍉', size: '50 cm', weight: '3.3 kg',
    fruits: {'es':'sandía pequeña','en':'small watermelon','ja':'小さなスイカ','it':'cocomero piccolo','fr':'petite pastèque','de':'kleine Wassermelone'},
    developments: {'es':'A término completo. Su cerebro sigue desarrollándose. Lista para el mundo.','en':'Full term. Brain continues developing. Ready for the world.','ja':'正期産。脳が発達し続けます。世界への準備完了です。','it':'A termine completo. Il cervello continua a svilupparsi. Pronta per il mondo.','fr':'À terme complet. Le cerveau continue de se développer. Prête pour le monde.','de':'Volles Termin. Gehirn entwickelt sich weiter. Bereit für die Welt.'}),
  40: WeekInfo(week: 40, fruitEmoji: '🎃', size: '51 cm', weight: '3.5 kg',
    fruits: {'es':'calabaza','en':'pumpkin','ja':'かぼちゃ','it':'zucca','fr':'citrouille','de':'Kürbis'},
    developments: {'es':'¡Fecha probable de parto! Lista para conocerte.','en':'Due date! Ready to meet you.','ja':'予定日！あなたに会う準備ができています。','it':'Data prevista del parto! Pronta a conoscerti.','fr':'Date prévue d\'accouchement ! Prête à te rencontrer.','de':'Voraussichtlicher Entbindungstermin! Bereit, dich kennenzulernen.'}),
  41: WeekInfo(week: 41, fruitEmoji: '🍉', size: '51 cm', weight: '3.6 kg',
    fruits: {'es':'sandía','en':'watermelon','ja':'スイカ','it':'cocomero','fr':'pastèque','de':'Wassermelone'},
    developments: {'es':'Post-término. El médico monitoreará de cerca. ¡Pronto!','en':'Post-term. Doctor will monitor closely. Coming soon!','ja':'過期産。医師が注意深く観察します。もうすぐです！','it':'Post-termine. Il medico monitorerà da vicino. Presto!','fr':'Post-terme. Le médecin surveillera de près. Bientôt !','de':'Überfällig. Arzt beobachtet genau. Bald!'}),
  42: WeekInfo(week: 42, fruitEmoji: '🎃', size: '51 cm', weight: '3.7 kg',
    fruits: {'es':'calabaza grande','en':'large pumpkin','ja':'大きなかぼちゃ','it':'grande zucca','fr':'grande citrouille','de':'großer Kürbis'},
    developments: {'es':'Post-término. Inducción probable. ¡Ya viene!','en':'Post-term. Induction likely. Coming any moment!','ja':'過期産。誘発分娩の可能性があります。もうすぐ来ます！','it':'Post-termine. Induzione probabile. Sta arrivando!','fr':'Post-terme. Déclenchement probable. Il/elle arrive !','de':'Überfällig. Einleitung wahrscheinlich. Kommt gleich!'}),
};

WeekInfo? getWeekInfo(int week) => pregnancyData[week];

int getCurrentPregnancyWeek(DateTime dueDate) {
  final now = DateTime.now();
  final daysUntilDue = dueDate.difference(now).inDays;
  final weeksUntilDue = (daysUntilDue / 7).ceil();
  return 40 - weeksUntilDue;
}
