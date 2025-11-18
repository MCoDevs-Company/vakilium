import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vakilium/src/common/widgets/app_circular_indicator.dart';
import 'package:vakilium/src/feature/main/cubit/main_cubit.dart';
import 'package:vakilium/src/feature/main/models/menu_item.dart';
import 'package:vakilium/src/feature/main/screens/home/screens/home_screen.dart';
import 'package:vakilium/src/feature/main/widgets/top_bar.dart';
import 'package:yandex_js_maps/yandex_js_maps.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late final MainCubit _cubit;

  static const List<MenuItem> menuItems = [
    MenuItem(slug: 'home', page: HomeScreen()),
    MenuItem(slug: 'services', page: Placeholder()),
    MenuItem(slug: 'requests', page: Placeholder()),
    MenuItem(slug: 'chat', page: Placeholder()),
  ];

  @override
  void initState() {
    _cubit = MainCubit()..selectMenuItem(menuItems.first);
    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _cubit,
    child: Scaffold(
      body: Stack(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          FutureBuilder(
            future: Geolocator.getCurrentPosition(),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return const AppCircularIndicator();
              }
              if (asyncSnapshot.hasError) {
                return Center(child: Text(asyncSnapshot.error.toString()));
              }
              final position = asyncSnapshot.data;
              if (position == null) {
                return const Center(child: Text("error"));
              }
              return Column(
                children: [
                  YandexJsMap(
                    onMapCreated: (controller) {},
                    mapOptions: const MapOptions(),
                    mapState: MapState(
                      controls: ['none'],
                      center: PointEntity(position.latitude, position.longitude),
                      zoom: 14,
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            left: 16,
            right: 16,
            top: 16,
            child: BlocBuilder<MainCubit, MainState>(
              builder: (context, state) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Builder(builder: (context) => const TopBar(menuItems: menuItems)),
                  ?state.selectedMenuItem?.page,
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
