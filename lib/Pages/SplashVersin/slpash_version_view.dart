import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:kitap_sarayi_app/Pages/SplashVersin/splash_Version_provider.dart';
import 'package:kitap_sarayi_app/Pages/login_page.dart';
import 'package:kitap_sarayi_app/Tools/splash/splash_screen.dart';
import 'package:kitap_sarayi_app/Tools/version/versionmanager.dart';

class SplashVersionView extends ConsumerStatefulWidget {
  const SplashVersionView({super.key});

  @override
  _SplashVersionViewState createState() => _SplashVersionViewState();
}

class _SplashVersionViewState extends ConsumerState<SplashVersionView>
    with _SplashViewListenMixin {
  final splashProvider =
      StateNotifierProvider<SplashVersionProvider, SplashVersionState>((ref) {
    return SplashVersionProvider();
  });

  @override
  void initState() {
    super.initState();

    ref.read(splashProvider.notifier).checkupdate(''.version);
  }

  @override
  Widget build(BuildContext context) {
    listenAndNavigate(splashProvider);
    return const SplashScreen();
  }
}

mixin _SplashViewListenMixin on ConsumerState<SplashVersionView> {
  void listenAndNavigate(
    StateNotifierProvider<SplashVersionProvider, SplashVersionState> provider,
  ) {
    ref.listen(provider, (previous, next) {
      if (next.isNeedUpdate) {
        VersionManager().showCustomDialog(context, next.url!);
        return;
      }
      if (next.isGet) {
        context.navigateToPage(const LoginPage());
      } else {
        // false
      }
    });
  }
}
