// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../services/watches_service.dart';

class WatchesListUseCase
    extends UseCaseStream<Failures, List<WatchEntity>, FilterParams> {
  final WatchesService _watchesService;

  WatchesListUseCase(this._watchesService);
  @override
  Stream<Either<Failures, List<WatchEntity>>> call(FilterParams params) {
    return _watchesService.listWatches();
  }
}

class FilterParams {
  final DateTime? date;
  final String? price;
  final bool? orderBy;
  FilterParams({
    this.date,
    this.price,
    this.orderBy,
  });
}
