import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                  child: Text(
                'Основные',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
              Tab(
                  child: Text(
                'Оборудование',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
            ],
          ), // TabBar
          title: const Text(
            'Настройки',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 97, 97, 97),
        ), // AppBar
        body: const TabBarView(
          children: [
            GeneralTab(),
            Icon(Icons.music_video),
          ],
        ), // TabBarView
      ), // Scaffold
    );
  }
}

class GeneralTab extends StatefulWidget {
  const GeneralTab({super.key});

  @override
  State<GeneralTab> createState() => _GeneralTabState();
}

class _GeneralTabState extends State<GeneralTab> {
  TextEditingController textController = TextEditingController();

  String _serverAdres = "";

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void getAdresServer() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey('SERVER_ADRESS')) {
      textController.text = _prefs.getString('SERVER_ADRESS') ?? '';
    }
  }

  void setAdresServer() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //if (!_prefs.containsKey('SERVER_ADRESS')) {
    _prefs.setString('SERVER_ADRESS', textController.text);
    //}
  }

  @override
  void initState() {
    super.initState();
    getAdresServer();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle styleCaption = TextStyle(fontSize: 18);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const Text(
                'Адрес сервера',
                style: styleCaption,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: textController,
                  keyboardType: TextInputType.url,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Введите адрес сервера',
                  ),
                  onChanged: (text) {},
                  onEditingComplete: () {
                    setAdresServer();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
