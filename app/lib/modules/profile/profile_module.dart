import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  static String get path => "/profile";

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

enum ProfilePathEnum {
  none("/");

  final String path;
  const ProfilePathEnum(this.path);
}
