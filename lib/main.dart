import 'package:flutter/material.dart';
import 'package:osysapp/pages/item_page.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'provider/empleado_provider.dart';
import 'provider/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EmpleadoProvider()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/',
        routes: {
          '/': (_) => const HomePage(),
          '/item': (_) => const ItemPage(),
        },
      ),
    );
  }
}
