import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_bookstore/core/services/dependency_injection.dart';
import 'package:it_bookstore/features/data/models/common/base_response.dart';
import 'package:it_bookstore/features/presentation/bloc/base_bloc.dart';
import 'package:it_bookstore/features/presentation/bloc/base_event.dart';
import 'package:it_bookstore/features/presentation/bloc/base_state.dart';
import 'package:it_bookstore/features/presentation/bloc/home/home_bloc.dart';
import 'package:it_bookstore/features/presentation/bloc/home/home_event.dart';
import 'package:it_bookstore/features/presentation/bloc/home/home_state.dart';
import 'package:it_bookstore/features/presentation/views/base_view.dart';
import 'package:it_bookstore/features/presentation/views/home/listItem/list_item.dart';
import 'package:it_bookstore/features/presentation/widgets/main_app_bar.dart';
import 'package:it_bookstore/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:it_bookstore/utils/navigation_routes.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/enums.dart';
import '../../widgets/show_dialog.dart';

class HomePage extends BaseView {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends BaseViewState<HomePage> {
  final _homePageBloc = injection<HomePageBloc>();
  BaseResponse? baseResponse;
  List<Book> books = [];
  List<Book> favoriteBooks = [];
  bool isFavoriteAvailable = false;

  @override
  void initState() {
    super.initState();
    _homePageBloc.add(GetHomeDataRequestEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        hintText: "Search",
        onTapFavourite: () {
          Navigator.pushNamed(context, Routes.kFavouriteBook);
        },
        onChange: (value) {
          searchBook(value);
        },
      ),
      body: BlocProvider(
        create: (_) => _homePageBloc,
        child: BlocListener<HomePageBloc, BaseState<HomeState>>(
          bloc: _homePageBloc,
          listener: (context, state) {
            if (state is GetHomeDataSuccessState) {
              baseResponse = state.response!;
              if (baseResponse != null) {
                baseResponse?.books.forEach((element) {
                  books.add(element);
                });
              }
              ;
              _homePageBloc.add(GetFavoriteBooksEvent());
              setState(() {});
            } else if (state is GetHomeDataFailureState) {
              ShowDialog(
                  context: context,
                  title: "Oops!",
                  descriptionOne: state.message,
                  actionButtonOne: TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ));
            } else if (state is SearchHomeDataSuccessState) {
              baseResponse = state.response!;
              if (baseResponse != null) {
                baseResponse?.books.forEach((element) {
                  books.add(element);
                });
              }
              setState(() {});
            } else if (state is SearchHomeDataFailureState) {
              ToastUtils.showCustomToast(
                  context, state.message!, ToastStatus.FAIL);
            } else if (state is GetFavoriteBooksSuccessState) {
              favoriteBooks.clear();
              List<Book> temp = state.books!;
              if (temp.isNotEmpty) {
                favoriteBooks.addAll(temp);
                isFavoriteAvailable = false;
              }
              setState(() {});
            } else if (state is GetHomeDataFailureState) {
              isFavoriteAvailable = false;
            } else if (state is StoreFavoriteBooksSuccessState) {
              _homePageBloc.add(GetFavoriteBooksEvent());
            } else if (state is StoreFavoriteBooksFailureState) {}
          },
          child: books.isNotEmpty
              ? ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    bool isFavorite = isOnFavorite(books[index].isbn13);
                    return HomePageListItem(
                      title: books[index].title,
                      author: books[index].subtitle,
                      url: books[index].image,
                      isFavorite: isFavorite,
                      onTapFavorite: (b) {
                        if (b && !isFavorite) {
                          favoriteBooks.add(books[index]);
                        } else if (!b && isFavorite) {
                          favoriteBooks.removeWhere((element) =>
                              element.isbn13 == books[index].isbn13);
                        }
                        _homePageBloc
                            .add(StoreFavoriteBookEvent(books: favoriteBooks));
                      },
                      onTapItem: () {
                        Navigator.pushNamed(context, Routes.kBookDetail,
                            arguments: books[index].isbn13);
                      },
                    );
                  },
                )
              : Padding(
                  padding: EdgeInsets.all(16.0.h),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 100.h,
                        ),
                        const Text(
                          "No Books Found",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const Text(
                          "We couldn't find any books at the moment. \n"
                          "Please try again later or check your internet connection.",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void searchBook(String bookName) {
    books.clear();
    if (bookName.isEmpty) {
      _homePageBloc.add(GetHomeDataRequestEvent());
    } else {
      Future.delayed(Duration(seconds: 3), () {
        _homePageBloc.add(SearchHomeDataRequestEvent(bookName: bookName));
      });
    }
  }

  bool isOnFavorite(String isbn) {
    bool b = false;
    for (var element in favoriteBooks) {
      if (element.isbn13 == isbn) {
        b = true;
        break;
      }
    }
    return b;
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _homePageBloc;
  }
}
