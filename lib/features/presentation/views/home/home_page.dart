import 'package:flutter/cupertino.dart';
import 'package:it_bookstore/core/services/dependency_injection.dart';
import 'package:it_bookstore/features/presentation/bloc/base_bloc.dart';
import 'package:it_bookstore/features/presentation/bloc/base_event.dart';
import 'package:it_bookstore/features/presentation/bloc/base_state.dart';
import 'package:it_bookstore/features/presentation/bloc/home/home_bloc.dart';
import 'package:it_bookstore/features/presentation/bloc/home/home_event.dart';
import 'package:it_bookstore/features/presentation/views/base_view.dart';

class HomePage extends BaseView {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends BaseViewState<HomePage> {
  final _homePageBloc = injection<HomePageBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homePageBloc.add(GetHomeDataRequestEvent());
  }

  @override
  Widget buildView(BuildContext context) {
    return const Placeholder();
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _homePageBloc;
  }
}
