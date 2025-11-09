enum Status {
  initial,
  loading,
  success,
  error;

  bool get isInitial => this == initial;
  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isError => this == error;

  T map<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function() success,
    required T Function() error,
  }) => switch (this) {
    Status.initial => initial(),
    Status.loading => loading(),
    Status.success => success(),
    Status.error => error(),
  };

  T maybeMap<T>({
    required T Function() orElse,
    T Function()? initial,
    T Function()? loading,
    T Function()? success,
    T Function()? error,
  }) => switch (this) {
    Status.initial => initial?.call() ?? orElse(),
    Status.loading => loading?.call() ?? orElse(),
    Status.success => success?.call() ?? orElse(),
    Status.error => error?.call() ?? orElse(),
  };
}
