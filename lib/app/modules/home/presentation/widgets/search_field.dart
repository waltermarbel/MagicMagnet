import 'package:flutter/material.dart';

import '../../../../core/presentation/controllers/app_controller.dart';

class SearchField extends StatelessWidget {
  final AppController controller;
  final Function searchMethod;

  const SearchField({
    this.controller,
    this.searchMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: 'TextField',
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          child: TextField(
            controller: controller.searchTextFieldController,
            textInputAction: TextInputAction.search,
            textCapitalization: TextCapitalization.sentences,
            enableSuggestions: true,
            enableInteractiveSelection: true,
            textAlign: TextAlign.center,
            showCursor: false,
            maxLines: 1,
            autocorrect: true,
            cursorColor: Color(0xFF5F6368),
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.w600),
            onSubmitted: (_) => searchMethod(),
            decoration: InputDecoration(
              hintMaxLines: 1,
              hintText: 'What do you wanna links for?',
              hintStyle: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w600),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
