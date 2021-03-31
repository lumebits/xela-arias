import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:template_repository/template_repository.dart';
import 'package:xela_arias/common/models/GenericCard.dart';

part 'infinite_event.dart';

part 'infinite_state.dart';

const cardsToLoad = 25;

class InfiniteBloc extends Bloc<InfiniteEvent, InfiniteState> {
  final TemplateRepository templateRepository;

  InfiniteBloc(this.templateRepository) : super(InfiniteInitial());

  @override
  Stream<Transition<InfiniteEvent, InfiniteState>> transformEvents(
      Stream<InfiniteEvent> events,
      TransitionFunction<InfiniteEvent, InfiniteState> transitionFn,
      ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<InfiniteState> mapEventToState(InfiniteEvent event) async* {
    final currentState = state;
    if (event is FetchTemplates && !_hasReachedMax(currentState)) {
      try {
        if (currentState is InfiniteInitial) {
          final cards = await fetchCards();
          yield InfiniteSuccess(
              cards: cards,
              hasReachedMax: cards.length < cardsToLoad);
          return;
        }
        if (currentState is InfiniteSuccess) {
          final cards = await fetchCards(
              currentState.cards.last.date, currentState.cards.length);
          yield cards.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : InfiniteSuccess(
            cards: currentState.cards + cards,
            hasReachedMax: cards.length < cardsToLoad,
          );
        }
      } catch (e) {
        print(e);
        yield InfiniteFailure();
      }
    }
  }

  Future<List<GenericCard>> fetchCards([DateTime lastDate, int offset]) {
    return templateRepository
        .findTemplates(cardsToLoad, null, lastDate, offset)
        .first;
  }

  bool _hasReachedMax(InfiniteState state) =>
      state is InfiniteSuccess && state.hasReachedMax;
}
