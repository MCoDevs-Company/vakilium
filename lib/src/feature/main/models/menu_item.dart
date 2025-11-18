import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class MenuItem extends Equatable {
  const MenuItem({required this.slug, required this.page});
  
  final String slug;
  final Widget? page;

  @override
  List<Object?> get props => [slug];
}
