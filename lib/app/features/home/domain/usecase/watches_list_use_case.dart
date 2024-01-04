import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/watch_entity.dart';
import '../../../../core/domain/failures/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../services/watches_service.dart';

class WatchesListUseCase
    extends UseCaseStream<Failures, List<WatchEntity>, NoParams> {
  final WatchesService _watchesService;

  WatchesListUseCase(this._watchesService);
  @override
  Stream<Either<Failures, List<WatchEntity>>> call(NoParams params) {
    return _watchesService.listWatches();
  }
}
