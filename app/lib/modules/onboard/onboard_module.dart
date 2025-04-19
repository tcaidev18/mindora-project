import 'package:app/modules/onboard/container/splash/splash_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum OnboardPathEnum {
  splash("/");

  final String subPath;
  const OnboardPathEnum(this.subPath);

  /// Đường dẫn đầy đủ bao gồm path module
  String get fullPath => "${OnboardModule.path}$subPath";
}

class OnboardModule extends Module {
  static String get path => "/onboard/";

  @override
  void routes(RouteManager r) {
    // THIS IS EXAMPLE, REMOVE IT
    r.child(
      OnboardPathEnum.splash.subPath,
      child: (context) => SplashScreen(argument: r.args.data),
    );
    super.routes(r);
  }
}
