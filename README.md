step 1: extract your putty config from window reg

REG EXPORT HKCU\Software\SimonTatham\PuTTY\Sessions putty_sessions.reg

step 2: run the bash script , make sure putty_sessions.reg file is placed in same directory as script

step 3: copy the generated config file over to your .ssh directory and ensure 600 permissions.

step 4: run storm list to see if storm ssh can list all your ssh config