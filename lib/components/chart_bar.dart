import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
  });

  final String label;
  final double value;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Column(
          children: <Widget>[
            //ADAPTADOR DE TAMANHOS DISPONÍVEIS
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text('\$${value.toStringAsFixed(2)}'),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            SizedBox(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  //PROGRESS_BAR-body
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  //PROGRESS_BAR-value
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                        decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(5),
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(label)),
            )
          ],
        );
      },
    );
  }
}
