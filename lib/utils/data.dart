import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DataProvider{

  List<DropdownMenuItem<String>> countries = [];
  final Map<String, Map<String, dynamic>> data = {};

  Future setData() async{
    List<String> jsonCountries = [];
    Map<String, Map<String, dynamic>> jsonData = {};
    final String response = await rootBundle.loadString('assets/LifeExpectancy.json');
    final Map<String, dynamic> jsonDoc = await json.decode(response);
    jsonDoc.forEach((key, value) {
      jsonCountries.add(key);
      jsonData.addEntries([MapEntry(key, value)]);
    });

    countries = jsonCountries.map((val) {
      return DropdownMenuItem<String>(
        value: val,
        child: Text(val),
      );
    }).toList();
    data.addAll(jsonData);
  }

  double getExpectancy(String country, String gender){
    return data[country]![gender];
  }

  double yearsToWeeks(double years){
    return years * 52.1429;
  }
}