import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitap_sarayi_app/Pages/SplashHome/splash_home_provider.dart';
import 'package:kitap_sarayi_app/Pages/home_page.dart';
import 'package:kitap_sarayi_app/Pages/library_page.dart';
import 'package:kitap_sarayi_app/Pages/read_list_page.dart';
import 'package:kitap_sarayi_app/Pages/search_page.dart';
import 'package:kitap_sarayi_app/Pages/setting_page.dart';
import 'package:kitap_sarayi_app/Tools/Provider/library_provider.dart';
import 'package:kitap_sarayi_app/Tools/Provider/readlist_provider.dart';
import 'package:kitap_sarayi_app/Tools/language.dart';
import 'package:kitap_sarayi_app/Tools/splash/splash_screen.dart';

class SplashHomeView extends ConsumerStatefulWidget {
  const SplashHomeView({required this.userid, super.key});
  final String userid;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StateHomeViewState();
}

class _StateHomeViewState extends ConsumerState<SplashHomeView>
    with _SplashHomeViewListenMixin {
  final splashProvider =
      StateNotifierProvider<SplashHomeProvider, SplashHomeState>((ref) {
    return SplashHomeProvider();
  });

  @override
  void initState() {
    super.initState();
    ref.read(splashProvider.notifier).getbooks(widget.userid);
  }

  @override
  Widget build(BuildContext context) {
    final isget = ref.read(splashProvider).isGet;
    listenAndNavigate(splashProvider);
    if (isget ?? false != false) {
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          extendBody: true,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                // ignore: inference_failure_on_instance_creation
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
          body: tabbarView(),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 10,
            child: TabBar(
              labelStyle: const TextStyle(fontSize: 12.5),
              tabs: Tabbar.values.map((e) => e.tabList()).toList(),
            ),
          ),
        ),
      );
    }
    return const SplashScreen();
  }

  TabBarView tabbarView() {
    final data = ref.read(splashProvider);
    return TabBarView(
      children: [
        HomePage(
          books: data.books!,
          popularbooks: data.popularbooks!,
        ),
        const LibraryPage(),
        const ReadListPage(),
        SettingPage(user: data.user!)
      ],
    );
  }
}

enum Tabbar { home, library, list, person }

extension IconsTitle on Tabbar {
  Tab tabList() {
    switch (this) {
      case Tabbar.home:
        return const Tab(text: TabbarTite.home, icon: Icon(Icons.home));
      case Tabbar.library:
        return const Tab(text: TabbarTite.library, icon: Icon(Icons.book));
      case Tabbar.list:
        return const Tab(text: TabbarTite.myList, icon: Icon(Icons.favorite));
      case Tabbar.person:
        return const Tab(text: TabbarTite.person, icon: Icon(Icons.person));
      // ignore: no_default_cases
      default:
        return Tab(text: name, icon: const Icon(Icons.home));
    }
  }
}

mixin _SplashHomeViewListenMixin on ConsumerState<SplashHomeView> {
  void listenAndNavigate(
    StateNotifierProvider<SplashHomeProvider, SplashHomeState> provider,
  ) {
    ref.listen(provider, (previous, next) {
      if (next.isGet ?? false == true) {
        setState(() {});
        ref.read(libraryProvider).userid = next.user!.id!;
        ref.read(libraryProvider).libraryListID = next.library!.library!;
        if (next.libraryBooks != null) {
          ref.read(libraryProvider).libraryBooks = next.libraryBooks;
        }
        ref.read(readlistProvider).userid = next.user!.id!;
        ref.read(readlistProvider).readlistListID = next.library!.readList!;
        if (next.libraryBooks != null) {
          ref.read(readlistProvider).readlistBooks = next.readListBooks;
        }
      }
    });
  }
}
