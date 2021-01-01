import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/presentation/controllers/app_controller.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appController = Modular.get<AppController>();

    return Observer(builder: (_) {
      return Listener(
        onPointerDown: (_) {
          final currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null)
            currentFocus.focusedChild.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Color(0xFF5F6368),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                Modular.navigator.maybePop();
              },
              child: Icon(
                UniconsLine.arrow_left,
                size: 30,
              ),
            ),
            title: Text(
              appController.searchTextFieldController.text,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          body: ListView(
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '${appController.magnetLinks.length} links has been found',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 16),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                separatorBuilder: (_, __) => Divider(
                  thickness: 1.2,
                ),
                shrinkWrap: true,
                itemCount: appController.magnetLinks.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    appController.magnetLinks.elementAt(index).torrentName,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
