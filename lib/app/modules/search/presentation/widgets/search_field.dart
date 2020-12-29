import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../pages/search_page.dart';
import 'package:unicons/unicons.dart';

import '../controllers/search_page_controller.dart';

class SearchField extends StatefulWidget {
  final SearchPageController controller;

  const SearchField({this.controller});

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  var isMouseOver = false;

  void toggleMouseOnState(bool value) {
    setState(() {
      isMouseOver = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    void search() async {
      await widget.controller
          .performSearch(widget.controller.searchTextFieldController.text);

      if (context.findAncestorWidgetOfExactType<SearchPage>() != null) {
        Modular.navigator.pushReplacementNamed('/result');
      }
    }

    return Container(
      constraints: BoxConstraints(maxWidth: 584),
      child: MouseRegion(
        onHover: (_) {
          toggleMouseOnState(true);
        },
        onExit: (_) {
          toggleMouseOnState(false);
        },
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          elevation: isMouseOver ? 4 : 0,
          color: Color(0xFFF7F7F7),
          child: TextField(
            controller: widget.controller.searchTextFieldController,
            textInputAction: TextInputAction.search,
            textCapitalization: TextCapitalization.sentences,
            enableSuggestions: true,
            enableInteractiveSelection: true,
            textAlign: TextAlign.center,
            showCursor: false,
            maxLines: 1,
            autocorrect: true,
            cursorColor: Color(0xFF5F6368),
            style: Theme.of(context).textTheme.headline6,
            onSubmitted: (_) => search(),
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: search,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    UniconsLine.search,
                    size: 24,
                    color: Color(0xFF5F6368),
                  ),
                ),
              ),
              filled: true,
              fillColor: Color(0xFFF1F3F4),
              hoverColor: Color(0xFFF7F7F7),
              hintMaxLines: 1,
              hintText: 'Search for something',
              hintStyle: Theme.of(context).textTheme.headline6,
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
