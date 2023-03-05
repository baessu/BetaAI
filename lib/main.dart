import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
      elevation: 1,
      title: Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      ),
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
      appBar: MyAppBar(title: 'Tattoo Genie'),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 800) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Image.asset(
                      'assets/images/main.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32.0),
                        Text(
                          'AI Tattoo Generation',
                          style: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'AI로 원하는 타투 도안을 제작해보세요.',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 32.0),
                        Text(
                          '만들고 싶은 타투 도안이 있는데 그림 실력 때문에 망설여지신다구요? 타투 지니로 손쉽게 도안을 제작해보세요. 입력한 키워드와 스타일에 맞춰서 20개 이상의 도안을 제공해드립니다.',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 32),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyHomePage(title: 'My App')),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              '타투 도안 제작하러 가기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Tattoo Generation',
                            style: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'AI로 원하는 타투 도안을 제작해보세요.',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 32.0),
                          Text(
                            '만들고 싶은 타투 도안이 있는데 그림 실력 때문에 망설여지신다구요? 타투 지니로 손쉽게 도안을 제작해보세요. 입력한 키워드와 스타일에 맞춰서 20개 이상의 도안을 제공해드립니다.',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 32),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MyHomePage(title: 'My App')),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                '타투 도안 제작하러 가기',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        //height: 200.0,
                        child: Image.asset(
                          'assets/images/main.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              );
          }
        },
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
      appBar: MyAppBar(title: 'Tattoo Genie'),
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
