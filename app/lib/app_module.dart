import 'package:app/modules/common/common_module.dart';
import 'package:app/modules/onboard/onboard_module.dart';
import 'package:app/modules/profile/profile_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CommonModule(),
        OnboardModule(),
        ProfileModule(),
        // DO NOT DELETE THIS COMMENT
      ];
  void initRoute() {
    Modular.setInitialRoute(OnboardModule.path);
  }

  @override
  void routes(RouteManager r) {
    r.module(OnboardModule.path, module: OnboardModule());
    r.module(CommonModule.path, module: CommonModule());
    r.module(ProfileModule.path, module: ProfileModule());
    super.routes(r);
  }
}
