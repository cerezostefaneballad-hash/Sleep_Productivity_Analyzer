import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(SleepProductivityApp());
}

class SleepProductivityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sleep & Productivity Analyzer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
          primary: Colors.deepPurple,
          secondary: Colors.teal,
        ),
        fontFamily: 'Inter',
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.deepPurple, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            shadowColor: Colors.deepPurple.withOpacity(0.3),
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
      home: AnalyzerScreen(),
    );
  }
}

class AnalyzerScreen extends StatefulWidget {
  @override
  _AnalyzerScreenState createState() => _AnalyzerScreenState();
}

class _AnalyzerScreenState extends State<AnalyzerScreen> {
  final TextEditingController sleepController = TextEditingController();
  final TextEditingController studyController = TextEditingController();
  final TextEditingController screenController = TextEditingController();

  String result = "";
  String recommendation = "";
  double balanceScore = 0;
  String lifestyleCategory = "";

  // 🔹 HISTORY LIST
  List<String> historyList = [];

  void analyzeData() {
    try {
      double sleepHours = double.parse(sleepController.text);
      double studyHours = double.parse(studyController.text);
      double screenTime = double.parse(screenController.text);

      // Arithmetic operation
      balanceScore = (studyHours * 2 + sleepHours) - screenTime;

      // If-Else Classification
      if (balanceScore >= 15) {
        lifestyleCategory = "Excellent";
      } else if (balanceScore >= 10) {
        lifestyleCategory = "Good";
      } else if (balanceScore >= 5) {
        lifestyleCategory = "Moderate";
      } else {
        lifestyleCategory = "Needs Improvement";
      }

      // Switch for Recommendation
      switch (lifestyleCategory) {
        case "Excellent":
          recommendation = "Outstanding balance! Keep up the great work. 🎯";
          break;
        case "Good":
          recommendation = "Good routine! Consider optimizing sleep quality.";
          break;
        case "Moderate":
          recommendation = "Try reducing screen time by 1-2 hours daily.";
          break;
        case "Needs Improvement":
          recommendation = "Prioritize sleep and monitor screen time closely.";
          break;
        default:
          recommendation = "Invalid category.";
      }

      String record =
          "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')} | Score: ${balanceScore.toStringAsFixed(2)} | $lifestyleCategory";

      setState(() {
        result =
        "Balance Score: ${balanceScore.toStringAsFixed(2)}\nLifestyle: $lifestyleCategory";
        historyList.insert(0, record); // Add to beginning of history
      });

    } catch (e) {
      setState(() {
        result = "Please enter valid numbers in all fields.";
        recommendation = "";
      });
    }
  }

  void clearHistory() {
    setState(() {
      historyList.clear();
    });
  }

  void clearAll() {
    setState(() {
      sleepController.clear();
      studyController.clear();
      screenController.clear();
      result = "";
      recommendation = "";
    });
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Excellent":
        return Colors.green.shade600;
      case "Good":
        return Colors.teal.shade500;
      case "Moderate":
        return Colors.orange.shade600;
      case "Needs Improvement":
        return Colors.red.shade500;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Excellent":
        return Icons.star;
      case "Good":
        return Icons.thumb_up;
      case "Moderate":
        return Icons.warning_amber;
      case "Needs Improvement":
        return Icons.trending_down;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          "Sleep & Productivity",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    Icon(
                      Icons.insights,
                      size: 48,
                      color: Colors.deepPurple,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Daily Lifestyle Analyzer",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Track your sleep, study, and screen time balance",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Input Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        Colors.grey.shade50,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.deepPurple.withOpacity(0.1),
                              child: Icon(
                                Icons.timer,
                                color: Colors.deepPurple,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Enter your daily hours",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        _buildInputField(
                          "Sleep Hours",
                          Icons.bedtime_rounded,
                          sleepController,
                          color: Colors.blue.shade500,
                        ),
                        SizedBox(height: 16),
                        _buildInputField(
                          "Study Hours",
                          Icons.school_rounded,
                          studyController,
                          color: Colors.green.shade500,
                        ),
                        SizedBox(height: 16),
                        _buildInputField(
                          "Screen Time (Hours)",
                          Icons.phone_iphone_rounded,
                          screenController,
                          color: Colors.purple.shade500,
                        ),
                        SizedBox(height: 28),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: analyzeData,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 3,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.analytics, size: 22),
                                    SizedBox(width: 10),
                                    Text(
                                      "Analyze Lifestyle",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: clearAll,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade100,
                                foregroundColor: Colors.grey.shade700,
                                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0,
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                              child: Icon(Icons.refresh, size: 22),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),

              // Results Section
              if (result.isNotEmpty) ...[
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(lifestyleCategory).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    _getCategoryIcon(lifestyleCategory),
                                    color: _getCategoryColor(lifestyleCategory),
                                    size: 28,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  "Analysis Result",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: _getCategoryColor(lifestyleCategory).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                lifestyleCategory,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _getCategoryColor(lifestyleCategory),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(lifestyleCategory).withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _getCategoryColor(lifestyleCategory).withOpacity(0.2),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Score: ${balanceScore.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                height: 6,
                                width: balanceScore.clamp(0, 20) * 10,
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(lifestyleCategory),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                recommendation,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
              ],

              // History Section
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.history_rounded,
                                  color: Colors.deepPurple,
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                "Analysis History",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ],
                          ),
                          if (historyList.isNotEmpty)
                            TextButton(
                              onPressed: clearHistory,
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red.shade600,
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.delete_outline, size: 18),
                                  SizedBox(width: 6),
                                  Text(
                                    "Clear All",
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 20),
                      if (historyList.isEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: Column(
                            children: [
                              Icon(
                                Icons.timeline_outlined,
                                size: 64,
                                color: Colors.grey.shade300,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "No analysis history yet",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Complete your first analysis to see history here",
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      else
                        ...historyList.map((record) {
                          final parts = record.split(' | ');
                          final time = parts[0];
                          final score = parts[1];
                          final category = parts[2];

                          return Container(
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(category).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  _getCategoryIcon(category),
                                  color: _getCategoryColor(category),
                                  size: 22,
                                ),
                              ),
                              title: Text(
                                score,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Text(
                                category,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Time",
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    time,
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              visualDensity: VisualDensity.comfortable,
                            ),
                          );
                        }).toList(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Footer Note
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Colors.deepPurple,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Balance Score = (Study × 2 + Sleep) - Screen Time",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, IconData icon, TextEditingController controller,
      {required Color color}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Container(
          margin: EdgeInsets.only(right: 12, left: 16),
          child: Icon(icon, color: color),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        labelStyle: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}