# pkg-merger
A Termux script for Android to easily merge split .pkg files into a single file. Features auto-detection in Downloads, a simple CLI menu, and an option to delete split parts after merging to save space.

[ English ] | [ Português ]
English
A lightweight Bash script designed for Termux on Android. It allows you to quickly concatenate split .pkg files (e.g., Piece 0, Piece 1) into a single output file directly on your mobile device.
Features
 * Termux Native: Runs directly on Android without requiring root access.
 * Auto Detection: Scans your /sdcard/Download folder for .pkg files automatically.
 * Simple CLI Menu: Interactive numbered selection for easy file pairing.
 * Auto Cleanup: Prompts to delete the original split parts after merging to save storage space.
Quick Start
Open Termux and run:
pkg install git -y && git clone https://github.com/TEU_USUARIO/pkg-merger.git && bash pkg-merger/juntar.sh

(Replace TEU_USUARIO with your GitHub username)
Requirements
 * Termux installed on your Android device.
 * Sufficient free storage space (at least double the combined size of the files during the merge process).
Português
Um script Bash leve desenvolvido para o Termux no Android. Permite unificar rapidamente ficheiros .pkg divididos (ex: Piece 0, Piece 1) num único ficheiro final diretamente no telemóvel.
Funcionalidades
 * Nativo para Termux: Executa diretamente no Android sem necessidade de acesso root.
 * Deteção Automática: Procura ficheiros .pkg na pasta /sdcard/Download automaticamente.
 * Menu Interativo Simples: Seleção por números para facilitar a junção dos ficheiros.
 * Limpeza Automática: Opção para apagar as partes originais após a fusão para poupar espaço.
Como Executar
Abre o Termux e digita:
pkg install git -y && git clone https://github.com/TEU_USUARIO/pkg-merger.git && bash pkg-merger/juntar.sh

(Substitui TEU_USUARIO pelo teu nome de utilizador do GitHub)
Requisitos
 * Termux instalado no dispositivo Android.
 * Espaço livre suficiente no armazenamento (pelo menos o dobro do tamanho total dos ficheiros durante o processo de junção).
License / Licença
Distributed under the MIT License. / Distribuído sob a Licença MIT.
