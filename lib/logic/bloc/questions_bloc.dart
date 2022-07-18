import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:got_trivia_game/data/trivia.dart';

import '../../data/models/questions.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  QuestionsBloc() : super(QuestionsInitial()) {
    on<LoadQuestions>((event, emit) async {
      emit(QuestionsLoading());
      try {
        final _questions = await getQuestions();
        emit(QuestionsLoaded(questions: _questions));
      } catch (e) {
        emit(QuestionsFailed());
      }
    });
    on<NoQuestions>((event, emit) {
      emit(QuestionsInitial());
    });
  }
}
