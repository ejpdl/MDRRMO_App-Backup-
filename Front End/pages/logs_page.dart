import 'package:flutter/material.dart';

import '../widgets/styles.dart';
import '../widgets/custom_DropDown.dart';
import '../widgets/custom_SearchBar.dart';
import '../widgets/custom_LogsReports.dart';

import '../services/auth_services.dart';

import '../models/CustomInfo.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({ Key? key }) : super(key: key);

  @override
  _LogsPageState createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {

  String? selectedSort;
  String? searchQuery;

  final List<String> sortOptions = ['Accepted', 'Resolved', 'Pending', 'Denied', 'Date Oldest First', 'Date Newest First', 'Time Oldest First', 'Time Newest First'];

  late Future<List<ReportLogs>> reportsFuture;

  @override
  void initState() {
    super.initState();
    reportsFuture = AuthService.getReports();
  }

  
  @override
Widget build(BuildContext context) {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text("Emergency Logs", style: AppTextStyles.welcomeTitle),

          AppHeight(10.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 150,
                child: CustomDropDown(
                  label: "",
                  options: sortOptions,
                  value: selectedSort,
                  onChanged: (value) {

                    setState(() {
                      selectedSort = value;
                      reportsFuture = AuthService.getReports(sort: selectedSort);
                    });

                  },
                ),
              ),
              AppWidth(10.0),
              Expanded(
                child: CustomSearchBar(
                  hintText: "Search...",
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                      reportsFuture = AuthService.getReports(
                        sort: selectedSort,
                        search: searchQuery,
                      );
                    });
                  },
                ),
              ),
            ],
          ),
          AppHeight(20.0),

          CustomTableRow(
            location: "Location",
            date: "Date",
            time: "Time",
            status: "Status",
            isHeader: true,
            textStyle: AppTextStyles.logsText.copyWith(fontWeight: FontWeight.bold),
          ),
          AppHeight(10.0),

          
          Expanded(
            child: FutureBuilder<List<ReportLogs>>(
              future: reportsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No reports found"));
                } else {
                  final reports = snapshot.data!;
                  return ListView.builder(
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      final report = reports[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomTableRow(
                          location: report.location,
                          date: report.date,
                          time: report.time,
                          status: report.status,
                          textStyle: AppTextStyles.logsText,
                        ),
                      );
                    },
                    
                  );
                }
              },
            ),
          ),
        ],
      ),
    ),
  );
}

}