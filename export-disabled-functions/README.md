# Description
The script is designed to export and import the disable_function php option for all domains

# Usage
1. Upload the script to a source server and run it
./transfer-disable-functions.sh --export
2. Copy script and created file (disable_functions.csv) to a target server
3. Run the script on a target server to import settings:
./transfer-disable-functions.sh --import