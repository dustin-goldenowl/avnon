// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<MFormData> froms;
  const HomeState({
    this.froms = const [],
  });
  factory HomeState.init() {
    final froms = GetIt.I<UserPrefs>().getFrom();
    return HomeState(froms: froms);
  }

  @override
  List<Object?> get props => [froms];

  HomeState copyWith({
    List<MFormData>? froms,
  }) {
    return HomeState(
      froms: froms ?? this.froms,
    );
  }
}
