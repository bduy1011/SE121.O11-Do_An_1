import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'bloc.dart';

class SelectSymptomListBloc
    extends Bloc<SelectSymptomListEvent, SelectSymptomListState> {
  static const String baseUrl = 'http://172.16.2.134:5000';

  SelectSymptomListBloc() : super(SelectSymptomListInitial()) {
    on<FetchSymptoms>(_onFetchSymptoms);
    on<SubmitSymptoms>(_onSubmitSymptoms);
  }

  void _onFetchSymptoms(
      FetchSymptoms event, Emitter<SelectSymptomListState> emit) async {
    emit(SelectSymptomListLoading());
    try {
      final symptoms = await getSymptoms();
      emit(SelectSymptomListLoaded(symptoms));
    } catch (_) {
      emit(SelectSymptomListError());
    }
  }

  void _onSubmitSymptoms(
      SubmitSymptoms event, Emitter<SelectSymptomListState> emit) async {
    emit(SelectSymptomListLoading());
    try {
      final diagnosis = await diagnoseSymptoms(event.symptoms);
      emit(SelectSymptomListDiagnosed(diagnosis));
    } catch (_) {
      emit(SelectSymptomListError());
    }
  }

  Future<Map<String, List<String>>> getSymptoms() async {
    final response = await http.get(Uri.parse('$baseUrl/get_symptoms'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<String> symptomsVi = List<String>.from(data['symptoms_Vi']);
      List<String> symptomsEn = List<String>.from(data['symptoms_En']);
      return {'symptoms_Vi': symptomsVi, 'symptoms_En': symptomsEn};
    } else {
      throw Exception('Failed to load symptoms');
    }
  }

  Future<String> diagnoseSymptoms(List<String> symptoms) async {
    final response = await http.post(
      Uri.parse('$baseUrl/predict_2'),
      body: jsonEncode({'symptoms': symptoms}),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to diagnose symptoms');
    }
  }
}