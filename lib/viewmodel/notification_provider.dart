import 'package:flutter/material.dart';
import 'package:myinvoice/models/invoice_detail/invoice_detail_model.dart';
import 'package:myinvoice/models/notification/notification_model.dart';
import 'package:myinvoice/models/notification/unread_count.dart';
import 'package:myinvoice/services/invoice_service.dart';
import 'package:myinvoice/services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationData? _notification;

  NotificationData? get notification => _notification;

  getAllNotification() async {
    final response = await NotificationServices().fetchAllNotification();
    _notification = response;
    notifyListeners();
  }

  UnreadNotifCount? _unreadCount;

  UnreadNotifCount? get unreadCount => _unreadCount;

  getUnreadCount() async {
    final response = await NotificationServices().fetchNotifCount();
    _unreadCount = response;
    notifyListeners();
  }

  markAsRead(int id) async {
    final response = await NotificationServices().markAsRead(id);
    _notification = response;
    notifyListeners();
  }

  InvoiceDetail? _invoiceDetail;

  InvoiceDetail? get invoiceDetail => _invoiceDetail;

  getInvById(int id) async {
    final response = await InvoiceServices().getInvoiceById(id);
    _invoiceDetail = response;
    notifyListeners();
  }
}
