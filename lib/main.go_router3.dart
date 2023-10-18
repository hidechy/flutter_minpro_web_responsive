// ignore_for_file: use_colored_box, always_declare_return_types

import 'package:flutter/material.dart';

//

//import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:url_strategy/url_strategy.dart';
//

// ignore: directives_ordering
import 'package:go_router/go_router.dart';

import 'digression/custom_dialog_page.dart';

void main() {
//  usePathUrlStrategy();

  setPathUrlStrategy();

  runApp(const MyApp());
}

// ignore: avoid_classes_with_only_static_members
class RouteNames {
  static String home = 'home';
  static String normal = 'normal';
  static String willpop = 'willpop';
  static String confirmDialog = 'confirmDialog';
}

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
      routes: [
        //url: /normal
        GoRoute(
          path: 'normal',
          name: RouteNames.normal,
          // builder: (context, state) => NormalScreen(),
          //

          pageBuilder: (context, state) {
//            return NoTransitionPage(child: NormalScreen());
            //

            return CustomTransitionPage(
              key: state.pageKey,
              child: NormalScreen(),
              transitionDuration: const Duration(seconds: 2),
              transitionsBuilder: (context, firstAnimation, secondAnimation, child) {
                // return FadeTransition(
                //   opacity: CurveTween(curve: Curves.easeInOut).animate(firstAnimation),
                //   child: child,
                // );

                // return SlideTransition(
                //   position: firstAnimation.drive(
                //     Tween<Offset>(begin: const Offset(0.25, 0.25), end: Offset.zero)
                //         .chain(CurveTween(curve: Curves.elasticIn)),
                //   ),
                //   child: child,
                // );

                // return ScaleTransition(
                //   scale: CurveTween(curve: Curves.bounceIn).animate(firstAnimation),
                //   child: child,
                // );

                return RotationTransition(
                  turns: CurveTween(curve: Curves.bounceOut).animate(firstAnimation),
                  child: child,
                );
              },
            );
          },
        ),

        //url: /willpop
        GoRoute(
          path: 'willpop',
          name: RouteNames.willpop,
          builder: (context, state) => const WillPopScreen(param: 'dummy'),
        ),

        GoRoute(
          path: 'confirmDialog',
          name: RouteNames.confirmDialog,
          // builder: (context, state) {
          //   return const ConfirmDialog();
          // },

          pageBuilder: (context, state) {
            return CustomDialogPage(builder: (context) => const ConfirmDialog());
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: appRouter);
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
    NormalPage(),
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

// ignore: must_be_immutable
class NormalPage extends StatelessWidget {
  NormalPage({super.key});

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Container(
      color: Colors.blueAccent,
      child: Center(
        child: ElevatedButton(
          onPressed: _openNormalScreen,
          child: const Text('NormalScreenを開く'),
        ),
      ),
    );
  }

  _openNormalScreen() {
    _context.goNamed(RouteNames.normal);
  }
}

// ignore: must_be_immutable
class NormalScreen extends StatelessWidget {
  NormalScreen({super.key});

  late BuildContext _context;

  ///
  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text('NormalScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _closeNormalScreen,
          child: const Text('もどる'),
        ),
      ),
    );
  }

  _closeNormalScreen() {
//    Navigator.pop(context);

    _context.goNamed(RouteNames.home);
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
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       title: const Text('ダイアログ'),
    //       actions: [
    //         ElevatedButton(
    //           style: ElevatedButton.styleFrom(
    //             backgroundColor: Colors.redAccent,
    //           ),
    //           onPressed: () => Navigator.pop(context),
    //           child: const Text('とじる'),
    //         ),
    //       ],
    //     );
    //   },
    // );

    context.goNamed(RouteNames.confirmDialog);
  }
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('ダイアログ'),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
          ),
//          onPressed: () => Navigator.pop(context),

          onPressed: () => context.goNamed(RouteNames.home),

          child: const Text('とじる'),
        ),
      ],
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
