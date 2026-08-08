import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:summer_iub_app/models/coffee_records_model.dart';
import 'package:summer_iub_app/utility/constant.dart';

class CoffeeStateManagement with ChangeNotifier {
  List<CoffeeRecordsModel> items = [];
  int quickTestCounter = 0; 

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Keep existing local method for quick testing
  void addData() {
    items.add(
      CoffeeRecordsModel(
        id: DateTime.now().microsecondsSinceEpoch,
        title: "Coffee Record ${items.length + 1}",
        des: "Details about Coffee Record ${items.length + 1}",
        amount: 10.0,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void addCoffeeRecord(CoffeeRecordsModel coffeeRecord) {
    items.add(
      CoffeeRecordsModel(
        id: DateTime.now().microsecondsSinceEpoch,
        title: coffeeRecord.title,
        des: coffeeRecord.des,
        amount: coffeeRecord.amount,
        date: coffeeRecord.date,
      ),
    );
    notifyListeners();
  }

  // Firebase integration methods for Step 7
  Future<void> addCoffeeRecordToFirebase(CoffeeRecordsModel coffeeRecord) async {
    final dataModel = CoffeeRecordsModel(
      id: DateTime.now().microsecondsSinceEpoch,
      title: coffeeRecord.title,
      des: coffeeRecord.des,
      amount: coffeeRecord.amount,
      date: coffeeRecord.date,
    );

    final response = await _firestore
        .collection(FirebaseConstant.coffeeRecordsCollection)
        .add(dataModel.toJson());

    final docId = response.id;

    await _firestore
        .collection(FirebaseConstant.coffeeRecordsCollection)
        .doc(docId)
        .update({'doc_id': docId});

    notifyListeners();
  }

  Stream<List<CoffeeRecordsModel>> getCoffeeRecordsStream() {
    return _firestore
        .collection(FirebaseConstant.coffeeRecordsCollection)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              final record = CoffeeRecordsModel.fromJson(data);
              record.docId = doc.id;
              return record;
            }).toList());
  }
}