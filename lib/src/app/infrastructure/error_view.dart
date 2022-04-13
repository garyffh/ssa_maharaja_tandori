import 'error_view_type.dart';

abstract class ErrorView {

  ErrorViewType viewTypeFromError();

  List<String>? viewErrorMessage();

}
