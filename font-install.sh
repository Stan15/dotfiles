#!/bin/bash

echo "[-] Download font [-]"
DOWNLOAD_LINK=$1
echo $DOWNLOAD_LINK

wget "${DOWNLOAD_LINK}" -O fontfile.zip -q --show-progress
if [ $? -eq 0 ]; then
    unzip -q fontfile.zip -d ~/.fonts
    fc-cache -f

    rm fontfile.zip
    echo "done!"
else
    echo "Could not install font. Make sure that this font exists."
fi

