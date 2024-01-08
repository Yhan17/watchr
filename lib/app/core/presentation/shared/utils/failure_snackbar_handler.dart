import 'package:flutter/material.dart';

import '../../../domain/failures/failures.dart';

class FailureSnackbarHandler {
  static handleFailure(Failures failure, BuildContext context) {
    switch (failure) {
      case Failures.serviceFailure:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
          ),
        );
        break;
      case Failures.repositoryFailure:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
          ),
        );
        break;
      case Failures.useCaseFailure:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
          ),
        );
        break;
      case Failures.authFailure:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
          ),
        );
        break;
      case Failures.accountFailure:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
          ),
        );
        break;
      case Failures.unknown:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
          ),
        );
        break;
      case Failures.deviceFailure:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
          ),
        );
        break;
    }
  }
}
