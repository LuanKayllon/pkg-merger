🇧🇷 **Português**
Um script em Bash simples e eficiente desenvolvido para o Termux no Android. Permite unificar ficheiros .pkg divididos (como Piece 0 e Piece 1) num único ficheiro final diretamente no telemóvel.
**Recurso**
 * Nativo para Termux: Executa diretamente no Android sem necessidade de acesso root.
 * Deteção Automática: Localiza ficheiros .pkg na pasta /sdcard/Download.
 * Menu de Idiomas: Suporte integrado para Português e Inglês.
 * Limpeza de Armazenamento: Opção para apagar as partes originais após a fusão.
**Como Executar**
Abre o Termux e executa o comando:
pkg install git -y && git clone https://github.com/luankayllon/pkg-merger.git && bash pkg-merger/merger.sh

**Requisitos**
 * Termux instalado no dispositivo Android.
 * Espaço livre suficiente no armazenamento (pelo menos o dobro do tamanho total dos ficheiros durante o processo).

🇺🇸 **English**
A simple and efficient Bash script designed for Termux on Android. It allows you to concatenate split .pkg files (such as Piece 0 and Piece 1) into a single output file directly on your mobile device.
**Features**
 * Termux Native: Runs directly on Android without requiring root access.
 * Auto Detection: Scans your /sdcard/Download folder for .pkg files.
 * Multilingual UI: Built-in language selector for English and Portuguese.
 * Storage Cleanup: Option to delete the original split parts after merging.
**Quick Start**
Open Termux and run:
pkg install git -y && git clone https://github.com/luankayllon/pkg-merger.git && bash pkg-merger/merger.sh

**Requirements**
 * Termux installed on your Android device.
 * Sufficient free storage space (at least double the combined size of the files during the process).

_Licença / License
Distributed under the MIT License. / Distribuído sob a Licença MIT._
