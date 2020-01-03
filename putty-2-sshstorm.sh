iconv -f UTF-16LE -t UTF-8 putty_sessions.reg -o putty_sessions.reg.new
grep -E 'Sessions|"HostName"|"PublicKeyFile"|"UserName"' putty_sessions.reg.new > putty_sessions.tmp
filename='putty_sessions.tmp'

rm -Rf config

while read -r p; do 
    if [[ "$p" == *"Sessions"* ]]; then
        displayname=$(echo "$p" | awk -F '\' '{print $6}')
        displayname=$(echo $displayname | cut -d "]" -f 1)
        if [[ ! -z "${displayname}" ]]; then
            echo "Host ${displayname}" >> config
        fi
    elif [[ "$p" == *"HostName"* ]]; then
        hostname=$(echo "$p" | awk -F '"' '{print $4}')
        if [[ ! -z "${hostname}" ]]; then
            echo "     hostname ${hostname}" >> config
        fi
    elif [[ "$p" == *"PublicKeyFile"* ]]; then
        pubkey=$(echo "$p" | awk -F '"' '{print $4}')
        if [[ ! -z "${pubkey}" ]]; then
            echo "     identityfile ${pubkey}" >> config
        fi
    elif [[ "$p" == *"UserName"* ]]; then
        user=$(echo "$p" | awk -F '"' '{print $4}')
        if [[ ! -z "${user}" ]]; then
            echo "     user ${user}" >> config
        fi
    fi

done < "$filename"

rm -Rf putty_sessions.reg.new
rm -Rf putty_sessions.tmp
