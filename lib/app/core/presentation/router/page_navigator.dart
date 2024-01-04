part of 'config.dart';

extension PageRouteNavigation<ArgType> on AppPageRoute<ArgType> {
  Future<T?> push<T extends Object?>(
    BuildContext context, {
    required ArgType arguments,
  }) {
    return Navigator.of(
      context,
      rootNavigator: useRootNavigation,
    ).pushNamed(path, arguments: arguments);
  }

  Future<T?> pushReplacement<T extends Object?>(
    BuildContext context, {
    required ArgType arguments,
  }) {
    return Navigator.of(
      context,
      rootNavigator: useRootNavigation,
    ).pushReplacementNamed(path, arguments: arguments);
  }

  Future<T?> popAndPush<T extends Object?>(
    BuildContext context, {
    required ArgType arguments,
  }) {
    return Navigator.of(
      context,
      rootNavigator: useRootNavigation,
    ).popAndPushNamed(path, arguments: arguments);
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    RoutePredicate predicate, {
    required ArgType arguments,
  }) {
    return Navigator.of(
      context,
      rootNavigator: useRootNavigation,
    ).pushNamedAndRemoveUntil(path, predicate, arguments: arguments);
  }

  Future<T?> pushAndResetStack<T extends Object?>(
    BuildContext context, {
    required ArgType arguments,
  }) {
    bool resetPredicate(_) => false;
    return pushAndRemoveUntil(context, resetPredicate, arguments: arguments);
  }
}

class NoArgs {
  const NoArgs();
}

const noArgs = NoArgs();