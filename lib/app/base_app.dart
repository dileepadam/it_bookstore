import 'package:flutter/material.dart';
import 'package:it_bookstore/utils/app_const.dart';

import '../utils/navigation_routes.dart';

class ItBookstoreApp extends StatefulWidget {
  const ItBookstoreApp({super.key});

  @override
  State<ItBookstoreApp> createState() => _ItBookstoreAppState();
}

class _ItBookstoreAppState extends State<ItBookstoreApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      initialRoute: Routes.kHomeView,
      onGenerateRoute: Routes.generateRoutes,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1)),
        child: child!,
      ),
    );
  }
}
