import 'package:flutter/material.dart';

import 'src/screens/post_details/post_details.dart';
import 'src/screens/post_listing/post_listing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        PostsScreen.path: (_) => const PostsScreen(),
        PostDetailsScreen.path: (context) => PostDetailsScreen(
              payload: ModalRoute.of(context)!.settings.arguments
                  as PostDetailsScreenPayload,
            ),
      },
    );
  }
}
