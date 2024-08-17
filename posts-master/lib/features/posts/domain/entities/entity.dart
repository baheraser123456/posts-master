import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final int? skip;
  final int? limit;

  const PostEntity({this.skip, this.limit});

  @override
  List<Object?> get props => [skip, limit];
}
