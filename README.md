📦 PKG Merger

🇧🇷 Português · 🇺🇸 English

---

🇧🇷 Português

Um script Bash simples e eficiente, desenvolvido para Termux no Android, que permite unificar arquivos ".pkg" divididos — como "Piece 0", "Piece 1", etc. — em um único arquivo final diretamente pelo celular.

✨ Recursos

- 📱 Nativo para Termux — Executa diretamente no Android, sem necessidade de root.
- 🔍 Detecção automática — Localiza arquivos ".pkg" divididos na pasta "/sdcard/Download".
- 🌐 Menu de idiomas — Interface disponível em Português e Inglês.
- 🧹 Limpeza de armazenamento — Opção para excluir as partes originais após a fusão.
- ⚡ Simples e direto — Sem necessidade de computador para realizar o processo.

🚀 Como executar

Abra o Termux e execute:
```bash
pkg install git -y && git clone https://github.com/luankayllon/pkg-merger.git && bash pkg-merger/merger.sh
```
«💡 Dica: O GitHub disponibiliza um botão de copiar no canto do bloco de código acima.»

📋 Requisitos

- 📱 Termux instalado no dispositivo Android.
- 💾 Espaço livre suficiente no armazenamento.
- 📦 Recomenda-se ter pelo menos o dobro do tamanho total dos arquivos disponíveis durante o processo de fusão.
- 🔓 Root não é necessário.

📁 Local dos arquivos

Por padrão, o script procura os arquivos ".pkg" em:

/sdcard/Download

---

🇺🇸 English

A simple and efficient Bash script designed for Termux on Android. It allows you to concatenate split ".pkg" files — such as "Piece 0", "Piece 1", etc. — into a single output file directly on your mobile device.

✨ Features

- 📱 Termux Native — Runs directly on Android without requiring root access.
- 🔍 Automatic Detection — Automatically scans "/sdcard/Download" for split ".pkg" files.
- 🌐 Multilingual Interface — Built-in support for English and Portuguese.
- 🧹 Storage Cleanup — Option to delete the original split parts after merging.
- ⚡ Simple and Lightweight — No computer required.

🚀 Quick Start

Open Termux and run:
```bash
pkg install git -y && git clone https://github.com/luankayllon/pkg-merger.git && bash pkg-merger/merger.sh
```
📋 Requirements

- 📱 Termux installed on your Android device.
- 💾 Sufficient free storage space.
- 📦 At least twice the combined size of the files is recommended during the merging process.
- 🔓 Root access is not required.

📁 File Location

By default, the script searches for ".pkg" files in:

/sdcard/Download

---

📄 License / Licença

Distributed under the MIT License.

Distribuído sob a Licença MIT.
