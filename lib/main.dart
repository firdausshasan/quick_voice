import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickVoice',
      theme: ThemeData(primarySwatch: Colors.brown),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const RecordPage(),
    const NotesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF272727),
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFEFD09E),
        unselectedItemColor: Color.fromARGB(255, 214, 203, 184),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Record'),
          BottomNavigationBarItem(icon: Icon(Icons.notes), label: 'Notes'),
        ],
      ),
    );
  }
}

// =========================== RECORD PAGE ============================

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});
  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _recognizedText = '';
  String _selectedLocaleId = 'en_US'; // Default
  List<stt.LocaleName> _localeNames = [];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    await _speech.initialize();
    _localeNames = await _speech.locales();

    // Set default locale to system
    var systemLocale = await _speech.systemLocale();
    setState(() {
      _selectedLocaleId = systemLocale?.localeId ?? 'en_US';

    });
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🎙️ Listening...'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.black87,
        ),
      );

      _speech.listen(
        localeId: _selectedLocaleId,
        onResult: (result) {
          setState(() {
            _recognizedText = result.recognizedWords;
          });
        },
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🛑 Stopped listening.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  void _saveNote(BuildContext context) async {
    if (_recognizedText.trim().isEmpty) return;

    final TextEditingController _titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Enter Note Title"),
        content: TextField(
          controller: _titleController,
          decoration: const InputDecoration(hintText: "Note Title"),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              String title = _titleController.text.trim();
              if (title.isNotEmpty) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                List<String> existing = prefs.getStringList('notes') ?? [];
                existing.add('$title::$_recognizedText');
                await prefs.setStringList('notes', existing);
                setState(() {
                  _recognizedText = '';
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272727),
        centerTitle: true,
        title: const Text(
          'QuickVoice',
          style: TextStyle(
            color: Color(0xFFEFD09E),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFD4AA7D),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedLocaleId,
              icon: const Icon(Icons.arrow_drop_down),
              isExpanded: true,
              items: _localeNames.map((locale) {
                return DropdownMenuItem<String>(
                  value: locale.localeId,
                  child: Text(locale.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLocaleId = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF272727),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _recognizedText.isEmpty
                      ? "Press the mic and speak"
                      : _recognizedText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: _isListening ? _stopListening : _startListening,
                  backgroundColor: const Color(0xFF272727),
                  child: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: const Color(0xFFEFD09E),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed:
                      _recognizedText.isNotEmpty ? () => _saveNote(context) : null,
                  icon: const Icon(Icons.save),
                  label: const Text("Save"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF272727),
                    foregroundColor: const Color(0xFFEFD09E),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// =========================== NOTES PAGE ============================

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<String> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notes = prefs.getStringList('notes') ?? [];
    });
  }

  Future<void> _deleteNote(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _notes.removeAt(index);
    await prefs.setStringList('notes', _notes);
    setState(() {});
  }

  Future<void> _editNote(int index) async {
    final parts = _notes[index].split("::");
    final TextEditingController titleController =
        TextEditingController(text: parts[0]);
    final TextEditingController contentController =
        TextEditingController(text: parts.length > 1 ? parts[1] : "");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Note"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: "Content"),
                maxLines: null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final newTitle = titleController.text.trim();
              final newContent = contentController.text.trim();
              if (newTitle.isNotEmpty) {
                _notes[index] = "$newTitle::$newContent";
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setStringList('notes', _notes);
                setState(() {});
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF272727),
        centerTitle: true,
        title: const Text(
          'Saved Notes',
          style: TextStyle(
            color: Color(0xFFEFD09E),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFD4AA7D),
        padding: const EdgeInsets.all(8),
        child: _notes.isEmpty
            ? const Center(child: Text("No notes saved yet."))
            : ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  final parts = _notes[index].split("::");
                  final title = parts[0];
                  final content = parts.length > 1 ? parts[1] : "";
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(content),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _editNote(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteNote(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
