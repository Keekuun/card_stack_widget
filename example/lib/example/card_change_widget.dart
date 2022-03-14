import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:flutter/material.dart';

class CardChangeWidget extends StatefulWidget {
  const CardChangeWidget({Key? key}) : super(key: key);

  @override
  _CardChangeWidgetState createState() => _CardChangeWidgetState();
}

class _CardChangeWidgetState extends State<CardChangeWidget> {
  bool _opacityChangeOnDrag = false;

  bool _reverseOrder = false;

  double _positionFactorValue = 1.5;

  double _scaleFactorValue = 1;

  Radius _radius = const Radius.circular(16.0);

  final _radiusController = TextEditingController();

  final _positionFactorController = TextEditingController();

  final _scaleFactorController = TextEditingController();

  CardOrientation? _cardDismissOrientationValue;

  CardOrientation? _swipeOrientation;

  @override
  void initState() {
    super.initState();

    _positionFactorController.text = _positionFactorValue.toString();
    _scaleFactorController.text = _scaleFactorValue.toString();
    _radiusController.text = _radius.x.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CardStackWidget example'),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                controller: _radiusController,
                onChanged: (value) {
                  final convertedValue = double.tryParse(value);
                  if (convertedValue != null) {
                    setState(() {
                      _radius = Radius.circular(convertedValue);
                    });
                  }
                },
                decoration: const InputDecoration(labelText: 'Radius card'),
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                controller: _positionFactorController,
                onChanged: (value) {
                  final convertedValue = double.tryParse(value);
                  if (convertedValue != null) {
                    setState(() {
                      _positionFactorValue = convertedValue;
                    });
                  }
                },
                decoration: const InputDecoration(labelText: 'Position factor'),
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                controller: _scaleFactorController,
                decoration: const InputDecoration(labelText: 'Scale factor'),
                onChanged: (value) {
                  final convertedValue = double.tryParse(value);
                  if (convertedValue != null) {
                    setState(() {
                      _scaleFactorValue = convertedValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Reverse order'),
                  const SizedBox(width: 8),
                  Switch.adaptive(
                    value: _reverseOrder,
                    onChanged: (value) {
                      setState(() {
                        _reverseOrder = value;
                      });
                    },
                  ),
                  const SizedBox(width: 16),
                  const Text('Opacity on drag'),
                  const SizedBox(width: 8),
                  Switch.adaptive(
                    value: _opacityChangeOnDrag,
                    onChanged: (value) {
                      setState(() {
                        _opacityChangeOnDrag = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Card dismiss orientation',
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<CardOrientation>(
                    items: CardOrientation.values
                        .map(
                          (e) => DropdownMenuItem<CardOrientation>(
                            child: Text(
                              e.toString(),
                            ),
                            value: e,
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _cardDismissOrientationValue = value;
                      });
                    },
                    hint: Text(
                      _cardDismissOrientationValue?.toString().split('.')[1] ??
                          '',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Swipe orientation',
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<CardOrientation>(
                    items: CardOrientation.values
                        .map(
                          (e) => DropdownMenuItem<CardOrientation>(
                            child: Text(
                              e.toString(),
                            ),
                            value: e,
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _swipeOrientation = value;
                      });
                    },
                    hint: Text(
                      _swipeOrientation?.toString().split('.')[1] ?? '',
                    ),
                  ),
                ],
              ),
              Expanded(
                child: _buildCardStackWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardStackWidget() {
    return CardStackWidget(
      opacityChangeOnDrag: _opacityChangeOnDrag,
      positionFactor: double.tryParse(_positionFactorController.text),
      scaleFactor: double.tryParse(_scaleFactorController.text),
      cardList: _buildMockListCard(),
      alignment: Alignment.center,
      reverseOrder: _reverseOrder,
      cardDismissOrientation: _cardDismissOrientationValue,
      swipeOrientation: _swipeOrientation,
    );
  }

  List<CardModel> _buildMockListCard() {
    final width = MediaQuery.of(context).size.width - 32;
    const height = 150.0;

    const colors = [
      Colors.red,
      Colors.green,
      Colors.white,
      Colors.grey,
      Colors.yellow,
    ];

    var list = <CardModel>[];
    for (int index = 0; index < colors.length; index++) {
      var color = colors[index];

      list.add(
        CardModel(
          key: Key("$index"),
          backgroundColor: color,
          radius: _radius,
          shadowColor: Colors.black.withOpacity(0.2),
          child: Container(
            height: height,
            width: width,
            alignment: Alignment.topCenter,
            child: Text("$index"),
          ),
        ),
      );
    }

    return list;
  }
}
