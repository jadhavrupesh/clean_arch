import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'presentation/pages/posts_page.dart';
import 'di/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.configureDependencies('dev');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: FlexThemeData.light(
        scheme: FlexScheme.redWine,
        surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
        blendLevel: 18,
      ),
      home: const PostsPage(),
    );
  }
}
