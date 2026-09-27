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
    LANG_FILES_FOUND="Ficheiros .pkg encontrados:"
    LANG_PROMPT_PATTERN="Digita o padrão em comum dos ficheiros a juntar (ex: Piece, Jogo, ou * para TODOS): "
    LANG_PROMPT_OUTPUT="Digita o nome do ficheiro FINAL (ex: JogoCompleto.pkg): "
    LANG_NO_MATCH="[X] Nenhum ficheiro corresponde ao padrão indicado."
    LANG_PARTS_LIST="As seguintes partes serão unidas nesta ordem:"
    LANG_MERGING="[*] A juntar ficheiros..."
    LANG_WAIT="[*] Aguarda um momento, isto pode demorar alguns minutos..."
    LANG_SUCCESS="[✓] Ficheiros unificados com sucesso!"
    LANG_SAVED_IN="[✓] Guardado em:"
    LANG_PROMPT_DELETE="Desejas apagar os ficheiros originais para poupar espaço? (s/n): "
    LANG_DELETED="[✓] Ficheiros originais removidos."
    LANG_ERR_MERGE="[X] Ocorreu um erro ao juntar os ficheiros."
    AFFIRMATIVE_REGEX="^[Ss]$"
else
    LANG_TITLE="AUTOMATIC PKG MERGER"
    LANG_STORAGE_REQ="[!] Requesting storage permission..."
    LANG_ERR_DOWNLOAD="[X] Could not access the Download folder."
    LANG_SEARCHING="[+] Searching for .pkg files in Download folder..."
    LANG_NO_FILES="[X] No .pkg files found in /sdcard/Download."
    LANG_FILES_FOUND="Found .pkg files:"
    LANG_PROMPT_PATTERN="Enter the common pattern of the files to merge (e.g., Piece, Game, or * for ALL): "
    LANG_PROMPT_OUTPUT="Enter the FINAL file name (e.g., CompleteGame.pkg): "
    LANG_NO_MATCH="[X] No files match the given pattern."
    LANG_PARTS_LIST="The following parts will be merged in this order:"
    LANG_MERGING="[*] Merging files..."
    LANG_WAIT="[*] Please wait, this may take a few minutes..."
    LANG_SUCCESS="[✓] Files merged successfully!"
    LANG_SAVED_IN="[✓] Saved in:"
    LANG_PROMPT_DELETE="Do you want to delete the original split files to save space? (y/n): "
    LANG_DELETED="[✓] Original files removed."
    LANG_ERR_MERGE="[X] An error occurred while merging the files."
    AFFIRMATIVE_REGEX="^[Yy]$"
fi

clear
echo -e "${CYAN}=======================================${NC}"
echo -e "${GREEN}   $LANG_TITLE   ${NC}"
echo -e "${CYAN}=======================================${NC}\n"

# Permissão de Armazenamento
if [ ! -d "/sdcard/Download" ]; then
    echo -e "${YELLOW}$LANG_STORAGE_REQ${NC}"
    termux-setup-storage
    sleep 2
fi

cd /sdcard/Download || { echo -e "${RED}$LANG_ERR_DOWNLOAD${NC}"; exit 1; }

echo -e "${GREEN}$LANG_SEARCHING${NC}\n"

# Listar ficheiros .pkg
all_files=(*.pkg)
if [ ! -e "${all_files[0]}" ]; then
    echo -e "${RED}$LANG_NO_FILES${NC}"
    exit 1
fi

echo -e "$LANG_FILES_FOUND"
for f in "${all_files[@]}"; do
    echo -e "  - ${YELLOW}$f${NC}"
done

echo -e "\n${CYAN}---------------------------------------${NC}"
read -p "$LANG_PROMPT_PATTERN" pattern
read -p "$LANG_PROMPT_OUTPUT" output_name

if [ -z "$pattern" ] || [ -z "$output_name" ]; then
    echo -e "${RED}[X] Operação cancelada.${NC}"
    exit 1
fi

# Procurar e ordenar os ficheiros pelo nome (ex: Piece 0, Piece 1, Piece 2...)
matched_files=($(ls *"$pattern"*.pkg 2>/dev/null | sort -V))

if [ ${#matched_files[@]} -eq 0 ]; then
    echo -e "${RED}$LANG_NO_MATCH${NC}"
    exit 1
fi

echo -e "\n${GREEN}$LANG_PARTS_LIST${NC}"
for file in "${matched_files[@]}"; do
    echo -e "  [+] $file"
done

echo -e "\n${YELLOW}$LANG_MERGING${NC}"
echo -e "${YELLOW}$LANG_WAIT${NC}\n"

# Juntar todos os ficheiros numa só linha de comando
cat "${matched_files[@]}" > "$output_name"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}$LANG_SUCCESS${NC}"
    echo -e "${GREEN}$LANG_SAVED_IN /sdcard/Download/$output_name${NC}\n"
    
    read -p "$LANG_PROMPT_DELETE" confirm
    if [[ "$confirm" =~ $AFFIRMATIVE_REGEX ]]; then
        rm "${matched_files[@]}"
        echo -e "${GREEN}$LANG_DELETED${NC}"
    fi
else
    echo -e "${RED}$LANG_ERR_MERGE${NC}"
fi

echo -e "\n${CYAN}=======================================${NC}"
