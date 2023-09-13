import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_ecommerce/common/exceptions.dart';
import 'package:nike_ecommerce/data/comment.dart';
import 'package:nike_ecommerce/data/repo/auth_repository.dart';
import 'package:nike_ecommerce/data/repo/comment_repository.dart';

part 'insert_comment_event.dart';

part 'insert_comment_state.dart';

class InsertCommentBloc extends Bloc<InsertCommentEvent, InsertCommentState> {
  final int productId;
  final ICommentRepository commentRepository;

  InsertCommentBloc(this.productId, this.commentRepository)
      : super(InsertCommentInitial()) {
    on<InsertCommentEvent>((event, emit) async {
      if (event is InsertCommentFormSubmit) {
        if (!AuthRepository.isUserLoggedIn()) {
          emit(InsertCommentError(
              AppException(message: 'لطفا وارد حساب کاربری خود شوید')));
        } else {
          if (event.title.isNotEmpty && event.content.isNotEmpty) {
            try {
              emit(InsertCommentLoading());
              final comment = await commentRepository.insert(
                  event.title, event.content, productId);
              emit(InsertCommentSuccess(comment,'نظر شما با موفقیت ثبت شد و پس از تایید منتشر خواهد شد'));
            } catch (e) {
              emit(InsertCommentError(AppException()));
            }
          } else {
            emit(InsertCommentError(
                AppException(message: 'عنوان و متن نظر خود را وارد کنید')));
          }
        }
      }
    });
  }
}
