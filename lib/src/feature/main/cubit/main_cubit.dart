import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vakilium/src/feature/main/models/menu_item.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void selectMenuItem(MenuItem menuItem) => emit(state.copyWith(selectedMenuItem: menuItem));
}
