import 'package:flutter/material.dart';
import 'package:magic_magnet_engine/magic_magnet_engine.dart';

class MagnetLinkCard extends StatefulWidget {
  final MagnetLink magnetLink;

  const MagnetLinkCard({this.magnetLink});

  @override
  _MagnetLinkCardState createState() => _MagnetLinkCardState();
}

class _MagnetLinkCardState extends State<MagnetLinkCard> {
  var isMouseOver = false;

  void toggleMouseOnState(bool value) {
    setState(() {
      isMouseOver = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) {
        toggleMouseOnState(true);
      },
      onExit: (_) {
        toggleMouseOnState(false);
      },
      child: Material(
        color: Color(0xFFF1F3F4),
        elevation: isMouseOver ? 4 : 0,
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        child: InkWell(
          child: Container(
            width: 300,
            height: 160,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.magnetLink.torrentName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Material(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          splashColor:
                              Theme.of(context).primaryColor.withOpacity(0.8),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12.0,
                            ),
                            child: Center(
                                child: Text(
                              'Copy',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(color: Colors.transparent),
                    Expanded(
                      child: Material(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          splashColor:
                              Theme.of(context).accentColor.withOpacity(0.8),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 12.0,
                            ),
                            child: Center(
                                child: Text(
                              'Open',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
