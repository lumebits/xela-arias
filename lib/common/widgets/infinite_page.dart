import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:xela_arias/common/blocs/infinite_list/infinite_bloc.dart';
import 'package:xela_arias/common/widgets/bottom_loader.dart';
import 'package:xela_arias/common/widgets/generic_card.dart';

class InfinitePage extends StatefulWidget {
  @override
  InfinitePageState createState() => InfinitePageState();
}

class InfinitePageState extends State<InfinitePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  InfiniteBloc infiniteBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    infiniteBloc = BlocProvider.of<InfiniteBloc>(context);
  }

  Widget stateToView(InfiniteState state) {
    if (state is InfiniteInitial) {
      return Center(child: BottomLoader());
    } else if (state is InfiniteSuccess) {
      final cardsList = state.cards;
      return StaggeredGridView.countBuilder(
        padding: EdgeInsets.only(bottom: 90.0),
        controller: _scrollController,
        shrinkWrap: true,
        crossAxisCount: 1,
        staggeredTileBuilder: (index) {
          return StaggeredTile.fit(index >= cardsList.length ? 2 : 1);
        },
        itemCount: state.hasReachedMax
            ? cardsList.length
            : cardsList.length + 1,
        itemBuilder: (context, index) {
          return index >= cardsList.length
              ? (state.hasReachedMax ? Center() : BottomLoader())
              : GridTile(
              child: GenericCardWidget(card: cardsList[index]));
        },
      );
    } else {
      return Center(child: Text("Error"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InfiniteBloc, InfiniteState>(builder: (context, state) {
      return stateToView(state);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      infiniteBloc.add(FetchCards());
    }
  }
}
