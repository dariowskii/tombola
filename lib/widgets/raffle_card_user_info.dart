import 'package:flutter/material.dart';
import 'package:tombola/models/user.dart';
import 'package:tombola/widgets/single_raffle_card.dart';

class RaffleCardUserInfo extends StatelessWidget {
  const RaffleCardUserInfo({
    Key? key,
    required this.user,
    required this.extractedNumbers,
    required this.onEditUser,
  }) : super(key: key);

  final User user;
  final List<int> extractedNumbers;
  final VoidCallback onEditUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                if (extractedNumbers.isEmpty &&
                    user.raffleCards.isNotEmpty) ...[
                  IconButton(
                    onPressed: onEditUser,
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ],
            ),
            const Divider(),
            if (user.raffleCards.isEmpty) ...[
              const Text('Nessuna schedina'),
            ] else ...[
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final raffleCard = user.raffleCards[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Schedina ${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SingleRaffleCard(
                        raffleCard: raffleCard,
                        extractedNumbers: extractedNumbers,
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: user.raffleCards.length,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
