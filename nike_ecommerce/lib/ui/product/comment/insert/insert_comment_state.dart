part of 'insert_comment_bloc.dart';

abstract class InsertCommentState extends Equatable {
  const InsertCommentState();

  @override
  List<Object?> get props => [];
}

class InsertCommentInitial extends InsertCommentState {
  @override
  List<Object> get props => [];
}

class InsertCommentError extends InsertCommentState {
  final AppException appException;

  const InsertCommentError(this.appException);

  @override
  List<Object?> get props => [appException];
}

class InsertCommentLoading extends InsertCommentState{}

class InsertCommentSuccess extends InsertCommentState{
  final CommentEntity commentEntity;
  final String message;

  const InsertCommentSuccess(this.commentEntity, this.message);

  @override
  List<Object?> get props => [message,commentEntity];

}