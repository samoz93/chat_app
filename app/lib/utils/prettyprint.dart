import 'dart:developer';

final prettyPrint = VarargsFunction((arguments) {
  log('------------------------');
  for (var item in arguments) {
    log("$item");
  }
  log('------------------------');
}) as dynamic;

typedef OnCall = dynamic Function(List arguments);

class VarargsFunction {
  VarargsFunction(this._onCall);

  final OnCall _onCall;

  @override
  noSuchMethod(Invocation invocation) {
    if (!invocation.isMethod || invocation.namedArguments.isNotEmpty) {
      super.noSuchMethod(invocation);
    }
    final arguments = invocation.positionalArguments;
    return _onCall(arguments);
  }
}
