import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/presentation/controllers/app_controller.dart';
import '../widgets/rounded_button.dart';

class DetailModal extends StatelessWidget {
  final int index;

  const DetailModal({this.index});

  @override
  Widget build(BuildContext context) {
    final appController = Modular.get<AppController>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(16),
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: 32),
          Text(
            'Torrent name',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Center(
            child: Text(
              appController.magnetLinks.elementAt(index).torrentName,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Divider(
            thickness: 0.5,
            height: 25,
            color: Color(0xFF5F6368),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Avaliability',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                '${appController.magnetLinks.elementAt(index).seeders} seeders',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 2),
              Text(
                '${appController.magnetLinks.elementAt(index).leechers} leechers',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 2),
              Text(
                '97% healty (ratio between seeders and leechers)',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
            height: 25,
            color: Color(0xFF5F6368),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Original source',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                'https://source.com/link',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
            height: 25,
            color: Color(0xFF5F6368),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Avaliable actions',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RoundedButton(
                    color: Theme.of(context).accentColor,
                    padding: EdgeInsets.all(16),
                    onTap: () {},
                    child: Center(
                      child: Text(
                        'Copy link',
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  RoundedButton(
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(16),
                    onTap: () {},
                    child: Center(
                      child: Text(
                        'Open link',
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
