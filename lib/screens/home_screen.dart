import 'package:add_card/gen/assets.gen.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FlipCardController _flipCardController;
  late TextEditingController name, cardNumber, expiryDate, cvv;

  @override
  void initState() {
    super.initState();
    _flipCardController = FlipCardController();
    name = TextEditingController();
    cardNumber = TextEditingController();
    expiryDate = TextEditingController();
    cvv = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlipCard(
            controller: _flipCardController,
            flipOnTouch: false,
            front: Container(
              margin: const EdgeInsets.all(15.0),
              height: 190.0,
              width: double.maxFinite,
              child: CardFromtWidget(
                cardNumber: cardNumber,
                name: name,
                expiryDate: expiryDate,
              ),
            ),
            back: Container(
              margin: const EdgeInsets.all(15.0),
              height: 190.0,
              width: double.maxFinite,
              child: CardBackWidget(cvv: cvv),
            ),
          ),
          const SizedBox(height: 20.0),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "CARD DETAILS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 10.0,
            ),
            child: TextFormField(
              controller: name,
              autocorrect: false,
              inputFormatters: [
                LengthLimitingTextInputFormatter(16),
                NameInputFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[A-Z ]'))
              ],
              onChanged: (value) {
                setState(() {});
              },
              onTap: () {
                if (_flipCardController.state?.isFront == false) {
                  _flipCardController.toggleCard();
                }
              },
              decoration: InputDecoration(
                labelText: "Name on the card",
                counterText: "",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 15.0,
            ),
            child: TextFormField(
              controller: cardNumber,
              onTap: () {
                if (_flipCardController.state?.isFront == false) {
                  _flipCardController.toggleCard();
                }
              },
              onChanged: (value) {
                setState(() {});
              },
              keyboardType: TextInputType.number,
              autocorrect: false,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CreditCardInputFormat(),
                LengthLimitingTextInputFormatter(19),
              ],
              decoration: InputDecoration(
                labelText: "Card number",
                hintText: "XXXX XXXX XXXX XXXX",
                counterText: "",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 15.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: expiryDate,
                    onTap: () {
                      if (_flipCardController.state?.isFront == false) {
                        _flipCardController.toggleCard();
                      }
                    },
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ExpiryDateInputFormatter(),
                      LengthLimitingTextInputFormatter(5),
                    ],
                    decoration: InputDecoration(
                      labelText: "Expiry Date",
                      hintText: "XX/XX",
                      counterText: "",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: cvv,
                    onTap: () {
                      if (_flipCardController.state?.isFront == true) {
                        _flipCardController.toggleCard();
                      }
                    },
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    decoration: InputDecoration(
                      labelText: "CVV",
                      counterText: "",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            height: 50.0,
            margin: const EdgeInsets.all(10.0),
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {},
              child: const Text("Add Card"),
            ),
          ),
        ],
      ),
    );
  }
}

class CardBackWidget extends StatelessWidget {
  const CardBackWidget({
    super.key,
    required this.cvv,
  });

  final TextEditingController cvv;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15.0,
      shadowColor: Colors.blue,
      borderOnForeground: false,
      margin: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            Positioned(
              bottom: 5.0,
              right: 15.0,
              child: SizedBox.square(
                  dimension: 50.0, child: Assets.images.visa.svg()),
            ),
            Positioned(
              top: 30.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: 50.0,
                color: Colors.black,
              ),
            ),
            Positioned(
              top: 90.0,
              left: 10.0,
              right: 0.0,
              child: Text.rich(
                TextSpan(
                  text: "CVV:",
                  children: [
                    const WidgetSpan(child: SizedBox(width: 10.0)),
                    TextSpan(
                      text: cvv.text.trim().isEmpty ? "XXX" : cvv.text.trim(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: 6.0,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardFromtWidget extends StatelessWidget {
  const CardFromtWidget({
    super.key,
    required this.cardNumber,
    required this.name,
    required this.expiryDate,
  });

  final TextEditingController cardNumber;
  final TextEditingController name;
  final TextEditingController expiryDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.blue,
      elevation: 15.0,
      borderOnForeground: false,
      margin: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(color: Colors.white),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5.0,
              right: 15.0,
              child: SizedBox.square(
                  dimension: 50.0, child: Assets.images.visa.svg()),
            ),
            Positioned(
              top: 50.0,
              left: 12.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Card number",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    cardNumber.text.trim().isEmpty
                        ? "XXXX XXXX XXXX XXXX"
                        : cardNumber.text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 30.0,
              left: 10.0,
              child: Text(
                name.text.trim().isEmpty
                    ? "NAME ON THE CARD"
                    : name.text.trim(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
                bottom: 20.0,
                right: 30.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "EXPIRY DATE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                    Text(
                      expiryDate.text.trim().isEmpty
                          ? "XX/XX"
                          : expiryDate.text.trim(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class NameInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text.toUpperCase(),
        selection: TextSelection.collapsed(offset: newValue.text.length));
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    final data = newValue.text;
    final buffer = StringBuffer();

    for (var i = 0; i < data.length; i++) {
      buffer.write(data[i]);
      final index = i + 1;
      if (index % 2 == 0 && data.length != index) {
        buffer.write("/");
      }
    }
    return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer.toString().length));
  }
}

class CreditCardInputFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    final enteredData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < enteredData.length; i++) {
      buffer.write(enteredData[i]);
      final index = i + 1;
      if (index % 4 == 0 && enteredData.length != index) {
        buffer.write(" ");
      }
    }

    return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer.toString().length));
  }
}
