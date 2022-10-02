import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expansion Panel Demonstration App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExpansionPanelScreen(),
    );
  }
}

class ExpansionPanelScreen extends StatefulWidget {
  const ExpansionPanelScreen({Key? key}) : super(key: key);

  @override
  State<ExpansionPanelScreen> createState() => _ExpansionPanelScreenState();
}

class _ExpansionPanelScreenState extends State<ExpansionPanelScreen> {
  List<bool> isOpenList = List.filled(7, false);

  ExpansionPanel expansionPanel(int index, String name, String description) {
    return ExpansionPanel(
      isExpanded: isOpenList[index],
      headerBuilder: (context, _) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          description,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expansion Panel Demo"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expandedHeaderPadding: EdgeInsets.zero,
          expansionCallback: (index, isOpen) {
            setState(() {
              isOpenList[index] = !isOpen;
            });
          },
          children: [
            expansionPanel(0, "Taj Mahal",
                "Nestled on the banks of the Yamuna river, Taj Mahal was constructed by the Mughal Emperor Shah Jahan in reminiscence of his most endeared wife Mumtaz Mahal. Being shattered by the death of his beloved wife, Shah Jahan decided to construct a domicile for the entombed. The grief of this Shah Jahan led to the formation of the glorious monument of Taj mahal. This ivory-white structure is thronged by its admirers from all over the world. Taj Mahal is an epitome of love, the beauty of which is more arresting during the sunrise and on a full moon night. Being built with the skillfulness of around 20000 artizans, Taj Mahal is the pinnacle spot in the city of Agra, India."),
            expansionPanel(1, "Great Wall of China",
                "This awe-inspiring structure is a belt of around 21,196 kilometers from east to west, witnessing the highlands, landscapes, plateaus, and other charms of China. This wall was constructed to protect the Chinese Empire from the assaults and invasions of the nomadic groups. The credit for the brawniness of this archeological grandeur goes to the robust stones, bricks, soil, wood, and other materials used for its construction. This monument symbolizes the strength and dexterity of the artisans in the bygone times. Being swarmed by its admirers from every nook of the world, the Great Wall of China stands tall to inspire the generations to come."),
            expansionPanel(2, "Christ the Redeemer",
                "The statue of the God of the Christians in Brazil, has a towering height of 98 feet. Being an embodiment of the Brazilian Christianity, this wonder of the world is the most groovy structure in Rio de Janerio, Brazil. The reason behind the unconventional strength of this structure is the adoption of reinforced concrete and soapstone for its construction. You would be astounded to know that this stupendous edifice was engineered in pieces and then taken on the top of a mountain for compilation. The statue of Jesus Christ embracing the entire world is venerated not only by the Christians, but the people belonging to other religions as well."),
            expansionPanel(3, "The Colosseum",
                "The center of the Rome accommodates the spectacular structure of the largest amphitheatre in the world, a.k.a., The Colosseum. It depicts the finesse of the engineering works during the Roman Empire. This otherworldly edifice took 9 years to get completed. If we think of mastering a structure of such massive expanse with all the contemporary methods, wistfully, we would fail to meet the deadlines confronted by the adept architects of those times. This amphitheatre witnessed a plethora of capital punishments and battles, that led to the death of around 400,000 people inside this structure. This structure has been a beholder of several events, shows, contests, and much more. And Mr. Moviebuff, you would be amazed to know that the climax scene of the epic movie Gladiator was shot nowhere else than The Colosseum."),
            expansionPanel(4, "Machu Picchu",
                "Hemmed in the midst of the beauteous hillocks and glittering meadows, the Lost City of the Incas, a.k.a Machu Picchu, dates back to the 15th century. The mind-bending structure of this one of the most amazing seven wonders of the world is composed of the dry-stone walls. The preeminent structures of the Machu Picchu comprise of the Inti Watana, The Temple of the Sun, and the Room of the Three Windows. To beckon the tourists and bestow a better picture regarding the origination of this wonder, most of the structures have been revamped by the year 1976."),
            expansionPanel(5, "Chichen Itza",
                "The step-pyramid structure of Chichen Itza is a treat to the eyes of the admirers of the archeology. This historical site it tyrannized by the Temple of Kukulcan, stationed at its center. This four-sided pyra mid subsumes a total of 365 steps. Globe-trotters from miles away, travel to Mexico specially for covering one of the seven wonders of the world. This Maya City encompasses some of the most popular buildings, like The Warriors Temple, El Castillo, and the Great Ball Court. The nights of this city are illuminated by the crowd-pleasing light & sound shows."),
            expansionPanel(6, "Petra",
                "This man-made marvel was erected out of pink-colored sandstones, due to which it has been designated as the Rose City. Being established as early as 312 BC, Petra is regarded as half as old as time. Undoubtedly, Petra is one of the most treasured attractions in Jordan. This wonder of the world houses a number of tombs and temples, which are profusely revered by the wayfarers. Petra has also won a position in the Smithsonian Magazine, as one of the 28 places to see before you die. The jaw-dropping architecture of Petra will surely leave you in awe of the creators."),
          ],
        ),
      ),
    );
  }
}
