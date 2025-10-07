import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spooktacular Storybook',
      home: DefaultTabController(
        length: 3,
        child: const StoryTabs(),
      ),
    );
  }
}

//-------------------------------------------------------------//
//  MAIN TAB CONTROLLER
//-------------------------------------------------------------//
class StoryTabs extends StatelessWidget {
  const StoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spooktacular Storybook'),
        backgroundColor: Colors.deepPurple,
        bottom: const TabBar(
          tabs: [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          PartnerScene(),   // 👻 Tab 1: Haunted House
          WerewolfScene(),  // 🐺 Tab 2: Werewolf
          DraculaScene(),   // 🧛 Tab 3: Dracula
        ],
      ),
    );
  }
}

//-------------------------------------------------------------//
//  👻 TAB 1 — Haunted House (uses ghoul.webp, bat, cross)
//-------------------------------------------------------------//
class PartnerScene extends StatefulWidget {
  const PartnerScene({super.key});

  @override
  State<PartnerScene> createState() => _PartnerSceneState();
}

class _PartnerSceneState extends State<PartnerScene> {
  bool ghostVisible = false;
  bool batVisible = false;
  bool crossGlow = false;

  void toggleGhost() {
    setState(() => ghostVisible = !ghostVisible);
  }

  void flyBat() {
    setState(() => batVisible = true);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() => batVisible = false);
    });
  }

  void activateCross() {
    setState(() => crossGlow = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => crossGlow = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 🏚️ Background
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/haunted_house.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // 👻 Ghost (from ghoul.webp)
        AnimatedOpacity(
          opacity: ghostVisible ? 1.0 : 0.0,
          duration: const Duration(seconds: 2),
          child: Image.asset('assets/ghoul.webp', width: 180),
        ),

        // 🦇 Bat (flies briefly)
        if (batVisible)
          Positioned(
            left: 40,
            top: 120,
            child: AnimatedOpacity(
              opacity: batVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 800),
              child: Image.asset('assets/bat.png', width: 100),
            ),
          ),

        // ✝️ Silver Cross Trap (glows briefly)
        Positioned(
          right: 40,
          bottom: 60,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              boxShadow: crossGlow
                  ? [BoxShadow(color: Colors.redAccent.withOpacity(0.9), blurRadius: 25)]
                  : [],
            ),
            child: GestureDetector(
              onTap: activateCross,
              child: Image.asset('assets/silver_cross.png', width: 90),
            ),
          ),
        ),

        // 🎃 Buttons
        Positioned(
          bottom: 30,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: toggleGhost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[800],
                ),
                child: const Text("Summon the Ghoul"),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: flyBat,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple[800],
                ),
                child: const Text("Release the Bat"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//-------------------------------------------------------------//
//  🐺 TAB 2 — Werewolf Transformation
//-------------------------------------------------------------//
class WerewolfScene extends StatefulWidget {
  const WerewolfScene({super.key});
  @override
  State<WerewolfScene> createState() => _WerewolfSceneState();
}

class _WerewolfSceneState extends State<WerewolfScene> {
  int stage = 0;
  bool trapActivated = false;

  void nextStage() {
    if (stage < 2) setState(() => stage++);
  }

  void triggerTrap() {
    setState(() => trapActivated = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => trapActivated = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/man.png',
      'assets/partial.png',
      'assets/werewolf.png',
    ];

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/forest_night.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        AnimatedPositioned(
          top: stage == 2 ? 60 : 400,
          duration: const Duration(seconds: 3),
          child: Image.asset('assets/moon.png', width: 130),
        ),
        GestureDetector(
          onTap: nextStage,
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 2),
            child: Image.asset(
              images[stage],
              key: ValueKey(stage),
              width: 250,
            ),
          ),
        ),
        Positioned(
          left: 40,
          bottom: 80,
          child: GestureDetector(
            onTap: triggerTrap,
            child: Image.asset('assets/silver_cross.png', width: 80),
          ),
        ),
        if (trapActivated)
          Container(
            color: Colors.black.withOpacity(0.7),
            alignment: Alignment.center,
            child: const Text(
              "The silver cross burns!",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        Positioned(
          bottom: 40,
          child: AnimatedOpacity(
            opacity: stage == 2 ? 1.0 : 0.0,
            duration: const Duration(seconds: 2),
            child: const Text(
              '"Under the full moon... the beast awakens."',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//-------------------------------------------------------------//
//  🧛 TAB 3 — Dracula Scene
//-------------------------------------------------------------//
class DraculaScene extends StatefulWidget {
  const DraculaScene({super.key});
  @override
  State<DraculaScene> createState() => _DraculaSceneState();
}

class _DraculaSceneState extends State<DraculaScene> {
  int stage = 0;
  bool batVisible = false;

  void nextStage() {
    if (stage < 2) {
      setState(() => stage++);
      if (stage == 2) {
        batVisible = true;
        Future.delayed(const Duration(seconds: 3), () {
          setState(() => batVisible = false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> draculaStages = [
      'assets/dracula_coffin.png',
      'assets/dracula_rising.png',
      'assets/dracula_vampire.png',
    ];

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/castle_interior.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        AnimatedPositioned(
          top: stage == 2 ? 50 : 450,
          duration: const Duration(seconds: 3),
          child: Image.asset('assets/moon.png', width: 120),
        ),
        GestureDetector(
          onTap: nextStage,
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 2),
            child: Image.asset(
              draculaStages[stage],
              key: ValueKey(stage),
              width: 260,
            ),
          ),
        ),
        if (batVisible)
          Positioned(
            right: 30,
            top: 100,
            child: AnimatedOpacity(
              opacity: batVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: Image.asset('assets/bat.png', width: 70),
            ),
          ),
        Positioned(
          bottom: 40,
          child: AnimatedOpacity(
            opacity: stage == 2 ? 1.0 : 0.0,
            duration: const Duration(seconds: 2),
            child: const Text(
              '"Dracula rises once more under the full moon."',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
