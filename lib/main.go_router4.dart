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

  static String normalMaster = 'normalMaster';
  static String normalDetail = 'normalDetail';

  static String dialogMaster = 'dialogMaster';
  static String confirmDialog = 'confirmDialog';

  static String willpopMaster = 'willpopMaster';
  static String willpopDetail = 'willpopDetail';
}

final _rootNavigateKey = GlobalKey<NavigatorState>();
final _shellNavigateKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigateKey,
  initialLocation: '/normal',
  routes: [
//    GoRoute(
    ShellRoute(
      // path: '/',
      // name: RouteNames.home,
      navigatorKey: _shellNavigateKey,
//      builder: (context, state) => const HomeScreen(),
      builder: (context, state, child) => HomeScreen(child: child),
      routes: [
        /*
        //url: /normal
        GoRoute(
          path: 'normal',
          name: RouteNames.normalDetail,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: NormalDetailScreen(),
              transitionDuration: const Duration(seconds: 2),
              transitionsBuilder: (context, firstAnimation, secondAnimation, child) {
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
          name: RouteNames.willpopDetail,
          builder: (context, state) => const WillPopDetailScreen(param: 'dummy'),
        ),

        GoRoute(
          path: 'confirmDialog',
          name: RouteNames.confirmDialog,
          pageBuilder: (context, state) {
            return CustomDialog(builder: (context) => const ConfirmDialog());
          },
        ),
*/
        ////////

        GoRoute(
          path: '/normal',
          name: RouteNames.normalMaster,
          builder: (context, state) => NormalMasterScreen(),
          routes: [
            GoRoute(
              path: 'detail',
              name: RouteNames.normalDetail,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: NormalDetailScreen(),
                  transitionDuration: const Duration(seconds: 2),
                  transitionsBuilder: (context, firstAnimation, secondAnimation, child) {
                    return RotationTransition(
                      turns: CurveTween(curve: Curves.bounceOut).animate(firstAnimation),
                      child: child,
                    );
                  },
                );
              },
            ),
          ],
        ),

        GoRoute(
          path: '/showDialog',
          name: RouteNames.dialogMaster,
          builder: (context, state) => const ShowDialogMasterScreen(),
          routes: [
            GoRoute(
              path: 'confirmDialog',
              name: RouteNames.confirmDialog,
              pageBuilder: (context, state) {
                return CustomDialogPage(builder: (context) => const ConfirmDialog());
              },
            ),
          ],
        ),

        GoRoute(
          path: '/willPop',
          name: RouteNames.willpopMaster,
          builder: (context, state) => const WillPopMasterScreen(),
          routes: [
            GoRoute(
              path: 'detail',
              name: RouteNames.willpopDetail,
              builder: (context, state) => const WillPopDetailScreen(param: 'dummy'),
            ),
          ],
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
  const HomeScreen({super.key, required this.child});

  final Widget child;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//  int _currentIndex = 0;

  // final _pages = [
  //   NormalMasterScreen(),
  //   const ShowDialogMasterScreen(),
  //   const WillPopMasterScreen(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _pages[_currentIndex],
      body: widget.child,

      bottomNavigationBar: BottomNavigationBar(
//        currentIndex: _currentIndex,
        currentIndex: _calcCurrentIndex(),

//

        // onTap: (selectedIndex) {
        //   setState(() {
        //     _currentIndex = selectedIndex;
        //   });
        // },

        onTap: (selectedIndex) => _onItemTapped(selectedIndex: selectedIndex),

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.ad_units), label: 'Normal'),
          BottomNavigationBarItem(icon: Icon(Icons.zoom_in), label: 'Dialog'),
          BottomNavigationBarItem(icon: Icon(Icons.nat), label: 'WillPop'),
        ],
      ),
    );
  }

  ///
  int _calcCurrentIndex() {
    final location = GoRouterState.of(context).matchedLocation;

    if (location.startsWith('/normal')) {
      return 0;
    } else if (location.startsWith('/showDialog')) {
      return 1;
    } else if (location.startsWith('/willPop')) {
      return 2;
    }

    return 0;
  }

  ///
  _onItemTapped({required int selectedIndex}) {
    switch (selectedIndex) {
      case 0:
        context.goNamed(RouteNames.normalMaster);
        break;
      case 1:
        context.goNamed(RouteNames.dialogMaster);
        break;
      case 2:
        context.goNamed(RouteNames.willpopMaster);
        break;
    }
  }
}

//------- １．Normal -------

// ignore: must_be_immutable
class NormalMasterScreen extends StatelessWidget {
  NormalMasterScreen({super.key});

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
    _context.goNamed(RouteNames.normalDetail);
  }
}

// ignore: must_be_immutable
class NormalDetailScreen extends StatelessWidget {
  NormalDetailScreen({super.key});

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

//    _context.goNamed(RouteNames.home);
    _context.goNamed(RouteNames.normalMaster);
  }
}

//------- ２．Dialog -------
class ShowDialogMasterScreen extends StatelessWidget {
  const ShowDialogMasterScreen({super.key});

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

//          onPressed: () => context.goNamed(RouteNames.home),
          onPressed: () => context.goNamed(RouteNames.dialogMaster),

          child: const Text('とじる'),
        ),
      ],
    );
  }
}

//------- ３．WillPop -------
class WillPopMasterScreen extends StatelessWidget {
  const WillPopMasterScreen({super.key});

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
        builder: (_) => const WillPopDetailScreen(
          param: '渡された値',
        ),
      ),
    );
  }
}

class WillPopDetailScreen extends StatelessWidget {
  const WillPopDetailScreen({super.key, required this.param});

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
