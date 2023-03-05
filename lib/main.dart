import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



// import your image asset here
//import 'assets/images/blackngrey.png';

void main() {
  runApp(MyApp());
}

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      title: Text(title, style: TextStyle(color: Colors.black)),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Creating a Tattoo Design',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Set the initial route to the introduction page
      initialRoute: '/introduction',
      routes: {
        // Define your routes here, including the introduction page
        '/introduction': (context) => IntroductionPage(),
        '/home': (context) => MyHomePage(title: 'Creating a Tattoo Design'),
      },
    );
  }
}


class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Tattoist AI'),
      body: Container(
        //color: Colors.blue,
        child: Center(
          child: Text(
            'Welcome to My Tattoo Design App!',
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MyHomePage(title: 'Creating a Tattoo Design')),
            );
          },
          child: Text('Get Started'),
        ),
      ),
    );
  }
}



   

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _designDescription = '';
  List<bool> _tattooStyleSelections = List.filled(10, false);
  bool _blackAndWhiteSelected = true;
  String _artStyleInput = '';

  void _createTattooDesign() {
    print('Design Description: $_designDescription');
    print('Tattoo Style Selections: $_tattooStyleSelections');
    print(
        'Color Selection: ${_blackAndWhiteSelected ? 'Black & White' : 'Color'}');
    print('Art Style Input: $_artStyleInput');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Tattoist AI'),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                  child: Text(
                    'Creating a tattoo design',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Please write a description of the design',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      _designDescription = text;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      10,
                      (index) => CheckboxListTile(
                        title: Text('Tattoo Style ${index + 1}'),
                        value: _tattooStyleSelections[index],
                        onChanged: (value) {
                          setState(() {
                            _tattooStyleSelections[index] = value ?? false;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Text('Color Selection:'),
                      SizedBox(width: 16),
                      ChoiceChip(
                        label: Text('Black & White'),
                        selected: _blackAndWhiteSelected,
                        onSelected: (selected) {
                          setState(() {
                            _blackAndWhiteSelected = selected;
                          });
                        },
                      ),
                      SizedBox(width: 16),
                      ChoiceChip(
                        label: Text('Color'),
                        selected: !_blackAndWhiteSelected,
                        onSelected: (selected) {
                          setState(() {
                            _blackAndWhiteSelected = !selected;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:
                          'If you have a desired artist style, please write it down',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      _artStyleInput = text;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: _createTattooDesign,
                    child: Text('Create tattoo design'),
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
