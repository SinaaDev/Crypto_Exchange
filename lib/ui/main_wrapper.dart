import 'package:crypto_app/ui/home_page.dart';
import 'package:crypto_app/ui/market_view_page.dart';
import 'package:crypto_app/ui/profile_page.dart';
import 'package:crypto_app/ui/ui_helper/botton_nav.dart';
import 'package:crypto_app/ui/ui_helper/theme_switcher.dart';
import 'package:crypto_app/ui/watch_list_page.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});

  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        actions: [const ThemeSwitcher()],
        title: const Text('CoinMarketCap'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
      ),
      drawer: const Drawer(),
      body: PageView(
        controller: _pageController,
        children: [
          HomePage(),
          const MarketViewPage(),
          const ProfilePage(),
          const WatchListPage()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.compare_arrows_outlined),
        shape: const CircleBorder(),
        backgroundColor: Colors.blue[100],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNav(
        pageController: _pageController,
      ),
    );
  }
}
