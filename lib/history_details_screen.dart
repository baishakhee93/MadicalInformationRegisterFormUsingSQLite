import 'package:flutter/material.dart';

import 'database/madical_infomation_database_helper.dart';
import 'model/madical_info_model.dart';

class HistoryPage extends StatefulWidget {


  @override
  State<HistoryPage> createState() => _HistoryPageState();
}


class _HistoryPageState extends State<HistoryPage> {
  final _databaseHelper = MadicalInformationDatabaseHelper.instance;

  List<MadicalInfoModel> madicalInfoList = [];

  void _queryAll() async {
    final allRows = await _databaseHelper.queryAllRows();
    madicalInfoList.clear();
    allRows?.forEach((row) => madicalInfoList.add(MadicalInfoModel.fromMap(row)));
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _queryAll();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,

        title: Text("History "),


      ),
      body: Container(
        child:SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            onSelectAll: (b) {},
            sortColumnIndex: 0,
            sortAscending: true,
            columns: <DataColumn>[
              DataColumn(label: Text("Requested Date"), tooltip: "To Display Date"),
              DataColumn(label: Text("Name"), tooltip: "To Display name"),
              DataColumn(label: Text("Contact Number"), tooltip: "To Display Contact Number"),
              DataColumn(label: Text("Update"), tooltip: "Update data"),
              DataColumn(label: Text("Delete"), tooltip: "Delete data"),
              DataColumn(label: Text("View Details"), tooltip: "View Details"),
            ],

            rows: madicalInfoList
                .map(
                  (data) => DataRow(
                cells: [
                  DataCell(
                    Text("${data.reqDate}"),
                  ),DataCell(
                    Text("${data.firstName}  ${data.lastName}"),
                  ),
                  DataCell(
                    Text("${data.telePhoneNumber}"),
                  ),
                  DataCell(
                    IconButton(
                      onPressed: () {

                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DataCell(
                    IconButton(
                      onPressed: () {

                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                    ),
                  ), DataCell(
                    ElevatedButton(
                      onPressed: () {

                      },
                      child: Text("View"),
                    ),
                  ),
                ],
              ),
            )
                .toList(),
          )



      ),
      )

    );
  }

}