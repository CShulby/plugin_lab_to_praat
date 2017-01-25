###############################################################
###############################################################
##This code will:
##1. Read a lab file in HTS format into a Praat TextGrid
##   with a single tier ("phone")
##2. Load both the audio and labels as objects
##3. open the aligned TextGrid and phonetic tier for editing
###############################################################
###############################################################

#Allow Input
form Info
    sentence Lab_file_dir /home/user_name/1.lab
endform

clearinfo

#read the .lab file into praat

tgID = undefined
stringID = Read Strings from raw text file: lab_file_dir$
numberOfStrings = Get number of strings

for stringNumber from 3 to numberOfStrings
    selectObject: stringID
    line$ = Get string: stringNumber

    time_start = extractNumber(line$, "")
    time_end   = extractNumber(line$, " ")
    label$     = replace_regex$(line$, ".*\s(.*)$", "\1", 1)

    @replace: time_start
    time_start  = replace.number

    @replace: time_end
    time_end  = replace.number

    if tgID == undefined
        tgID = Create TextGrid: 0, time_end, "token", ""
        Rename: "Labels"
    else
        selectObject: tgID
        duration = Get total duration
        nocheck Extend time: time_end - duration, "End"
    endif

    #Insert boundaries
    nocheck Insert boundary: 1, time_start
    nocheck Insert boundary: 1, time_end
    interval = Get low interval at time: 1, time_end
    Set interval text: 1, interval, label$
endfor

removeObject: stringID
<<<<<<< HEAD
selectObject: tgID
Replace interval text: 1, 0, 0, "^.*?-([^+]*?)\+.*", "\1", "Regular Expressions"
=======
selectObject: soundID, tgID
>>>>>>> 831c8503219eb043766b7891d6d8dc10a9d22208

#string replace to format time in seconds
procedure replace: .number
    .number /= 1e7
endproc
