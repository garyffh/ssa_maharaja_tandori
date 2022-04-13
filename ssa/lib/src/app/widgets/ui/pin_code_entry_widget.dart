import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

import '../form/form_error_message_widget.dart';

class PinCodeEntryWidget extends StatefulWidget {
  const PinCodeEntryWidget(
      {required this.onSubmit, this.fieldCount = 6, Key? key})
      : super(key: key);

  final ValueChanged<String>? onSubmit;
  final int fieldCount;

  @override
  State<StatefulWidget> createState() => _PinCodeEntryWidgetState();
}

class _PinCodeEntryWidgetState extends State<PinCodeEntryWidget> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  List<String>? _localErrorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _pinPut(context),
        FormErrorMessageWidget(
          errorMessage: _localErrorMessage,
        ),
        _buttons(context),
      ],
    );
  }

  Widget _pinPut(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
            maxWidth: context.watch<MediaSettingsBloc>().state.sp(80)),
        child: PinPut(
          textStyle: TextStyle(
            fontSize: context.watch<MediaSettingsBloc>().state.sp(30),
          ),
          eachFieldConstraints: BoxConstraints(
            minHeight: context.watch<MediaSettingsBloc>().state.sp(28),
            minWidth: context.watch<MediaSettingsBloc>().state.sp(28),
          ),
          checkClipboard: true,
          autovalidateMode: AutovalidateMode.always,
          autofocus: true,
          fieldsCount: widget.fieldCount,
          onSubmit: widget.onSubmit,
          focusNode: _pinPutFocusNode,
          controller: _pinPutController,
          submittedFieldDecoration: _pinPutDecoration(context).copyWith(
            borderRadius: BorderRadius.circular(
                context.watch<MediaSettingsBloc>().state.sp(20)),
          ),
          selectedFieldDecoration: _pinPutDecoration(context),
          followingFieldDecoration: _pinPutDecoration(context).copyWith(
            borderRadius: BorderRadius.circular(
                context.watch<MediaSettingsBloc>().state.sp(5)),
            border: Border.all(
              color: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(.5),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _pinPutDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).colorScheme.secondaryContainer),
      borderRadius: BorderRadius.circular(
          context.watch<MediaSettingsBloc>().state.sp(15)),
    );
  }

  Widget _buttons(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: context.watch<MediaSettingsBloc>().state.sp(360)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            style: context.watch<MediaSettingsBloc>().state.elevatedButtonStyle,
            onPressed: () {
              _pinPutController.text = '';
              setState(() {
                _localErrorMessage = null;
                _pinPutFocusNode.requestFocus();
              });
            },
            child: Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.autorenew_rounded,
                  size: context.watch<MediaSettingsBloc>().state.buttonIconSize,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context
                        .watch<MediaSettingsBloc>()
                        .state
                        .buttonIconSpacing,
                  ),
                ),
                Text(
                  'Clear',
                  style: TextStyle(
                    fontSize:
                    context.watch<MediaSettingsBloc>().state.buttonFontSize,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: context.watch<MediaSettingsBloc>().state.elevatedButtonStyle,
            child: Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.paste,
                  size: context.watch<MediaSettingsBloc>().state.buttonIconSize,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context
                        .watch<MediaSettingsBloc>()
                        .state
                        .buttonIconSpacing,
                  ),
                ),
                Text(
                  'Paste',
                  style: TextStyle(
                    fontSize:
                        context.watch<MediaSettingsBloc>().state.buttonFontSize,
                  ),
                ),
              ],
            ),
            onPressed: () async {
              final String clipboardText = (await FlutterClipboard.paste())
                  .replaceAll(RegExp(r'[^0-9]'), '');
              if (clipboardText.isNotEmpty && clipboardText.length == 6) {
                _pinPutController.text = clipboardText;
                setState(() {
                  _localErrorMessage = null;
                });
              } else {
                setState(() {
                  _pinPutController.text = '';
                  setState(() {
                    _localErrorMessage = ['Invalid Code', clipboardText];
                  });
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
