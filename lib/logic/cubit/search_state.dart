part of 'search_cubit.dart';

@immutable
sealed class SearchStates {}

final class SearchInitial extends SearchStates {}

final class SearchLoadingState extends SearchStates {}

final class SearchSuccessState extends SearchStates {}

final class SearchErrorState extends SearchStates {}
