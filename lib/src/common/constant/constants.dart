import 'package:flutter/material.dart';

sealed class Constants {
  const Constants._();

  static const tvRainSite = 'https://tvrain.tv';
  static const tvRainSiteImage = 'https://api.tvrain.tv/v3';
  static const tvRainDonateSite = 'https://tvrain.donorsupport.co/-/XKLDKVYV';

  // static final appLink = Platform.isIOS ? 'https://www.apple.com/app-store/' : 'https://play.google.com/store/';
  static const packageName = 'ru.raintv.rain';

  static const defaultPageSize = 30;

  static const loremIpsum =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

  static const loremShort = 'Lorem ipsum dolor sit amet.';

  static const dummyImage =
      'https://s3-alpha-sig.figma.com/img/d3e5/3545/73e6d707ed20b057bea4686720824918?Expires=1746403200&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=arIpKE4IAyqZmPe7ISkJ5l9A~WMkFmUAcg55nDUmUFIhAdPKYhFRyFy0t9Zm4-lz8LoQpApD7uGdNJifL6aV5NqGNGDK5x~pUwZlgxiGpUaZ6AnGrvdpgmENPFQnHouoXcXkYtP14q9hkc9AXsyjonqRbWKc~vMESCEmABU-eoxmdEbpEq-SHcldszAWw4ZCRoeRxO6lEHUU21O~i21fiCA-lKwYvpAYMyb9uZXl~MSCYEh642eqssNRQXZDIeLJQ~Q4SzTi5dxh8l2klIPLlNMUCHH8DoDXHaHUAtTFI-xRwM14eEaRnYY~2vy4PGuGGxVdiZPaWdvRPlstIoN62A__';

  static String _proxy = '';
  static String get proxy => _proxy;

  static set proxy(String proxy) {
    if (proxy.isEmpty) return;
    _proxy = proxy;
  }

  static String getProxyUrl(String url) => _proxy + url;

  static const liveNotification = 'live';
  static const breakingNewsNotification = 'breakingNews';
  static const updateNotification = 'update';
}

/// Global variable to keep track of the current screen name
String currentScreen = '';
String contentTitleDonate = '';
final ValueNotifier<bool> cacheClearedNotifier = ValueNotifier(false);
