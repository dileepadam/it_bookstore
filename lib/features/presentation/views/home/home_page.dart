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
import 'package:it_bookstore/features/presentation/widgets/mainAppBar.dart';
import 'package:it_bookstore/features/presentation/widgets/toast_widget/toast_widget.dart';

import '../../../../utils/enums.dart';

class HomePage extends BaseView {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends BaseViewState<HomePage> {
  final _homePageBloc = injection<HomePageBloc>();
  BaseResponse? baseResponse;
  List<Book> books = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homePageBloc.add(GetHomeDataRequestEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        hintText: "Search",
        onTapFavourite: () {},
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
              setState(() {});
            } else if (state is GetHomeDataFailureState) {
              ToastUtils.showCustomToast(
                  context, state.message!, ToastStatus.FAIL);
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
            }
          },
          child: books.isNotEmpty
              ? ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return HomePageListItem(
                      title: books[index].title,
                      author: books[index].subtitle,
                      url: books[index].image,
                    );
                  },
                )
              : const Center(
                  child: Text("Empty"),
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

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _homePageBloc;
  }
}
