part of 'stats_cubit.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object> get props => [];
}

class StatsInitial extends StatsState {}

class NoStats extends StatsState {}

class StatsLoaded extends StatsState {
  final List<StatsData> stats;
  const StatsLoaded({required this.stats});
  @override
  List<Object> get props => [stats];
}
