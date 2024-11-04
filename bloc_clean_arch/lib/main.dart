import 'package:bloc_clean_arch/api_apps/movie_api_call/data/local/movies_api_request_repo_implementation.dart';
import 'package:bloc_clean_arch/api_apps/movie_api_call/presentation/movie_screen.dart';
import 'package:bloc_clean_arch/api_apps/movie_api_call/presentation/movies_api_bloc/movies_bloc.dart';
import 'package:bloc_clean_arch/core/presentation/views_or_pages/all_apps_home_screen.dart';
import 'package:bloc_clean_arch/counter_apps/countdown_timer/presentation/count_down_screen.dart';
import 'package:bloc_clean_arch/counter_apps/countdown_timer/presentation/countdown_bloc_statemanagement/countdown_bloc.dart';
import 'package:bloc_clean_arch/counter_apps/counter_app/counter_cubit_bloc/counter_page.dart';
import 'package:bloc_clean_arch/config/firebase_options.dart';
import 'package:bloc_clean_arch/quiz_app/domain/quiz_bloc/quiz_bloc.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/home_screen.dart';
import 'package:bloc_clean_arch/quiz_app/presentation/quiz_screen_view.dart';
import 'package:bloc_clean_arch/simple_calculator_app_cubit_bloc/presentation/calc_view.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/themes/light_mode_theme.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/views/auth_page.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/views/login_page.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/views/register_page.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/social_app.dart';
import 'package:bloc_clean_arch/todo_app_cubit_bloc/data/local/model/isar_todo.dart';
import 'package:bloc_clean_arch/todo_app_cubit_bloc/data/repository/isar_todo_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';

import 'todo_app_cubit_bloc/domain/repoistory/todo_repo.dart';

void main() async {
  //Firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // //get directory path for storing the data
  // final dir = await getApplicationDocumentsDirectory();

  // // open isar db
  // final isar_as_db = await Isar.open([TodoIsarSchema], directory: dir.path);

  // //intialize the repo with isar db
  // final isarTodoRepo = IsarTodoRepo(isar_as_db);

  // run app
  // runApp(const MyApp(
  //     //todoRepo: isarTodoRepo
  //     ));
  //runApp(const SocialApp());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
// db injection through the app
  //final TodoRepo todoRepo;
  const MyApp({
    super.key, //required this.todoRepo
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final movieRepo = MoviesApiRequestRepoImplementation();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      // home: BlocProvider<QuizBloc>(
      //   create: (context) => QuizBloc(),
      //   child: const QuizHomeScreen(),
      // ),
      //home: const AuthPage(),
      home: BlocProvider(
        create: (context) => MoviesBloc(movieRepo),
        child: const AllAppsHomeScreen(),
      ),
    );
  }
}



// class MyApp extends StatefulWidget {

//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _incrementCounter();
//           Fluttertoast.showToast(
//               msg: '${_counter}',
//               //  toastLength: Toast.LENGTH_LONG,
//               // gravity: ToastGravity.CENTER,
//               timeInSecForIosWeb: 1,
//               backgroundColor: Colors.red,
//               textColor: Colors.white,
//               fontSize: 16.0);
//           // Fluttertoast.showToast(
//           //     msg: "${_counter}",
//           //     toastLength: Toast.LENGTH_SHORT,
//           //     gravity: ToastGravity.CENTER,
//           //     // timeInSecForIos: 1,
//           //     backgroundColor: Colors.red,
//           //     textColor: Colors.white,
//           //     context: BuildContext,
//           //     fontSize: 16.0);
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
