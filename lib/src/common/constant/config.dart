// ignore_for_file: prefer_constructors_over_static_methods

import 'dart:developer';

import 'package:meta/meta.dart';

/// Config for app.
@immutable
final class Config {
  const Config._({required this.environment, required this.apiBaseUrl, required this.thunderEnabled});
  // --- INITIALIZATION --- //
  factory Config._initialize({
    String environment = const String.fromEnvironment('ENVIRONMENT', defaultValue: 'development'),
    String apiBaseUrl = const String.fromEnvironment('API_BASE_URL', defaultValue: ''),
    bool? thunderEnabled,
  }) {
    final environmentFlavor = EnvironmentFlavor.from(environment);
    thunderEnabled = thunderEnabled ?? environmentFlavor.isDevelopment;
    final config = Config._(environment: environmentFlavor, apiBaseUrl: apiBaseUrl, thunderEnabled: thunderEnabled);
    _currentConfig = config;
    return config;
  }

  factory Config.copyWith({EnvironmentFlavor? environment, String? apiBaseUrl, bool? thunderEnabled}) {
    final config = Config._(
      environment: environment ?? current.environment,
      apiBaseUrl: apiBaseUrl ?? current.apiBaseUrl,
      thunderEnabled: thunderEnabled ?? current.thunderEnabled,
    );

    log('Config.copyWith: $config', name: 'Config');

    _currentConfig = config;

    return config;
  }

  static Config get current => _currentConfig ?? Config._initialize();

  static Config? _currentConfig;
  // --- *END INITIALIZATION* --- //

  // --- ENVIRONMENT --- //
  final EnvironmentFlavor environment;

  // --- API --- //
  final String apiBaseUrl;

  // --- THUNDER --- //
  final bool thunderEnabled;

  // --- EQUALITY & TO STRING --- //
  @override
  bool operator ==(Object other) {
    if (other is Config) {
      return environment == other.environment &&
          apiBaseUrl == other.apiBaseUrl &&
          thunderEnabled == other.thunderEnabled;
    }
    return false;
  }

  @override
  int get hashCode => environment.hashCode ^ apiBaseUrl.hashCode ^ thunderEnabled.hashCode;

  @override
  String toString() =>
      '''Config(environment: $environment, apiBaseUrl: $apiBaseUrl, thunderEnabled: $thunderEnabled)''';
}

/// Environment flavor.
/// e.g. development, staging, production
enum EnvironmentFlavor {
  /// Development
  development('development'),

  /// Staging
  staging('staging'),

  /// Production
  production('production');

  /// Create environment flavor.
  const EnvironmentFlavor(this.value);

  /// Create environment flavor from string.
  factory EnvironmentFlavor.from(String? value) => switch (value?.trim().toLowerCase()) {
    'development' || 'debug' || 'develop' || 'dev' => development,
    'staging' || 'profile' || 'stage' || 'stg' => staging,
    'production' || 'release' || 'prod' || 'prd' => production,
    _ => const bool.fromEnvironment('dart.vm.product') ? production : development,
  };

  /// development, staging, production
  final String value;

  /// Whether the environment is development.
  bool get isDevelopment => this == development;

  /// Whether the environment is staging.
  bool get isStaging => this == staging;

  /// Whether the environment is production.
  bool get isProduction => this == production;
}
