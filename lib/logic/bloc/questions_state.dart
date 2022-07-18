part of 'questions_bloc.dart';

abstract class QuestionsState extends Equatable {
  const QuestionsState();

  @override
  List<Object> get props => [];
}

class QuestionsInitial extends QuestionsState {}

class QuestionsLoading extends QuestionsState {}

class QuestionsLoaded extends QuestionsState {
  final List<Questions> questions;
  const QuestionsLoaded({
    required this.questions,
  });

  @override
  List<Object> get props => [questions];
}

class QuestionsFailed extends QuestionsState {}
