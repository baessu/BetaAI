import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

//import 'package:flutter/widgets.dart';

// import your image asset here
//import 'assets/images/blackngrey.png';
int? _selectedTattooStyleIndex;

class TattooStyle {
  final String name;
  final String imageAsset;

  TattooStyle(this.name, this.imageAsset);
}

final _tattooStyles = [
  TattooStyle('올드스쿨 타투', 'assets/images/oldschool.png'),
  TattooStyle('뉴스쿨 타투', 'assets/images/newschool.png'),
  TattooStyle('미니 타투', 'assets/images/mini.png'),
  TattooStyle('낙서 타투', 'assets/images/doodle.png'),
  TattooStyle('레터링 타투', 'assets/images/lettering.png'),
  TattooStyle('트라이벌 타투', 'assets/images/tribal.png'),
  TattooStyle('감성 타투', 'assets/images/gamsung.png'),
  TattooStyle('이레즈미 타투', 'assets/images/irezmi.png'),
  TattooStyle('라인워크 타투', 'assets/images/line.png'),
  TattooStyle('블랙앤 그레이 타투', 'assets/images/blackngrey.png'),
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
