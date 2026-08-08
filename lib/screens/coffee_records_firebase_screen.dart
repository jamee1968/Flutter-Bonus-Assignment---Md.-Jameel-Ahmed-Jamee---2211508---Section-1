import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summer_iub_app/models/coffee_records_model.dart';
import 'package:summer_iub_app/state_management/coffee_state_management.dart';
import 'package:summer_iub_app/widgets/app_backgroud_design_widget.dart';

class CoffeeRecordsFirebaseScreen extends StatefulWidget {
  const CoffeeRecordsFirebaseScreen({super.key});

  @override
  State<CoffeeRecordsFirebaseScreen> createState() =>
      _CoffeeRecordsFirebaseScreenState();
}

class _CoffeeRecordsFirebaseScreenState
    extends State<CoffeeRecordsFirebaseScreen> {
  int _quickTestCounter = 0;

  @override
  Widget build(BuildContext context) {
    final csm = Provider.of<CoffeeStateManagement>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Coffee Records (Live)",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.00),
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: AppBackgroudDesignWidget(
        child: StreamBuilder<List<CoffeeRecordsModel>>(
          stream: csm.getCoffeeRecordsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No coffee records yet."));
            }

            final records = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.coffee),
                    title: Text(record.title ?? ''),
                    subtitle: Text(
                        "${record.des} - Amount: ${record.amount} - Doc: ${record.docId}"),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          csm.quickTestCounter++;
          final testRecord = CoffeeRecordsModel(
            id: DateTime.now().microsecondsSinceEpoch,
            title: "New Coffee Record ${csm.quickTestCounter}",
            des: "This is a TEST DATA",
            amount: 10.0,
            date: DateTime.now(),
          );

          await csm.addCoffeeRecordToFirebase(testRecord);
        },
        backgroundColor: Colors.brown,
        child: const Icon(Icons.local_cafe, color: Colors.white),
      ),
    );
  }
}