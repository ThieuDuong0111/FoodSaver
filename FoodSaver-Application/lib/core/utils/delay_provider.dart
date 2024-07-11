import 'package:injectable/injectable.dart';

abstract class DelayProvider {
  Future<void> delay(int milliseconds);
}

@LazySingleton(as: DelayProvider)
class DelayProviderImpl implements DelayProvider {
  @override
  Future<void> delay(int milliseconds) => Future.delayed(Duration(milliseconds: milliseconds));
}
