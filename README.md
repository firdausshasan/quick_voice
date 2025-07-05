<p align="center">
  <img src="https://raw.githubusercontent.com/firdausshasan/quick_voice/refs/heads/main/assets/image/quicknote_logo.png" width="550" alt="QuickVoice Icon">
</p>

# 🎙️ QuickVoice – Voice-Based Note Taking App

**QuickVoice** is a Flutter-based mobile application that allows users to transcribe their voice into text notes in real time. Designed with simplicity and productivity in mind, the app lets you capture ideas, to-dos, or any spoken information by simply speaking into the microphone. These notes can be saved, edited, deleted, and persistently stored using local storage.

---

## ✨ Key Features

- 🎤 **Voice Recognition:** Converts speech to text using the powerful [`speech_to_text`](https://pub.dev/packages/speech_to_text) plugin.
- 📝 **Note Management:** Save transcribed text as notes, complete with a custom title.
- ✏️ **Edit Notes:** Update the title or content of any saved note.
- 🗑️ **Delete Notes:** Remove notes easily from the saved list.
- 💾 **Persistent Storage:** Notes are stored locally using `shared_preferences`, so your data is saved even after closing the app.
- 🌐 **Language Selection:** Choose your preferred language for speech recognition.
- 🚀 **Offline Capable:** All features work without an internet connection.

---

## 🌐 Supported Languages

QuickVoice supports a wide range of languages and locales for voice input:

<details>
<summary>Click to expand the full list</summary>

- 🇨🇳 Chinese (Simplified Han, China)  
- 🇹🇼 Chinese (Traditional Han, Taiwan)  
- 🇦🇺 English (Australia)  
- 🇨🇦 English (Canada)  
- 🇮🇳 English (India)  
- 🇮🇪 English (Ireland)  
- 🇲🇾 English (Malaysia)  
- 🇸🇬 English (Singapore)  
- 🇬🇧 English (UK)  
- 🇺🇸 English (US)  
- 🇧🇪 French (Belgium)  
- 🇨🇦 French (Canada)  
- 🇫🇷 French (France)  
- 🇨🇭 French (Switzerland)  
- 🇦🇹 German (Austria)  
- 🇧🇪 German (Belgium)  
- 🇩🇪 German (Germany)  
- 🇨🇭 German (Switzerland)  
- 🇮🇳 Hindi (India)  
- 🇮🇩 Indonesian (Indonesia)  
- 🇮🇹 Italian (Italy)  
- 🇨🇭 Italian (Switzerland)  
- 🇯🇵 Japanese (Japan)  
- 🇰🇷 Korean (South Korea)  
- 🇵🇱 Polish (Poland)  
- 🇧🇷 Portuguese (Brazil)  
- 🇷🇺 Russian (Russia)  
- 🇪🇸 Spanish (Spain)  
- 🇺🇸 Spanish (US)  
- 🇹🇭 Thai (Thailand)  
- 🇹🇷 Turkish (Türkiye)  
- 🇻🇳 Vietnamese (Vietnam)  

</details>

---

## ✨ Speech-to-Text Punctuation

The `speech_to_text` plugin supports **automatic punctuation** by interpreting certain spoken commands into punctuation marks (depending on language model and OS). Below are commonly supported spoken punctuations:

| Say this              | Resulting Text Output   |
|-----------------------|--------------------------|
| "comma"               | ,                        |
| "full stop"           | .                        |
| "question mark"       | ?                        |
| "exclamation point"   | !                        |
| "colon"               | :                        |
| "semicolon"           | ;                        |
| "dash"                | -                        |
| "ellipsis"            | ...                      |
| "open parenthesis"    | (                        |
| "close parenthesis"   | )                        |

---

## 🚀 Getting Started

### 🛠 Installation

1. **Clone the repository:**
```bash
git clone https://github.com/firdausshasan/quick_voice.git
cd quick_voice
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Run the app:**
```bash
flutter run
```
---

## 📦 Dependencies

| Package | Description |
|--------|-------------|
| [`speech_to_text`](https://pub.dev/packages/speech_to_text) | Speech recognition plugin |
| [`shared_preferences`](https://pub.dev/packages/shared_preferences) | Local note storage |
| [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons) | Customize app icon |

---

## 💡 How It Works

- Uses `speech_to_text` to recognize spoken words.
- Converts recognized text and allows user to assign a title.
- Stores notes locally using `shared_preferences`.
- Navigates between **Record** and **Notes** pages via `BottomNavigationBar`.
- Supports editing and deleting individual notes.

---

## 📱 Screenshots

### 🎙️ Record Page

<p align="center">
  <img src="https://raw.githubusercontent.com/firdausshasan/quick_voice/refs/heads/main/assets/image/record_page.png" width="700" alt="PetalVision Icon">
</p>


### 📒 Notes Page

<p align="center">
  <img src="https://raw.githubusercontent.com/firdausshasan/quick_voice/refs/heads/main/assets/image/notes_page.png" width="700" alt="PetalVision Icon">
</p>

## 🎯 Target Audience

This app is perfect for:

- 🧑‍🎓 **Students** – for capturing quick lecture notes or ideas  
- ✍️ Writers & Creatives – for dictating ideas on the go  
- 🧑‍💼 Busy Professionals – for quick task recording and memos  
- 🧓 Elderly Users – for easy note-taking without typing  
