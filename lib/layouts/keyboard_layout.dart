import 'package:flutter/material.dart';
import 'package:waytowordle/models/alphabet.dart';

const layout = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '←'],
  [' ', 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ' ', ' '],
  [' ', ' ', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', ' ', '↩'],
];

class Keyboard extends StatelessWidget {
  final VoidCallback onEnter;
  final VoidCallback onDelete;
  final void Function(String) onKey;
  final Set<Alphabet> scrabbleTiles;

  const Keyboard({Key? key, required this.onEnter, required this.onDelete, required this.onKey, required this.scrabbleTiles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 528),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: layout
              .map(
                (row) => SizedBox(
                  height: 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: row.map((e) {
                      switch (e) {
                        case '←':
                          return Flexible(
                            flex: 1,
                            child: _KeyboardButton(letter: e, backgroundColor: Colors.red, onPressed: onDelete),
                          );

                        case '↩':
                          return Flexible(
                            flex: 2,
                            child: _KeyboardButton(letter: e, backgroundColor: Colors.green, onPressed: onEnter),
                          );
                        case ' ':
                          return const Spacer();

                        default:
                          final Alphabet tileInBag = scrabbleTiles.firstWhere((element) => element.letter == e, orElse: () => Alphabet(letter: ' '));

                          if (tileInBag.bgColor == Colors.grey) {
                            return const Spacer();
                          } else {
                            return Flexible(
                              child: _KeyboardButton(
                                letter: e,
                                backgroundColor: tileInBag.letter != ' ' ? tileInBag.bgColor : Colors.grey,
                                onPressed: () => onKey(e),
                              ),
                            );
                          }
                      }
                    }).toList(),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _KeyboardButton extends StatelessWidget {
  final String letter;
  final Color backgroundColor;

  final VoidCallback onPressed;

  const _KeyboardButton({Key? key, required this.letter, this.backgroundColor = Colors.grey, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            child: Center(
                child: Text(
              letter,
              style: const TextStyle(fontWeight: FontWeight.w500),
            )),
          ),
        ),
      ),
    );
  }
}
