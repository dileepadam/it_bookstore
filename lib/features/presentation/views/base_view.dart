import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_bookstore/features/presentation/bloc/base_bloc.dart';
import 'package:it_bookstore/features/presentation/widgets/show_dialog.dart';
import 'package:it_bookstore/features/presentation/widgets/toast_widget/toast_widget.dart';
import 'package:it_bookstore/flavours/flavor_banner.dart';
import 'package:it_bookstore/utils/enums.dart';

import '../bloc/base_event.dart';
import '../bloc/base_state.dart';

abstract class BaseView extends StatefulWidget {
  const BaseView({super.key});
}

abstract class BaseViewState<Page extends BaseView> extends State<Page> {
  Widget buildView(BuildContext context);

  BaseBloc<BaseEvent, BaseState<dynamic>> getBloc();

  bool _isProgressShow = false;

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
        child: BlocProvider<BaseBloc>(
      create: (_) => getBloc(),
      child: BlocListener<BaseBloc, BaseState>(
        listener: (context, state) {
          if (state is APILoadingState) {
            showProgressBar();
          } else if (state is ConnectionFailureState) {
            hideProgressBar();
            ToastUtils.showCustomToast(
                context, "Connection Fail", ToastStatus.FAIL);
          } else if (state is ServerFailureState) {
            hideProgressBar();
            ToastUtils.showCustomToast(
                context, "Server Fail", ToastStatus.FAIL);
          } else {
            hideProgressBar();
            if (state is APIFailureState) {
              ShowDialog(
                  context: context,
                  title: "Oops!",
                  descriptionOne: state.error,
                  actionButtonOne: TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ));

              // ToastUtils.showCustomToast(
              //     context, "Something Went Wrong", ToastStatus.FAIL);
            }
          }
        },
        child: Listener(
          behavior: HitTestBehavior.translucent,
          child: Container(
            child: buildView(context),
          ),
        ),
      ),
    ));
  }

  showProgressBar() {
    if (!_isProgressShow) {
      _isProgressShow = true;
      showGeneralDialog(
          context: context,
          barrierDismissible: false,
          transitionBuilder: (context, a1, a2, widget) {
            return PopScope(
              canPop: false,
              child: Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                        alignment: FractionalOffset.center,
                        child: const CircularProgressIndicator(
                          color: Colors.lightBlueAccent,
                        )),
                  ),
                ),
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return const SizedBox.shrink();
          });
    }
  }

  hideProgressBar() {
    if (_isProgressShow) {
      Navigator.pop(context);
      _isProgressShow = false;
    }
  }
}
