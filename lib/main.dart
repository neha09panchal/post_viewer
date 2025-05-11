import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:post_viewer/domain/model/post_model.dart';
import 'package:post_viewer/data/post_repository_impl.dart';
import 'package:post_viewer/screens/post_screen/post_screen.dart';
import 'package:post_viewer/screens/post_screen/posts_cubit.dart';

import 'screens/favorites_screen/favourites_cubit.dart';

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
      debugShowCheckedModeBanner: false,
      home: BlocProvider(create: (_) => PostsDetailsCubit(), child: PostScreen()),
    );
  }
}
