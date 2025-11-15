import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vakilium/src/common/widgets/app_circular_indicator.dart';
import 'package:yandex_js_maps/yandex_js_maps.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
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
  );
}
