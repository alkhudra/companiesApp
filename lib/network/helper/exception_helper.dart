class ExceptionHelper implements Exception{

  final dynamic message;

  ExceptionHelper([this.message]);

  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "$message";
  }


}