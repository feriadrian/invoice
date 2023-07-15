class Endpoint {
  static const baseUrl = "https://api.my-invoice.me/api/v1/";
  static const auth = "${baseUrl}auth/";
  static const customer = "${baseUrl}customers/";
  static const invoice = "${baseUrl}invoices/";

  static const register = "${auth}register/customer";
  static const login = "${auth}login/customer";
  static const verification = "${auth}verification/customer";
  static const resetPassword = "${auth}reset/password/request/customer";
  static const getCustomer = "${customer}me";
  static const updateFotoProfileCustomer = "${baseUrl}customers/me/picture";

  static const getInvoiceById = "${baseUrl}invoices/";
  static const getCustomerProfile = "${baseUrl}customers/me";
  static const getSummary = "${baseUrl}customers/summaries";

  static const getNotification =
      "${baseUrl}customers/notifications?page=1&limit=99";
  static const getNotifCount = "${baseUrl}customers/notifications/unread_count";
  static const markAsRead = "${baseUrl}customers/notifications/";

  static const report =
      "${baseUrl}invoices/reports?payment_status=3&date_filter=1%20Week";
}
