import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tombola/models/game_state.dart';
import 'package:tombola/models/raffle_card_model.dart';
import 'package:tombola/models/user.dart';
import 'package:tombola/utils/number_extractor.dart';
import 'package:tombola/utils/prize_checker.dart';
import 'package:tombola/widgets/extraction_history.dart';
import 'package:tombola/widgets/last_extracted_number.dart';
import 'package:tombola/widgets/raffle_card_header.dart';
import 'package:tombola/widgets/raffle_card_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.gameState});

  final GameState? gameState;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final _extractedNumbers = widget.gameState?.extractedNumbers ?? [];
  late final NumberExtractor _numberExtractor;

  final _historyScrollController = ScrollController();

  late final _users = widget.gameState?.users ?? [];

  bool get _everyUserHasRaffleCard {
    for (var user in _users) {
      if (user.raffleCards.isEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();

    _numberExtractor = NumberExtractor(
      extractedNumbers: widget.gameState?.extractedNumbers,
    );

    if (widget.gameState != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animateHistoryScroll();
      });
    }
  }

  void _extractNumber() {
    setState(() {
      final number = _numberExtractor.extractNumber();
      if (number == null) {
        return;
      }
      _extractedNumbers.add(number);
      PrizeChecker.checkPrize(
        context,
        users: _users,
        extractedNumbers: _extractedNumbers,
      );
      _animateHistoryScroll();
    });
    _saveData();
  }

  void _animateHistoryScroll() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_historyScrollController.positions.isEmpty) {
        return;
      }

      _historyScrollController.animateTo(
        _historyScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  void _addNewUser() {
    final textFieldController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Inserisci il nome del nuovo utente'),
        content: TextField(
          controller: textFieldController,
          decoration: const InputDecoration(hintText: 'Nome'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Annulla',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _users.add(
                  User(
                    name: textFieldController.text,
                    raffleCards: <RaffleCardModel>[],
                  ),
                );
              });
            },
            child: const Text(
              'Ok',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  void _askWhoNeedRaffleCard() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Assegna la scheda'),
        content: Container(
          constraints: const BoxConstraints(maxHeight: 300),
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == 0) {
                return ListTile(
                  title: const Text('Tutti'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _addRaffleCard();
                  },
                );
              }
              final user = _users[index - 1];
              return ListTile(
                title: Text(user.name),
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    user.raffleCards.add(RaffleCardModel());
                  });
                },
              );
            },
            itemCount: _users.length + 1,
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

  void _addRaffleCard() {
    setState(() {
      for (var user in _users) {
        user.raffleCards.add(RaffleCardModel());
      }
    });
  }

  void _saveData() async {
    final state = GameState(extractedNumbers: _extractedNumbers, users: _users);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gameState', jsonEncode(state));
  }

  void _deleteData() async {
    setState(() {
      _users.clear();
      _extractedNumbers.clear();
      _animateHistoryScroll();
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tombola!'),
        centerTitle: true,
        actions: [
          if (_extractedNumbers.isEmpty) ...[
            IconButton(
              onPressed: _addNewUser,
              icon: const Icon(Icons.person_add),
            ),
          ],
          IconButton(onPressed: _deleteData, icon: const Icon(Icons.delete)),
        ],
        leading: IconButton(onPressed: _saveData, icon: const Icon(Icons.save)),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            LastExtractedNumber(
              lastExtractedNumber:
                  _extractedNumbers.isEmpty ? 0 : _extractedNumbers.last,
            ),
            // ExtractionHistory(
            //   extractedNumbers: _extractedNumbers,
            //   scrollController: _historyScrollController,
            // ),
            RaffleCardHeader(
              onTapAdd: _askWhoNeedRaffleCard,
              canAddTables: _extractedNumbers.isEmpty && _users.isNotEmpty,
            ),
            RaffleCardList(
              users: _users,
              extractedNumbers: _extractedNumbers,
              onEditUserRaffleCards: (user, raffleCard) {
                setState(() {
                  user.raffleCards.remove(raffleCard);
                });
              },
            ),
            SliverToBoxAdapter(child: Container(height: 80)),
          ],
        ),
      ),
      floatingActionButton: _users.length > 1 && _everyUserHasRaffleCard
          ? FloatingActionButton(
              onPressed: _extractNumber,
              child: const Icon(Icons.model_training),
            )
          : null,
    );
  }
}
