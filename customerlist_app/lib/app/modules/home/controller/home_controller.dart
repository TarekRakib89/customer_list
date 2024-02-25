import 'dart:developer';
import 'package:customerlist_app/app/data/models/customer_model.dart';
import 'package:customerlist_app/app/data/models/response_data.dart';
import 'package:customerlist_app/app/data/services/network_caller.dart';
import 'package:customerlist_app/util/urls.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();

  String _errorMessege = '';
  int page = 0;
  final List<CustomerList> _customer = [];
  int _totalCustomer = 1000;
  int _pageNo = 0;
  bool _loader = false;

  String get errorMessage => _errorMessege;
  List<CustomerList> get customer => _customer;
  int get totalCustomer => _totalCustomer;
  int get pageNo => _pageNo;
  bool get loader => _loader;

  Future<void> getCustomerList() async {
    page += 1;
    _loader = true;
    update();
    try {
      final ResponseData response = await NetworkCaller().getRequestWithToken(
        Urls.readCustomerList(page),
      );

      // size += 1;
      log(page.toString());

      if (response.isSuccess) {
        final List data = response.responseData["CustomerList"];

        final List<CustomerList> newCustomer =
            data.map((c) => CustomerList.fromJson(c)).toList();
        _totalCustomer = response.responseData["PageInfo"]["TotalRecordCount"];
        _pageNo = response.responseData["PageInfo"]["PageNo"];
        _customer.addAll(newCustomer);
        _loader = false;
      } else {
        _errorMessege = response.errorMessage;
      }
      update();
    } catch (e) {
      log(e.toString());
    }
  }
}
