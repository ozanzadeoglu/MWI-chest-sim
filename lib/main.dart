import 'package:flutter/material.dart';
import 'package:mwi_chest_sim/views/home_view.dart';
import 'package:mwi_chest_sim/views/home_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  debugProfileBuildsEnabled = true;
  //debugPrintRebuildDirtyWidgets = true;

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => HomeViewModel()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MWI Chest Opening Simulator',
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(),
          useMaterial3: true,
        ),
        
        home: const HomeView());
  }
}
