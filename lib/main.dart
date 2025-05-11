import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:post_viewer/post_model.dart';
import 'package:post_viewer/post_repository_impl.dart';
import 'package:post_viewer/post_screen.dart';
import 'package:post_viewer/posts_cubit.dart';

import 'favourites_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(PostModelAdapter()); // generate adapter
  await Hive.openBox<PostModel>('favorites');
  runApp(BlocProvider(create: (_) => FavoritesCubit(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(create: (_) => PostsDetailsCubit(), child: PostScreen()),
    );
  }
}
