import 'package:flutter_bloc/flutter_bloc.dart';

class NumberHandlerCubit extends Cubit<int> {
  NumberHandlerCubit() : super(0);

  void nextQuestion() {
    emit(state + 1);
  }

  void reset() {
    emit(0);
  }
}
