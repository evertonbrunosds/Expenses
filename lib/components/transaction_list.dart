import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
      {super.key, required this.transactions, required this.onRemove});

  final void Function(String) onRemove;

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Nenhuma Transação Cadastrada',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: transactions.length, //QUANTIDADE DE ITENS NA LISTA
            itemBuilder: (_, index) {
              //CONSTRUÇÃO DE ITEM POR DEMANDA
              final transaction = transactions[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('R\$${transaction.value}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transaction.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(transaction.date),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () => onRemove(transaction.id),
                  ),
                ),
              );
            },
          );
  }
}
