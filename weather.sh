#!/bin/bash

# Path to the CSV
CSV_FILE="worldcities.csv"

# Extract unique countries and store in an array
mapfile -t COUNTRIES < <(awk -F',' 'NR>1 {print $5}' "$CSV_FILE" | sort -u)

# Function to display main menu
main_menu() {
    while true; do
        echo "===== MAIN MENU ====="
        echo "1 - Show all countries"
        echo "2 - Search for a country"
        echo "3 - Select a country by number"
        echo "0 - Exit"
        read -rp "Choose an option: " option
        case $option in
            1) show_all_countries ;;
            2) search_country ;;
            3) select_country ;;
            0) exit 0 ;;
            *) echo "Invalid option! Try again." ;;
        esac
    done
}

# Show all countries
show_all_countries() {
    echo "===== LIST OF COUNTRIES ====="
    for i in "${!COUNTRIES[@]}"; do
        printf "%d - %s\n" "$((i+1))" "${COUNTRIES[i]}"
    done
}

# Search country
search_country() {
    read -rp "Enter search term: " term
    echo "===== SEARCH RESULTS ====="
    local found=()
    for i in "${!COUNTRIES[@]}"; do
        if [[ "${COUNTRIES[i],,}" == *"${term,,}"* ]]; then
            printf "%d - %s\n" "$((i+1))" "${COUNTRIES[i]}"
            found+=("$((i+1))")
        fi
    done

    if [ ${#found[@]} -eq 0 ]; then
        echo "No countries found matching '$term'."
        return
    fi

    # Let user select from search results
    read -rp "Select a country by number (0 to cancel): " choice
    if [ "$choice" -eq 0 ]; then
        return
    elif [[ " ${found[*]} " =~ " $choice " ]]; then
        echo "You selected: ${COUNTRIES[$((choice-1))]}"
    else
        echo "Invalid selection."
    fi
}

# Select country directly by number
select_country() {
    read -rp "Enter country number (0 to go back): " choice
    if [ "$choice" -eq 0 ]; then
        return
    elif [ "$choice" -ge 1 ] && [ "$choice" -le "${#COUNTRIES[@]}" ]; then
        selected_country="${COUNTRIES[$((choice-1))]}"
        echo "You selected: $selected_country"
        select_state "$selected_country"
    else
        echo "Invalid number."
    fi
}

get_states() {
    local country="$1"
    mapfile -t STATES < <(grep '"Brazil"' worldcities.csv | cut -d',' -f8 | tr -d '"' | sort | uniq)
}

# Select state
select_state() {
    get_states "$1"
    if [ ${#STATES[@]} -eq 0 ]; then
        echo "No states found for $1."
        return
    fi

    echo "===== STATES IN $1 ====="
    for i in "${!STATES[@]}"; do
        printf "%d - %s\n" "$((i+1))" "${STATES[i]}"
    done

    read -rp "Select a state by number (0 to go back): " choice
    if [ "$choice" -eq 0 ]; then
        return
    elif [[ "$choice" -ge 1 && "$choice" -le "${#STATES[@]}" ]]; then
        echo "You selected: ${STATES[$((choice-1))]}"
    else
        echo "Invalid selection."
    fi
}

# Start the menu
main_menu

