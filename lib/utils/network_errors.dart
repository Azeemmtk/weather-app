import 'dart:convert';

error(dynamic res) {
  switch (res.statusCode) {
    case 404:
      throw Exception(jsonDecode(res.body)['message']);
    case 500:
      throw Exception('internel erroe');

    default:
      throw Exception('Something went wrong');
  }
}
