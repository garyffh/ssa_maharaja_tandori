import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_store_app/src/app/services/media_settings/media_settings_bloc.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          context.watch<MediaSettingsBloc>().state.sp16,
        ),
        border: Border.all(),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.watch<MediaSettingsBloc>().state.sp8,
      ),
      margin: EdgeInsets.only(
        bottom: context.watch<MediaSettingsBloc>().state.sp16,
      ),
      child: TextField(
        autofocus: true,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: context.watch<MediaSettingsBloc>().state.sp16,
          ),
          icon: Icon(
            Icons.search,
            color: Theme.of(context).iconTheme.color,
            size: context.watch<MediaSettingsBloc>().state.sp(22),
          ),
          hintText: widget.hintText,
          hintStyle: context.watch<MediaSettingsBloc>().state.bodyText1,
          border: InputBorder.none,
        ),
        style: context.watch<MediaSettingsBloc>().state.bodyText1,
        onChanged: widget.onChanged,
      ),
    );
  }
}
