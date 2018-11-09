# Shellscript: cksum_dir.sh
Objective/Scope: Fast mass verification of file integrity by calculating the checksums of all Files and compare them afterwards.

User Story: I once came to a point, where i had many Files beeing copied over unstable lines. I wouldn't even trust Filesizes to reflect if the files were copied accurately.
So i searched for a fast way to compare if the Files were really copied the right way for Linux - checking it Bit for Bit afterwards. As i didn't want to copy the data over and over again for comparision, i wrote this script, which does the cecking for me. Here is a brief description how i used it for better understanding:

1. First run the script in the directory that will be copied. It will create a Logfile and store the checksums of each file in it.
eg.: ./cksum.sh
2. Then copy all Files including the newly created Path ".cksum" and its containing Log.
3. On the destination run the script again, giving one Parater: The name of the last logfile (without path)
eg: ./cksum.sh cksum_20181109150924.log
This will finally do the same thing as 1. And comare the both logs line by line.

Result: If anywhere in the Files there is a diffent content - and may it only be asingle Bit - it the Filename will be printed out.
So you can even detect changed files if there should by no changes at all.

Requirements
Software: cksum, find ans other standard Linux-cmds

The script is POSIX conform, so let it run as shell script.

If you like it, checkout my Homepage for Donations or for the Mail to send me Lovings.
