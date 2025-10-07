import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
// For the To do task hint: consider defining the widget and name of the tabs here
    final tabs = ['Tab 1', 'Tab 2', 'Tab 3'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Tabs Demo',
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
// hint for the to do task:Considering creating the different for different tabs
          Container(
            
            decoration: BoxDecoration(
              image: DecorationImage(
                image:AssetImage('images/haunted_house.jpg'),
                fit: BoxFit.cover,
            
              ),
            ),
            child: Stack(
              children: [ 
                Positioned(
                  right: 40,
                  top: 60,
                  width: 100,
                  height: 200,
                  child: Image.asset('images/ghoul.webp')
                ),
                Positioned(
                  left: 50,
                  top: 90,
                  width: 100,
                  height: 200,
                  child: Image.asset('images/ghoul.webp')
                ),
                Positioned(
                  right: 30,
                  top: 200,
                  width: 100,
                  height: 200,
                  child: Image.asset('images/bat.webp')
                ),
                Positioned(
                  right: 200,                  
                  top: 30,
                  width: 100,
                  height: 200,
                  child: Image.asset('images/bat.webp')
                ),
                Positioned(
                  left: 40,
                  bottom: 30,
                  width: 200,
                  height: 100,
                  child: Image.asset('images/tombstone.webp')
                ), 
              ],
            ),
            
          ),
        
          
          Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:AssetImage('assets/images/haunted_house.jpg'),
                  fit: BoxFit.cover,
              ),
            ),  
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:AssetImage('assets/images/haunted_house.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
