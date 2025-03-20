import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController namecontroller = TextEditingController();
  final key = GlobalKey<FormState>();
  List<String> daftarNama = [];

  void addData() {
    setState(() {
      daftarNama.add(namecontroller.text);
    });
  }