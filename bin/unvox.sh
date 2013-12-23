# unvox.sh
# find iphone voicemails and save them locally
#
# Sean O'Donnell
# Mon Dec 23 14:36:42 EST 2013
#
# requires ffmpeg, see http://www.ffmpeg.org/ 

BASE_DIR=$(dirname $(dirname $0))
INPUT_DIR="${HOME}/Library/Application Support/MobileSync/Backup"
OUTPUT_DIR="${BASE_DIR}/data"
INDEX_FILE="${OUTPUT_DIR}/index.dat"

echo "Searching..."

find "${INPUT_DIR}" -exec file {} \; | egrep 'GSM|MPEG' | cut -d':' -f1 > "${INDEX_FILE}"

echo "Converting..."

cat "${INDEX_FILE}" | while read line;
   do   
     file_name=$(basename "$(dirname "$line")"_"$(basename "$line")")
     ffmpeg -i "$line" "${OUTPUT_DIR}/${file_name}.wav"
done
