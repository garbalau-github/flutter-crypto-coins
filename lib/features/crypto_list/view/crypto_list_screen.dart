import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:flutter/material.dart';
import 'package:crypto_coins_list/features/crypto_list/widgets/widgets.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});

  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  List<CryptoCoin>? _cryptoCoinsList;

  @override
  void initState() async {
    await _loadCryptoCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Text(widget.title),
      ),
      body: _cryptoCoinsList == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.only(top: 16),
              itemCount: _cryptoCoinsList!.length,
              separatorBuilder: (context, index) => const Divider(
                    color: Colors.white10,
                  ),
              itemBuilder: (context, i) {
                final coin = _cryptoCoinsList![i];
                return CryptoCoinTile(coin: coin);
              }),
    );
  }

  Future<void> _loadCryptoCoins() async {
    _cryptoCoinsList = await CryptoCoinsRepository().getCoinsList();
    setState(() {});
  }
}