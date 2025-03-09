import 'package:flutter/material.dart';
import 'package:tombola/models/raffle_card_model.dart';

class SingleRaffleCard extends StatelessWidget {
  const SingleRaffleCard({
    super.key,
    required this.raffleCard,
    required this.extractedNumbers,
  });

  final RaffleCardModel raffleCard;
  final List<int> extractedNumbers;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      crossAxisCount: 9,
      children: raffleCard.rows.map((number) {
        final isExtracted = extractedNumbers.contains(number);
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
          ),
          child: number == 0
              ? const SizedBox()
              : Center(
                  child: Container(
                    padding: EdgeInsets.all(number < 10 ? 7 : 5),
                    decoration: isExtracted
                        ? const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          )
                        : null,
                    child: Text(
                      number.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isExtracted ? FontWeight.bold : null,
                        color: isExtracted ? Colors.white : null,
                      ),
                    ),
                  ),
                ),
        );
      }).toList(),
    );
  }
}
