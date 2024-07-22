import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_bookstore/core/services/dependency_injection.dart';
import 'package:it_bookstore/features/data/models/responses/book_detail_response.dart';
import 'package:it_bookstore/features/presentation/bloc/base_bloc.dart';
import 'package:it_bookstore/features/presentation/bloc/base_event.dart';
import 'package:it_bookstore/features/presentation/bloc/base_state.dart';
import 'package:it_bookstore/features/presentation/bloc/book_details/book_detail_bloc.dart';
import 'package:it_bookstore/features/presentation/bloc/book_details/book_detail_state.dart';
import 'package:it_bookstore/features/presentation/bloc/book_details/book_details_event.dart';
import 'package:it_bookstore/features/presentation/views/base_view.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/secondar_app_bar.dart';
import '../../widgets/show_dialog.dart';
import 'book_deatil_widget/book_deatils_widget.dart';

class BookDetailsPage extends BaseView {
  final String? isbn13;

  const BookDetailsPage({super.key, this.isbn13});

  @override
  _BookDetailsViewState createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends BaseViewState<BookDetailsPage> {
  late BookDetailsBloc _bookDetailsBloc;

  BookDetailResponse? _bookDetailResponse;

  @override
  void initState() {
    super.initState();
    _bookDetailsBloc = injection<BookDetailsBloc>();
    _bookDetailsBloc.add(GetBookDetailsRequestEvent(isbn13: widget.isbn13));
  }

  @override
  Widget buildView(BuildContext context) {
    return BlocProvider<BookDetailsBloc>.value(
      value: _bookDetailsBloc,
      child: Scaffold(
        appBar: const SecondaryAppBar(
          title: "Book Details",
        ),
        body: BlocListener<BookDetailsBloc, BaseState<BookDetailsState>>(
          listener: (context, state) {
            if (state is GetBookDetailsSuccessState) {
              setState(() {
                _bookDetailResponse = state.bookDetailResponse;
              });
            } else if (state is GetBookDetailsFailureState) {
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
            }
          },
          child: _bookDetailResponse != null
              ? BookDetailsWidget(
                  imageUrl: _bookDetailResponse!.image,
                  title: _bookDetailResponse!.title,
                  subtitle: _bookDetailResponse!.authors,
                  price: _bookDetailResponse!.price,
                  rating: double.parse(_bookDetailResponse!.rating),
                  description: _bookDetailResponse!.desc)
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
                          "No Book Details Found",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        const Text(
                          "We couldn't find books details at the moment. \n"
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

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bookDetailsBloc;
  }
}
