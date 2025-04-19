import 'package:flutter_modular/flutter_modular.dart';

class MainModule extends Module {
  static String get path => "/main";

  @override
  void routes(RouteManager r) {
    // THIS IS EXAMPLE, REMOVE IT
    // r.child(
    //   OnBoardPathEnum.splash.path,
    //   child: (context) => SplashScreen(argument: r.args.data),
    // );
    super.routes(r);
  }
}

enum MainPathEnum {
  none("/");

  final String path;
  const MainPathEnum(this.path);
}
