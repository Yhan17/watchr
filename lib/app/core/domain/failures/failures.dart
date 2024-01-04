enum Failures {
  serviceFailure('an error occurred when the service was called'),
  repositoryFailure('an error occurred in the repository'),
  useCaseFailure('an error occurred in the use case'),
  authFailure('authentication failed'),
  accountFailure('account-related failure'),
  unknown('unknown failure'),
  deviceFailure('device-related failure');

  final String message;

  const Failures(this.message);
}
