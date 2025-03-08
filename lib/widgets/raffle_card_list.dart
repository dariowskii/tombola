import 'package:flutter/material.dart';
import 'package:tombola/models/raffle_card_model.dart';
import 'package:tombola/models/user.dart';
import 'package:tombola/widgets/raffle_card_user_info.dart';

class RaffleCardList extends StatelessWidget {
  const RaffleCardList({
    super.key,
    required this.users,
    required this.extractedNumbers,
    required this.onEditUserRaffleCards,
  });

  final List<User> users;
  final List<int> extractedNumbers;
  final Function(User user, RaffleCardModel raffleCard) onEditUserRaffleCards;

  void _editUserRaffleCards(BuildContext context, User user) {
    // show dialog to edit user raffle cards
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Elimina schede di ${user.name}'),
        content: Container(
          constraints: const BoxConstraints(maxHeight: 300),
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final raffleCard = user.raffleCards[index];
              return ListTile(
                title: Text("Scheda ${index + 1}"),
                onTap: () {
                  Navigator.of(context).pop();
                  onEditUserRaffleCards(user, raffleCard);
                },
              );
            },
            itemCount: user.raffleCards.length,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Ok',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => RaffleCardUserInfo(
            user: users[index],
            extractedNumbers: extractedNumbers,
            onEditUser: () => _editUserRaffleCards(context, users[index]),
          ),
          childCount: users.length,
        ),
      ),
    );
  }
}
