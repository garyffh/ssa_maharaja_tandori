import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_nav_state.dart';

class CartNavCubit extends Cubit<CartNavState> {
  CartNavCubit() : super(CartNavStateInitialise());

  void closeCartAdd() => emit(CartNavStateCloseCartAdd());

  void closeCartUpdate() => emit(CartNavStateCloseCartUpdate());
}
