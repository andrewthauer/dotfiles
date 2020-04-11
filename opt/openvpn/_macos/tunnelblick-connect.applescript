-- on basename(thePath)
--   set thePath to quoted form of POSIX path of thePath
--   do shell script "basename $(dirname " & thePath & ")"
-- end basename

-- set script_path to path to me
-- set profile_name to basename(scriptPath)

set profile_name to system attribute "PROFILE_NAME"

tell application "Tunnelblick"
    connect profile_name
    get state of first configuration where name = profile_name
    repeat until result = "CONNECTED"
        delay 1
        get state of first configuration where name = profile_name
    end repeat
end tell
