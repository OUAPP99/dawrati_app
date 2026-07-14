import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Tracks whether this device is running as a linked "partner" device —
/// entered via someone else's partner code, with no account of its own.
/// This is device-local state (SharedPreferences), not account state.
class PartnerModeProvider extends ChangeNotifier {
  bool isPartnerMode = false;
  String? linkedCode;
  String? ownerUid;

  PartnerModeProvider() {
    load();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    linkedCode = prefs.getString('partner_linked_code');
    ownerUid = prefs.getString('partner_owner_uid');
    isPartnerMode = linkedCode != null && ownerUid != null;
    notifyListeners();
  }

  Future<void> connect(String code, String ownerUid) async {
    linkedCode = code;
    this.ownerUid = ownerUid;
    isPartnerMode = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('partner_linked_code', code);
    await prefs.setString('partner_owner_uid', ownerUid);
  }

  Future<void> disconnect() async {
    linkedCode = null;
    ownerUid = null;
    isPartnerMode = false;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('partner_linked_code');
    await prefs.remove('partner_owner_uid');
  }
}
