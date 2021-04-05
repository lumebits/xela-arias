import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:pair_repository/pair_repository.dart';
import 'package:image_repository/image_repository.dart';
import 'package:poem_repository/poem_repository.dart';
import 'package:xela_arias/common/models/GenericCard.dart';

part 'infinite_event.dart';

part 'infinite_state.dart';

const cardsToLoad = 25;
const xelaAriasImage = "https://firebasestorage.googleapis.com/v0/b/xela-arias.appspot.com/o/xela_arias.jpg?alt=media&token=31fac2b0-d442-44c5-ad30-561c1a3600e2";

class InfiniteBloc extends Bloc<InfiniteEvent, InfiniteState> {
  final PairRepository pairRepository;
  final ImageRepository imageRepository;
  final PoemRepository poemRepository;

  InfiniteBloc(this.pairRepository, this.imageRepository, this.poemRepository) : super(InfiniteInitial());

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
    if (event is FetchCards && !_hasReachedMax(currentState)) {
      try {
        if (currentState is InfiniteInitial) {
          final cards = await fetchCards("images");
          yield InfiniteSuccess(
              cards: cards,
              hasReachedMax: cards.length < cardsToLoad);
          return;
        }
        if (currentState is InfiniteSuccess) {
          final cards = await fetchCards("images",
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

  Future<List<GenericCard>> fetchCards(String type, [DateTime lastDate, int offset]) async {
    switch (type) {
      case "pairs":
        var pairs = await fetchPairs(lastDate, offset);
        return pairs.map((e) => GenericCard(e.id, e.poem.text, e.poem.author, e.image.url, e.image.author, e.first, e.date)).toList();
      case "images":
        var images = await fetchImages(lastDate, offset);
        return images.map((e) => GenericCard(e.id, null, null, e.url, e.author, "IMAGE", e.date)).toList();
      case "poems":
        var poems = await fetchPoems(lastDate, offset);
        return poems.map((e) => GenericCard(e.id, e.text, e.author, xelaAriasImage, "", "POEM", e.date)).toList();
    }
  }

  Future<List<Pair>> fetchPairs([DateTime lastDate, int offset]) {
    return pairRepository
        .findPairs(cardsToLoad, lastDate, offset)
        .first;
  }

  Future<List<Image>> fetchImages([DateTime lastDate, int offset]) {
    return imageRepository
        .findImages(cardsToLoad, lastDate, offset)
        .first;
  }

  Future<List<Poem>> fetchPoems([DateTime lastDate, int offset]) {
    return poemRepository
        .findPoems(cardsToLoad, lastDate, offset)
        .first;
  }

  bool _hasReachedMax(InfiniteState state) =>
      state is InfiniteSuccess && state.hasReachedMax;
}
