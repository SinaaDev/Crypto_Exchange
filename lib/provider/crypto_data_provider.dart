import 'package:crypto_app/CryptoModel/AllCryptoModel.dart';
import 'package:crypto_app/network/api_provider.dart';
import 'package:crypto_app/network/response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class CryptoDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();

  late AllCryptoModel dataFuture;
  late ResponseModel state;

  Response? response;

  CryptoDataProvider(){
    getTopMarketCapData();
  }

  getTopMarketCapData() async {
    state = ResponseModel.loading('Loading...');

    try {
      response = await apiProvider.getTopMarketCapData();

      if (response?.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response?.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error('Something went wrong.');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('No Internet Connection.');
      notifyListeners();
    }
  }

  getTopGainersData() async {
    state = ResponseModel.loading('Loading...');

    try {
      response = await apiProvider.getTopGainerData();

      if (response?.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response?.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error('Something went wrong.');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('No Internet Connection.');
      notifyListeners();
    }
  }

  getTopLosersData() async {
    state = ResponseModel.loading('Loading...');

    try {
      response = await apiProvider.getTopLosersData();

      if (response?.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response?.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error('Something went wrong.');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('No Internet Connection.');
      notifyListeners();
    }
  }

}
