import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitap_sarayi_app/Tools/version/versionmanager.dart';
import 'package:kitap_sarayi_app/api/Service/service_database.dart';

class SplashVersionProvider extends StateNotifier<SplashVersionState> {
  SplashVersionProvider() : super(const SplashVersionState());

  Future<void> checkupdate(String clientVersion) async {
    await Future.delayed(const Duration(seconds: 3), () {});
    final databaseversion = await FirebaseGet().getVersion();

    if (VersionManager.isNeedUpdate(
      databasevalue: databaseversion!.number!,
      clientcvalue: clientVersion,
    )) {
      state = state.copyWith(isNeedUpdate: true, url: databaseversion.store);
      return;
    }
    state = state.copyWith(isGet: true);
    return;
  }
}

class SplashVersionState extends Equatable {
  const SplashVersionState({
    this.url,
    this.isGet = false,
    this.isNeedUpdate = false,
  });
  final bool isNeedUpdate;
  final bool isGet;
  final String? url;
  @override
  List<Object?> get props => [isGet, isNeedUpdate, url];
  SplashVersionState copyWith({
    bool? isNeedUpdate,
    bool? isGet,
    String? url,
  }) {
    return SplashVersionState(
      isNeedUpdate: isNeedUpdate ?? this.isNeedUpdate,
      isGet: isGet ?? this.isGet,
      url: url ?? this.url,
    );
  }
}
