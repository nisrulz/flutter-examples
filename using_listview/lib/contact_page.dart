import 'package:flutter/material.dart';
import 'package:using_listview/contactlist/contact_list.dart';
import 'package:using_listview/contactlist/modal/contact.dart';

class ContactPage extends StatelessWidget {
  _buildContactList() {
    return <ContactModal>[
      const ContactModal(
          fullName: 'Romain Hoogmoed', email: 'romain.hoogmoed@example.com'),
      const ContactModal(
          fullName: 'Emilie Olsen', email: 'emilie.olsen@example.com'),
      const ContactModal(
          fullName: 'Nishant Srivastava', email: 'nishant.srivastava@example.com'),
      const ContactModal(
          fullName: 'Romain Hoogmoed', email: 'romain.hoogmoed@example.com'),
      const ContactModal(
          fullName: 'Emilie Olsen', email: 'emilie.olsen@example.com'),
      const ContactModal(
          fullName: 'Nishant Srivastava', email: 'nishant.srivastava@example.com'),
      const ContactModal(
          fullName: 'Romain Hoogmoed', email: 'romain.hoogmoed@example.com'),
      const ContactModal(
          fullName: 'Emilie Olsen', email: 'emilie.olsen@example.com'),
      const ContactModal(
          fullName: 'Nishant Srivastava', email: 'nishant.srivastava@example.com'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ContactsList(_buildContactList()));
  }
}
