import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_bookstore/core/services/dependency_injection.dart';
import 'package:it_bookstore/features/presentation/bloc/base_bloc.dart';
import 'package:it_bookstore/features/presentation/bloc/base_event.dart';
import 'package:it_bookstore/features/presentation/bloc/base_state.dart';
import 'package:it_bookstore/features/presentation/bloc/home/home_bloc.dart';
import 'package:it_bookstore/features/presentation/bloc/home/home_event.dart';
import 'package:it_bookstore/features/presentation/bloc/home/home_state.dart';
import 'package:it_bookstore/features/presentation/widgets/secondar_app_bar.dart';

import '../../../../utils/navigation_routes.dart';
import '../../../data/models/common/base_response.dart';
import '../base_view.dart';
import '../home/listItem/list_item.dart';

class FavoriteBookPage extends BaseView {
  @override
  _FavoritePageViewState createState() => _FavoritePageViewState();
}

class _FavoritePageViewState extends BaseViewState<FavoriteBookPage> {
  final _homePageBloc = injection<HomePageBloc>();

  List<Book> favoriteBooks = [];
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    _homePageBloc.add(GetFavoriteBooksEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppBar(
        title: "Favorites",
      ),
      body: BlocProvider(
          create: (_) => _homePageBloc,
          child: BlocListener<HomePageBloc, BaseState<HomeState>>(
            listener: (context, state) {
              if (state is GetFavoriteBooksSuccessState) {
                favoriteBooks.clear();
                books.clear();
                List<Book> temp = state.books!;
                if (temp.isNotEmpty) {
                  favoriteBooks.addAll(temp);
                }
                books.addAll(favoriteBooks);
                setState(() {});
              } else if (state is GetHomeDataFailureState) {
              } else if (state is StoreFavoriteBooksSuccessState) {
                _homePageBloc.add(GetFavoriteBooksEvent());
              } else if (state is StoreFavoriteBooksFailureState) {}
            },
            child: books.isNotEmpty
                ? ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      bool isFavorite = true;
                      return HomePageListItem(
                        title: books[index].title,
                        author: books[index].subtitle,
                        url: books[index].image,
                        isFavorite: isFavorite,
                        onTapFavorite: (b) {
                          favoriteBooks.removeWhere((element) =>
                              element.isbn13 == books[index].isbn13);

                          _homePageBloc.add(
                              StoreFavoriteBookEvent(books: favoriteBooks));
                        },
                        onTapItem: () {
                          Navigator.pushNamed(context, Routes.kBookDetail,
                              arguments: favoriteBooks[index].isbn13);
                        },
                      );
                    },
                  )
                : const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 100,
                          ),
                          Text(
                            "No Books Found",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "We couldn't find any books at the moment. \n"
                            "Please add books if you haven't added any to your favorites yet.",
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
          )),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _homePageBloc;
  }
}
