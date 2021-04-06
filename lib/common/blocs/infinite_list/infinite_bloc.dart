import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:pair_repository/pair_repository.dart';
import 'package:image_repository/image_repository.dart';
import 'package:poem_repository/poem_repository.dart';
import 'package:xela_arias/common/models/EntityType.dart';
import 'package:xela_arias/common/models/GenericCard.dart';
import 'package:enum_to_string/enum_to_string.dart';

part 'infinite_event.dart';

part 'infinite_state.dart';

const cardsToLoad = 25;
const xelaAriasImage = "https://firebasestorage.googleapis.com/v0/b/xela-arias.appspot.com/o/xela_arias.jpg?alt=media&token=31fac2b0-d442-44c5-ad30-561c1a3600e2";

class InfiniteBloc extends Bloc<InfiniteEvent, InfiniteState> {
  final PairRepository pairRepository;
  final ImageRepository imageRepository;
  final PoemRepository poemRepository;
  final EntityType type;

  InfiniteBloc(this.pairRepository, this.imageRepository, this.poemRepository, this.type) : super(InfiniteInitial());

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
          final cards = await fetchCards(type);
          yield InfiniteSuccess(
              cards: cards,
              hasReachedMax: cards.length < cardsToLoad);
          return;
        }
        if (currentState is InfiniteSuccess) {
          final cards = await fetchCards(type,
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

  Future<List<GenericCard>> fetchCards(EntityType type, [DateTime lastDate, int offset]) async {
    switch (type) {
      case EntityType.PAIR:
        var pairs = await fetchPairs(lastDate, offset);
        return pairs.map((e) => GenericCard(e.id, e.poem['text'], e.poem['author'], e.image['url'], e.image['author'], EnumToString.fromString(EntityType.values, e.first), e.date)).toList();
      case EntityType.IMAGE:
        var images = await fetchImages(lastDate, offset);
        return images.map((e) => GenericCard(e.id, "Preme aquí para engadir o teu poema para esta imaxe.", "", e.url, e.author, EntityType.IMAGE, e.date)).toList();
      case EntityType.POEM:
        var poems = await fetchPoems(lastDate, offset);
        return poems.map((e) => GenericCard(e.id, e.text, e.author, xelaAriasImage, "", EntityType.POEM, e.date)).toList();
      default:
        return null;
    }
  }

  Future<List<Pair>> fetchPairs([DateTime lastDate, int offset]) {
    print("fetching pairs");
    return pairRepository
        .findPairs(cardsToLoad, lastDate, offset)
        .first;
  }

  Future<List<Image>> fetchImages([DateTime lastDate, int offset]) {
    print("fetching images");
    return imageRepository
        .findImages(cardsToLoad, lastDate, offset)
        .first;
  }

  Future<List<Poem>> fetchPoems([DateTime lastDate, int offset]) {
    print("fetching poems");
    return poemRepository
        .findPoems(cardsToLoad, lastDate, offset)
        .first;
  }

  bool _hasReachedMax(InfiniteState state) =>
      state is InfiniteSuccess && state.hasReachedMax;
}
