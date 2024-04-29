import 'package:flutter/material.dart';

class CreditCardItem extends StatefulWidget {
  const CreditCardItem({
    super.key,
    required this.color,
    required this.numberCard,
    required this.nameUser,
    required this.dateExpiredCard,
    required this.nameCard,
  });

  final Color color;
  final String numberCard;
  final String nameCard;
  final String nameUser;
  final String dateExpiredCard;

  @override
  State<CreditCardItem> createState() => _CreditCardItemState();
}

class _CreditCardItemState extends State<CreditCardItem> {
  double _height = 80.0;
  bool _isExpanded = false;
  double _borderBottom = 0.0;

  void _updateHeight() {
    setState(() {
      _height = _isExpanded ? 80.0 : 210.0;
      _borderBottom = _isExpanded ? 0.0 : 8.0;
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 4, left: 16, right: 16),
        child: GestureDetector(
          onTap: () {
            _updateHeight();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _height,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(8.0),
                topRight: const Radius.circular(8.0),
                bottomLeft: Radius.circular(_borderBottom),
                bottomRight: Radius.circular(_borderBottom),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child:
            ScrollConfiguration(
                behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child:
                  Stack(
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.nameCard,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.flag,
                            color: Colors.white,
                            size: 40,
                          ),
                        ],
                      ),
                      Column(
                          children: [
                            const SizedBox(height: 60.0),
                            Row(
                              children: [
                                Text(
                                  widget.numberCard,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              children: [
                                Text(
                                  widget.nameUser,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const Spacer(),
                                Text(
                                  widget.dateExpiredCard,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                )),
          ),
        ));
  }
}
