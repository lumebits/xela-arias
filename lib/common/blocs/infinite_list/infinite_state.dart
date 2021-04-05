part of 'infinite_bloc.dart';

abstract class InfiniteState extends Equatable {
  const InfiniteState();

  @override
  List<Object> get props => [];
}

class InfiniteInitial extends InfiniteState {}

class InfiniteFailure extends InfiniteState {}

class InfiniteSuccess extends InfiniteState {
  final List<GenericCard> cards;
  final bool hasReachedMax;

  const InfiniteSuccess({
    this.cards = const <GenericCard>[],
    this.hasReachedMax = false,
  });

  InfiniteSuccess copyWith({
    List<GenericCard> cards,
    bool hasReachedMax,
  }) {
    return InfiniteSuccess(
      cards: cards ?? this.cards,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [cards, hasReachedMax];

  @override
  String toString() =>
      'InfiniteSuccess { cards: ${cards.length}, hasReachedMax: $hasReachedMax }';
}
