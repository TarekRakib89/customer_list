class Urls {
  static const String _baseUrl = 'https://www.pqstec.com/InvoiceApps/Values';

  static String sentEmailOtp(String email, String password) =>
      '$_baseUrl/LogIn?UserName=$email&Password=$password&ComId=1';

  static String readCustomerList(int page) =>
      '$_baseUrl/GetCustomerList?searchquery&pageNo=$page&pageSize=10&SortyBy=Balance';
}
