import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/router_name.dart';
import 'state_injector.dart';
import 'utils/k_strings.dart';
import 'utils/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await StateInjector.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375.0, 812.0),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (BuildContext context, child) {
        return MultiRepositoryProvider(
          providers: StateInjector.repositoryProviders,
          child: MultiBlocProvider(
            providers: StateInjector.blocProviders,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Kstrings.appName,
              theme: MyTheme.theme,
              // home: const OrderScreen(),
              onGenerateRoute: RouteNames.generateRoute,
              initialRoute: RouteNames.splashScreen,
              onUnknownRoute: (RouteSettings settings) {
                return MaterialPageRoute(
                  builder: (_) => Scaffold(
                    body: Center(
                        child: Text('No route defined for ${settings.name}')),
                  ),
                );
              },
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
