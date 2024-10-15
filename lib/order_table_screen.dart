import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Tour {
  // Tour sınıfınızın özellikleri
  // Örnek:
  final String carType;
  final String guestName;
  // ... diğer özellikler

  Tour({
    required this.carType,
    required this.guestName,
    // ... diğer özellikler
  });

  factory Tour.fromMap(Map<String, dynamic> map) {
    return Tour(
      carType: map['carType'] ?? '',
      guestName: map['guestName'] ?? '',
      // ... diğer özelliklerin map'ten alınması
    );
  }
}

class OrderTableScreen extends StatefulWidget {
  @override
  _OrderTableScreenState createState() => _OrderTableScreenState();
}

class _OrderTableScreenState extends State<OrderTableScreen> {
  List<Tour> tours = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Sifarish Detallari')
          .orderBy('orderDate', descending: true) // En son siparişler önce
          .get();

      tours = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // orderDate'i DateTime'a çeviriyoruz
        DateTime orderDate = (data['orderDate'] as Timestamp).toDate();

        return Tour.fromMap({
          ...data,
          'id': doc.id,
          'orderDate': orderDate,
        });
      }).toList();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("XETA BASH VERDI - 1: $e");
      setState(() {
        isLoading = false;
        // Hata durumunda kullanıcıya göstermek için bir hata mesajı ayarlayabilirsiniz
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Siparişler'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('carType')),
                    DataColumn(label: Text('guestName')),
                    // ... diğer sütunlar
                  ],
                  rows: tours
                      .map((tour) => DataRow(
                            cells: [
                              DataCell(Text(tour.carType)),
                              DataCell(Text(tour.guestName)),
                              // ... diğer hücreler
                            ],
                          ))
                      .toList(),
                ),
              ),
            ),
    );
  }
}
