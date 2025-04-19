import 'package:flutter_modular/flutter_modular.dart';

class CommonModule extends Module {
  static String get path => "/onboard";

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

enum OnboardPathEnum {
  none("/");

  final String path;
  const OnboardPathEnum(this.path);
}
