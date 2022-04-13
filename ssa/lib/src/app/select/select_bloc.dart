import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/select/select_event.dart';
import 'package:single_store_app/src/app/select/select_state.dart';

class SelectBloc extends Bloc<SelectEvent, SelectState> {
  SelectBloc()
      : super(const SelectStateSelect(postSelectView: PostSelectView.category));
}
