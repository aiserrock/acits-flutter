import 'package:flutter/material.dart';

@immutable
class PagingFilter {
  const PagingFilter(this.limit, this.offset, this.search);

  final String? limit;
  final String? offset;
  final String? search;
}
