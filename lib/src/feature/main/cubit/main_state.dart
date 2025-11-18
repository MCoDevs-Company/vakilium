part of 'main_cubit.dart';

class MainState extends Equatable {
  const MainState({this.selectedMenuItem});
  final MenuItem? selectedMenuItem;

  MainState copyWith({MenuItem? selectedMenuItem}) =>
      MainState(selectedMenuItem: selectedMenuItem ?? this.selectedMenuItem);

  @override
  List<Object?> get props => [selectedMenuItem];
}
