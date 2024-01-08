import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'history_tile.dart';
import '../../providers/history.dart';

class HistoryList extends StatelessWidget {
  final bool isStandard;
  const HistoryList({required this.isStandard, super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(builder: (context, historyProv, _) {
      final List<String> calcHistory = isStandard
          ? historyProv.standardHistory
          : historyProv.scientificHistory;
      return calcHistory.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: calcHistory.length,
                      itemBuilder: (context, index) {
                        final List<String> history =
                            calcHistory[index].split(":");
                        return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) => historyProv
                                .removeFromHistory(index, standard: isStandard),
                            child: HistoryTile(
                              expression: history[0],
                              answer: history[1],
                              isStandard: isStandard,
                            ));
                      }),
                ),
                TextButton(
                    onPressed: () =>
                        historyProv.clearHistory(standard: isStandard),
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.transparent),
                      overlayColor:
                          MaterialStatePropertyAll<Color>(Colors.transparent),
                    ),
                    child: const Icon(Icons.delete_outlined,
                        color: Colors.white, size: 35))
              ],
            )
          : const Center(
              child: Text("There's no history yet",
                  style: TextStyle(color: Colors.white, fontSize: 20)));
    });
  }
}
