#!/bin/bash

# Function to generate a random password

generate_password() {
    local length=$1
    local use_special=$2

    # Define character sets
    lowercase='abcdefghijklmnopqrstuvwxyz'
    uppercase='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    numbers='0123456789'
    special_chars='!@#$%^&*()_-+=<>?/'

    # Initialize the character set
    char_set="$lowercase$uppercase$numbers"

    # Include special characters if specified
    if [ "$use_special" = "true" ]; then
        char_set="$char_set$special_chars"
    fi

    # Use /dev/urandom to generate random bytes and convert to hexadecimal
    random_hex=$(xxd -l "$length" -p /dev/urandom)

    # Build the password from the random hexadecimal
    password=""
    for ((i = 0; i < length; i += 2)); do
        hex_char="${random_hex:$i:2}"
        decimal_value=$((0x$hex_char))
        char_index=$((decimal_value % ${#char_set}))
        password="${password}${char_set:$char_index:1}"
    done

    echo "$password"
}

# Function to display help information
helpp() {
    echo "help: $(basename "$0") [-l length] [-s]"
    echo "Options:"
    echo "  -l length   Specify the length of the password (default: 16)"
    echo "              Uses 2 Spaces for 1 character"
    echo "  -s          Include special characters in the password"
    exit 1
}

# Default values
password_length=16
use_special=false
output_file="password.txt"

# Parse command line options
while getopts ":l:s" opt; do
    case $opt in
        l)
            password_length=$OPTARG
            ;;
        s)
            use_special=true
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            helpp
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            helpp
            ;;
    esac
done
while true ; do
clear
echo "			       ________   ___      __    _     ______   ___        ___         ____                          "
echo "			      /  ______) /   \    |  |  (_)   / ___  | /   \      /   |       /    \                         "
echo "			      / |        /  \ \   |  |   _   /  /  | | /  \ \    / /  |      /  __  \                        "
echo "			      / |______  /  |\ \  |  |  | | (  |__ | | /  |\ \__/ /|  |     /  /  \  \                       "
echo "			      /  ______) /  | \ \ |  |  | |  \____)| | /  | \____/ |  |    /  /____\  \                      "
echo "			      / |        /  |  \ \|  |  | |        | | /  |        |  |   /  ________  \                     "
echo "			      / |______  /  |   \ |  |  | |   _____| | /  |        |  |  /  /        \  \                    "
echo "			      /________) /__|    \___|  |_|  (_______/ /__|        |__| /__/          \__\ v6.9              "
echo "                                                                                                                       "
echo "                                      .:.:. Password Generator Tool Coded BY: @ScorpioX .:.:.                          "
echo "                                                                                                                       "
echo -e "                                   \e[31m:: Disclaimer: Developers assume no liability and are not  ::\e[O          "
echo -e "                                   \e[31m:: responsible for any misuse or damage caused by ENIGMA   ::\e[O          "
echo -e "                        \e[97m                                                                       \e[O           "
echo "                                                                                                                       "
echo "                    [01] Generate Password                                                                             "
echo "                    [02] To Save in File                                                                               "
echo "                    [03] Display Password from File                                                                    "
echo "                    [04] Exit                                                                                          "
echo "                                                                                                                       "
echo "                    [*] Choose an option:                                                                              "
read choice

case $choice in
    "1")
    	echo "Enter how many passwords you want to Generate)"
    	read l
    	counter=0
	# Define the condition for the while loop
	while [ $counter -lt $l ]; do
   		generated_password=$(generate_password "$password_length" "$use_special")
		echo "Generated Password: $generated_password"
    		# Increment the counter
    		((counter++))
	done	
       	;;
    "2")
    	counter=0
	echo "Enter How many passwords you want to Generate)"
	read userInput
	# Define the condition for the while loop
	while [ $counter -lt $userInput ]; do
   		generated_password=$(generate_password "$password_length" "$use_special")
		echo "Generated Password: $generated_password"
		echo "$generated_password">>"$output_file"
    		# Increment the counter
    		((counter++))
	done
	echo "">>"$output_file"
	echo "Password saved to a file"
        ;;
    "3")
        # Display passwords from file
        if [ -e "$output_file" ]; then
            echo "Displaying passwords from $output_file:"
            cat "$output_file"
        else
            echo "File $output_file does not exist or is empty."
        fi
        ;;
    "4")
    	clear
        exit 0
        ;;
    *)
        echo "Invalid!"
        ;;
esac
echo ""
echo "Press Enter to continue..."
read -r enter_key

done 
