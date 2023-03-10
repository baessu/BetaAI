import 'dart:math';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:gallery_saver/gallery_saver.dart';


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

bool _isLoading = false;
Image? _finalImage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
  runApp(MyApp());
}

Future<Image> generateTattooDesign(
  String designDescription,
  String tattooStyle,
  bool blackAndWhiteSelected,
  String artStyleInput,
) async {
  String prompt = '$designDescription %20$tattooStyle%20$artStyleInput';
  String seed = Random().nextInt(1000000000).toString();
  String steps = "30";
  String cfgScale = "8.0";
  String width = "512";
  String height = "512";
  String samples = "1";
  String colorMode = blackAndWhiteSelected ? "black_and_white" : "color";

  String url =
      "http://34.202.158.110:8000/generate/?prompt=sheet for tattoo%20$prompt&seed=$seed&steps=$steps&cfg_scale=$cfgScale&width=$width&height=$height&samples=$samples&color_mode=$colorMode";

  http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    List<dynamic> res = jsonDecode(response.body);
    Uint8List bytes = base64.decode(res.first);
    return Image.memory(bytes, fit: BoxFit.contain);
  } else {
    throw Exception('Failed to generate tattoo design.');
  }
}

int _selectedTattooStyleIndex = 0;

class TattooStyle {
  final String name;
  final String imageAsset;

  TattooStyle(this.name, this.imageAsset);
}

final _tattooStyles = [
  TattooStyle('old school tattoo', 'assets/images/oldschool.png'),
  TattooStyle('new school tattoo', 'assets/images/newschool.png'),
  TattooStyle('little and minimal tattoo', 'assets/images/mini.png'),
  TattooStyle('cute and funny tattoo', 'assets/images/doodle.png'),
  TattooStyle('lettering tattoo', 'assets/images/lettering.png'),
  TattooStyle('Tribal tattoo', 'assets/images/tribal.png'),
  TattooStyle('watercolor tattoo', 'assets/images/gamsung.png'),
  TattooStyle('Irezumi tattoo', 'assets/images/irezmi.png'),
  TattooStyle('line work tattoo', 'assets/images/line.png'),
  TattooStyle('Black and gray tattoo', 'assets/images/blackngrey.png'),
];

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      elevation: 1,
      iconTheme: IconThemeData(color: Colors.black),
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
                    padding:
                        EdgeInsets.only(bottom: 120.0, right: 40.0, left: 40.0),
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
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyHomePage(title: 'My App')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF222222),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            child: Text(
                              '타투 도안 제작하러 가기',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
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
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyHomePage(title: 'My App')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF222222),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            child: Text(
                              '타투 도안 제작하러 가기',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
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

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Tattoo Genie'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //CircularProgressIndicator(),
            LoadingAnimationWidget.inkDrop(
              color: Colors.black, 
              size: 50,
            ),
            SizedBox(height: 24.0),
            Text('AI가 타투도안을 생성하고 있습니다. \n 이 페이지를 벗어나지 마세요.',textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final List<Image> images;

  ResultPage(this.images);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Tattoo Genie'),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            children: List.generate(images.length, (index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(13.0),
                child: images[index],
              );
            }),
          ),
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

  void _createTattooDesign() async {
    // Navigate to the loading page
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => LoadingPage()));

    // Generate the images
    final images = await Future.wait([
      generateTattooDesign(
          _designDescription,
          _tattooStyles[_selectedTattooStyleIndex].name as String,
          _blackAndWhiteSelected as bool,
          _artStyleInput as String),
      generateTattooDesign(
          _designDescription,
          _tattooStyles[_selectedTattooStyleIndex + 1].name as String,
          _blackAndWhiteSelected as bool,
          _artStyleInput as String),
      generateTattooDesign(
          _designDescription,
          _tattooStyles[_selectedTattooStyleIndex + 2].name as String,
          _blackAndWhiteSelected as bool,
          _artStyleInput as String),
      generateTattooDesign(
          _designDescription,
          _tattooStyles[_selectedTattooStyleIndex + 3].name as String,
          _blackAndWhiteSelected as bool,
          _artStyleInput as String),
      generateTattooDesign(
          _designDescription,
          _tattooStyles[_selectedTattooStyleIndex + 4].name as String,
          _blackAndWhiteSelected as bool,
          _artStyleInput as String),
    ]);

    // Navigate to the result page
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ResultPage(images as List<Image>)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(title: 'Tattoo Genie'),
        body: Padding(
          padding: EdgeInsets.only(top: 24),
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.6),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(13.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        '타투 도안 제작하기',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Text(
                        '도안설명을 적어주세요',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '예시) 검은 고양이와 파란색 나비',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (text) {
                          _designDescription = text;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                      child: Text(
                        '타투 스타일을 선택해주세요',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          final double maxWidth = constraints.maxWidth;
                          double spacing = 8;
                          double runSpacing = 8;
                          int itemCountPerRow = 3;
                          if (maxWidth < 450) {
                            itemCountPerRow = 2;
                            spacing = 16;
                            runSpacing = 16;
                          } else if (maxWidth < 650) {
                            itemCountPerRow = 3;
                            spacing = 16;
                            runSpacing = 16;
                          } else if (maxWidth < 800) {
                            itemCountPerRow = 4;
                            spacing = 32;
                            runSpacing = 32;
                          } else {
                            itemCountPerRow = 5;
                            spacing = 32;
                            runSpacing = 32;
                          }
                          return Wrap(
                            spacing: spacing,
                            runSpacing: runSpacing,
                            children: List.generate(
                              _tattooStyles.length,
                              (index) {
                                final style = _tattooStyles[index];

                                return SizedBox(
                                  width: (maxWidth -
                                          (itemCountPerRow + 1) * spacing) /
                                      itemCountPerRow,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _selectedTattooStyleIndex = index;
                                          });
                                        },
                                        child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image:
                                                  AssetImage(style.imageAsset),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(60),
                                            border: Border.all(
                                              color:
                                                  _selectedTattooStyleIndex ==
                                                          index
                                                      ? Colors.black
                                                      : Colors.grey
                                                          .withOpacity(0.6),
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        style.name,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              _selectedTattooStyleIndex == index
                                                  ? Colors.black
                                                  : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                      child: Text(
                        '타투 색상을 선택해주세요',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: SizedBox(
                              height: 40,
                              child: ChoiceChip(
                                label: Text(
                                  '블랙 앤 화이트',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _blackAndWhiteSelected
                                        ? Colors.white
                                        : Color(0xFF222222),
                                  ),
                                ),
                                selected: _blackAndWhiteSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    _blackAndWhiteSelected = selected;
                                  });
                                },
                                selectedColor: Color(0xFF222222),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: SizedBox(
                              height: 40,
                              child: ChoiceChip(
                                label: Text(
                                  '컬러',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: !_blackAndWhiteSelected
                                        ? Colors.white
                                        : Color(0xFF222222),
                                  ),
                                ),
                                selected: !_blackAndWhiteSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    _blackAndWhiteSelected = !selected;
                                  });
                                },
                                selectedColor: Color(0xFF222222),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
                      child: Text(
                        '원하는 아티스트 스타일이 있다면 적어주세요',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '예시) 반고흐',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (text) {
                          _artStyleInput = text;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _createTattooDesign,
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(
                                double.infinity, 42)), // Set the button size
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF222222)), // Set the background color
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          child: Text(
                            '타투 도안 생성하기',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}