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
    LANG_SEARCHING="[+] A procurar ficheiros na pasta Download..."
    LANG_NO_FILES="[X] Nenhum ficheiro .pkg encontrado em /sdcard/Download."
    LANG_FILES_FOUND="Ficheiros encontrados:"
    LANG_PROMPT_PATTERN="Digita o padrão em comum dos ficheiros (ex: Piece, Jogo, ou * para TODOS): "
    LANG_PROMPT_OUTPUT="Nome sugerido para o ficheiro final (prime Enter para aceitar ou digita outro): "
    LANG_NO_MATCH="[X] Nenhum ficheiro corresponde ao padrão indicado."
    LANG_PARTS_LIST="As seguintes partes serão unidas nesta ordem:"
    LANG_MERGING="[*] A juntar ficheiros..."
    LANG_WAIT="[*] Aguarda um momento, isto pode demorar alguns minutos..."
    LANG_SUCCESS="[✓] Ficheiro .pkg unificado com sucesso!"
    LANG_SAVED_IN="[✓] Guardado em:"
    LANG_PROMPT_DELETE="Desejas apagar os ficheiros originais para poupar espaço? (s/n): "
    LANG_DELETED="[✓] Ficheiros originais removidos."
    LANG_ERR_MERGE="[X] Ocorreu um erro ao juntar os ficheiros."
    AFFIRMATIVE_REGEX="^[Ss]$"
else
    LANG_TITLE="AUTOMATIC PKG MERGER"
    LANG_STORAGE_REQ="[!] Requesting storage permission..."
    LANG_ERR_DOWNLOAD="[X] Could not access the Download folder."
    LANG_SEARCHING="[+] Searching for files in Download folder..."
    LANG_NO_FILES="[X] No .pkg files found in /sdcard/Download."
    LANG_FILES_FOUND="Found files:"
    LANG_PROMPT_PATTERN="Enter the common pattern of the files (e.g., Piece, Game, or * for ALL): "
    LANG_PROMPT_OUTPUT="Suggested final file name (press Enter to accept or type another): "
    LANG_NO_MATCH="[X] No files match the given pattern."
    LANG_PARTS_LIST="The following parts will be merged in this order:"
    LANG_MERGING="[*] Merging files..."
    LANG_WAIT="[*] Please wait, this may take a few minutes..."
    LANG_SUCCESS="[✓] .pkg file merged successfully!"
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

# Listar ficheiros
all_files=(*pkg* *.part*)
if [ ! -e "${all_files[0]}" ]; then
    echo -e "${RED}$LANG_NO_FILES${NC}"
    exit 1
fi

echo -e "$LANG_FILES_FOUND"
for f in "${all_files[@]}"; do
    [ -f "$f" ] && echo -e "  - ${YELLOW}$f${NC}"
done

echo -e "\n${CYAN}---------------------------------------${NC}"
read -p "$LANG_PROMPT_PATTERN" pattern

if [ -z "$pattern" ]; then
    echo -e "${RED}[X] Operação cancelada.${NC}"
    exit 1
fi

# Procurar e ordenar os ficheiros correspondentes
matched_files=($(ls *"$pattern"* 2>/dev/null | sort -V))

if [ ${#matched_files[@]} -eq 0 ]; then
    echo -e "${RED}$LANG_NO_MATCH${NC}"
    exit 1
fi

# 1. Tentar extrair um nome automático limpando padrões numéricos/de parte do primeiro ficheiro
first_file="${matched_files[0]}"

# Remove extensão .pkg ou .part no final
base_name="${first_file%.pkg}"
base_name="${base_name%.part*}"

# Limpa sufixos do tipo: .part01, _part1, .0, _0, Piece 0, Piece 1, etc.
suggested_name=$(echo "$base_name" | sed -E 's/[._ -]?(part|piece)[._ -]?[0-9]+$//i' | sed -E 's/[._ -][0-9]+$//')

# Garante que não fica vazio
if [ -z "$suggested_name" ]; then
    suggested_name="Output_Merged"
fi

# Exibir nome sugerido
echo -e "\n$LANG_PROMPT_OUTPUT"
echo -e "Default: ${GREEN}${suggested_name}.pkg${NC}"
read -p "> " custom_name

# Usar a sugestão se o utilizador só carregar em Enter
if [ -z "$custom_name" ]; then
    final_name="${suggested_name}.pkg"
else
    # Se o utilizador não escreveu .pkg no final, adiciona automaticamente
    if [[ "$custom_name" != *.pkg ]]; then
        final_name="${custom_name}.pkg"
    else
        final_name="$custom_name"
    fi
fi

echo -e "\n${GREEN}$LANG_PARTS_LIST${NC}"
for file in "${matched_files[@]}"; do
    echo -e "  [+] $file"
done

echo -e "\n${YELLOW}$LANG_MERGING${NC}"
echo -e "${YELLOW}$LANG_WAIT${NC}\n"

# Processo de junção
cat "${matched_files[@]}" > "$final_name"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}$LANG_SUCCESS${NC}"
    echo -e "${GREEN}$LANG_SAVED_IN /sdcard/Download/$final_name${NC}\n"
    
    read -p "$LANG_PROMPT_DELETE" confirm
    if [[ "$confirm" =~ $AFFIRMATIVE_REGEX ]]; then
        rm "${matched_files[@]}"
        echo -e "${GREEN}$LANG_DELETED${NC}"
    fi
else
    echo -e "${RED}$LANG_ERR_MERGE${NC}"
fi

echo -e "\n${CYAN}=======================================${NC}"
