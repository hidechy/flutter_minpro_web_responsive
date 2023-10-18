// ignore_for_file: use_colored_box, always_declare_return_types

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _pages = [
    const NormalPage(),
    const ShowDialogPage(),
    const WillPopPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (selectedIndex) {
          setState(() {
            _currentIndex = selectedIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.ad_units), label: 'Normal'),
          BottomNavigationBarItem(icon: Icon(Icons.zoom_in), label: 'Dialog'),
          BottomNavigationBarItem(icon: Icon(Icons.nat), label: 'WillPop'),
        ],
      ),
    );
  }
}

//------- １．Normal -------

class NormalPage extends StatelessWidget {
  const NormalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Center(
        child: ElevatedButton(
          onPressed: () => _openNormalScreen(context),
          child: const Text('NormalScreenを開く'),
        ),
      ),
    );
  }

  _openNormalScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NormalScreen(),
      ),
    );
  }
}

class NormalScreen extends StatelessWidget {
  const NormalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text('NormalScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _closeNormalScreen(context),
          child: const Text('もどる'),
        ),
      ),
    );
  }

  _closeNormalScreen(BuildContext context) {
    Navigator.pop(context);
  }
}

//------- ２．Dialog -------
class ShowDialogPage extends StatelessWidget {
  const ShowDialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
          ),
          onPressed: () => _openDialog(context),
          child: const Text('Dialogを開く'),
        ),
      ),
    );
  }

  _openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ダイアログ'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('とじる'),
          ),
        ],
      ),
    );
  }
}

//------- ３．WillPop -------
class WillPopPage extends StatelessWidget {
  const WillPopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          onPressed: () => _openWillPopScreen(context),
          child: const Text('WillPopScreenを開く'),
        ),
      ),
    );
  }

  _openWillPopScreen(BuildContext context) {
    Navigator.push(
      context,
      //Screenを開く際に値渡し
      MaterialPageRoute(
        builder: (_) => const WillPopScreen(
          param: '渡された値',
        ),
      ),
    );
  }
}

class WillPopScreen extends StatelessWidget {
  const WillPopScreen({super.key, required this.param});

  final String param;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //https://api.flutter.dev/flutter/widgets/WillPopScope-class.html
      onWillPop: () => _confirmCloseScreen(context),
      child: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          title: const Text('WillPopScreen'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Text(
            param,
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmCloseScreen(BuildContext context) async {
    final isConfirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('画面を閉じていいですか？'),
        actions: [
          TextButton(
            onPressed: () {
              //ダイアログを閉じて戻り値を返している
              // （onWillPopの戻り値がtrueになるのでit's OK to call [Navigator.pop]）
              Navigator.pop(context, true);
            },
            child: const Text('閉じる'),
          ),
          TextButton(
            onPressed: () {
              //ダイアログを閉じて戻り値を返している
              // （onWillPopの戻り値がfalseになるのでNavigator.popが発動されない）
              Navigator.pop(context, false);
            },
            child: const Text('キャンセル'),
          ),
        ],
      ),
    );
    return isConfirmed;
  }
}
