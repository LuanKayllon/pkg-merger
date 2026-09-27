#!/bin/bash

# Cores para a interface
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

clear
echo -e "${CYAN}=======================================${NC}"
echo -e "${GREEN}          PKG MERGER (TERMUX)          ${NC}"
echo -e "${CYAN}=======================================${NC}\n"

echo -e "Select Language / Seleciona o Idioma:"
echo -e "  [1] English"
echo -e "  [2] Português"
echo ""
read -p "Option / Opção (1/2): " lang_choice

if [ "$lang_choice" == "2" ]; then
    LANG_TITLE="JUNÇÃO AUTOMÁTICA DE PKG"
    LANG_STORAGE_REQ="[!] A pedir permissão de armazenamento..."
    LANG_ERR_DOWNLOAD="[X] Não foi possível aceder à pasta Download."
    LANG_SEARCHING="[+] A procurar ficheiros .pkg na pasta Download..."
    LANG_NO_FILES="[X] Nenhum ficheiro .pkg encontrado em /sdcard/Download."
    LANG_NO_FILES_HINT="Certifica-te de que descarregaste as partes para a pasta Download."
    LANG_FILES_FOUND="Ficheiros encontrados:"
    LANG_PROMPT_PART0="Digita o número do PRIMEIRO ficheiro (Parte 0): "
    LANG_PROMPT_PART1="Digita o número do SEGUNDO ficheiro (Parte 1): "
    LANG_PROMPT_OUTPUT="Digita o nome do ficheiro FINAL (ex: Jogo.pkg): "
    LANG_ERR_SELECTION="[X] Seleção inválida. Operação cancelada."
    LANG_MERGING="[*] A juntar ficheiros..."
    LANG_WAIT="[*] Aguarda um momento, isto pode demorar alguns minutos..."
    LANG_SUCCESS="[✓] Ficheiro unificado com sucesso!"
    LANG_SAVED_IN="[✓] Guardado em:"
    LANG_PROMPT_DELETE="Desejas apagar as duas partes originais para poupar espaço? (s/n): "
    LANG_DELETED="[✓] Ficheiros originais removidos."
    LANG_ERR_MERGE="[X] Ocorreu um erro ao juntar os ficheiros."
    AFFIRMATIVE_REGEX="^[Ss]$"
else
    LANG_TITLE="AUTOMATIC PKG MERGER"
    LANG_STORAGE_REQ="[!] Requesting storage permission..."
    LANG_ERR_DOWNLOAD="[X] Could not access the Download folder."
    LANG_SEARCHING="[+] Searching for .pkg files in Download folder..."
    LANG_NO_FILES="[X] No .pkg files found in /sdcard/Download."
    LANG_NO_FILES_HINT="Make sure you downloaded the parts into the Download folder."
    LANG_FILES_FOUND="Files found:"
    LANG_PROMPT_PART0="Enter the number for the FIRST file (Part 0): "
    LANG_PROMPT_PART1="Enter the number for the SECOND file (Part 1): "
    LANG_PROMPT_OUTPUT="Enter the FINAL file name (e.g., Game.pkg): "
    LANG_ERR_SELECTION="[X] Invalid selection. Operation canceled."
    LANG_MERGING="[*] Merging files..."
    LANG_WAIT="[*] Please wait, this may take a few minutes..."
    LANG_SUCCESS="[✓] File merged successfully!"
    LANG_SAVED_IN="[✓] Saved in:"
    LANG_PROMPT_DELETE="Do you want to delete the original split parts to save space? (y/n): "
    LANG_DELETED="[✓] Original files removed."
    LANG_ERR_MERGE="[X] An error occurred while merging the files."
    AFFIRMATIVE_REGEX="^[Yy]$"
fi

clear
echo -e "${CYAN}=======================================${NC}"
echo -e "${GREEN}   $LANG_TITLE   ${NC}"
echo -e "${CYAN}=======================================${NC}\n"

# 1. Permissão de Armazenamento
if [ ! -d "/sdcard/Download" ]; then
    echo -e "${YELLOW}$LANG_STORAGE_REQ${NC}"
    termux-setup-storage
    sleep 2
fi

# Navegar para Download
cd /sdcard/Download || { echo -e "${RED}$LANG_ERR_DOWNLOAD${NC}"; exit 1; }

echo -e "${GREEN}$LANG_SEARCHING${NC}\n"

# Listar ficheiros .pkg
files=(*.pkg)

if [ ! -e "${files[0]}" ]; then
    echo -e "${RED}$LANG_NO_FILES${NC}"
    echo -e "${YELLOW}$LANG_NO_FILES_HINT${NC}"
    exit 1
fi

echo -e "$LANG_FILES_FOUND"
for i in "${!files[@]}"; do
    echo -e "  [${YELLOW}$i${NC}] ${files[$i]}"
done

echo -e "\n${CYAN}---------------------------------------${NC}"
read -p "$LANG_PROMPT_PART0" index0
read -p "$LANG_PROMPT_PART1" index1
read -p "$LANG_PROMPT_OUTPUT" output_name

file0="${files[$index0]}"
file1="${files[$index1]}"

if [ -z "$file0" ] || [ -z "$file1" ] || [ -z "$output_name" ]; then
    echo -e "${RED}$LANG_ERR_SELECTION${NC}"
    exit 1
fi

echo -e "\n${YELLOW}$LANG_MERGING${NC}"
echo -e "${YELLOW}$LANG_WAIT${NC}\n"

# Fusão dos ficheiros
cat "$file0" "$file1" > "$output_name"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}$LANG_SUCCESS${NC}"
    echo -e "${GREEN}$LANG_SAVED_IN /sdcard/Download/$output_name${NC}\n"
    
    read -p "$LANG_PROMPT_DELETE" confirm
    if [[ "$confirm" =~ $AFFIRMATIVE_REGEX ]]; then
        rm "$file0" "$file1"
        echo -e "${GREEN}$LANG_DELETED${NC}"
    fi
else
    echo -e "${RED}$LANG_ERR_MERGE${NC}"
fi

echo -e "\n${CYAN}=======================================${NC}"
