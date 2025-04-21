function unquote
  if test (string length -- "$line") -ge 2
    # Get first and last characters
    set first_char (string sub -l 1 -- "$line")
    set last_char (string sub -s -1 -- "$line")

    # Check if string starts and ends with the same quote character
    if test \( "$first_char" = "'" -a "$last_char" = "'" \) -o \( "$first_char" = '"' -a "$last_char" = '"' \)
      # Remove first and last character
      set line (string sub -s 2 -e -1 -- "$line")
    end
  end
end
