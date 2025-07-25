# Parse a dotenv file into a record
def "from env" [
    --expand (-e)  # Expand the variables in the input
]: list -> record {
    mut $e = sanitize-lines
        | parse "{key}={value}"
        | each {|i| $i | str trim --char '"' | str trim --char "'" }
        | transpose --header-row --as-record

    if ($expand) {
        $e = ($e
            | items {|k, v| {key: $k, value: ($v | expand-var)} }
            | transpose --header-row --as-record)
    }

    $e
}

# Parse a file of bash aliases into nushell aliases
def "from aliases" []: list -> record {
    mut $e = sanitize-lines
        | parse "alias {key}={value}"
        | each {|i|
            let value = $i.value | unquote | expand-var

            # If the alias contains a pipe, create a function
            if ($value | str contains "|") {
                # Check if the alias value contains the alias name and prepend with ^
                let safe_value = if ($value | str contains $i.key) {
                    $value | str replace --all $i.key $"^($i.key)"
                } else {
                    $value
                }
                $"def ($i.key) [] { ($safe_value) }"
            } else {
                # For simple aliases without pipes, use regular alias syntax
                $"alias ($i.key) = ($value)"
            }
        }

    $e
}

# Read a dotenv or alias file into a record by removing comments and empty lines
def sanitize-lines [] {
    mut $e = lines
        | split column "#"
        | get column1
        | compact --empty

    $e
}

# Remove wrapping quotes from a string
def unquote []: string -> string {
    let $input = $in
    let length = $input | str length

    # Check if the input is wrapped in quotes before trimming
    if (($input | str starts-with '"') and ($input | str ends-with '"') or
        ($input | str starts-with "'") and ($input | str ends-with "'"))  {
        return ($input | str substring 1..($length - 2))
    }

    return $input
}

# Expand posix style environment variables in a string
def expand-var []: string -> string {
    let $input = $in

    const tokenRegex = '(\$\{?[a-zA-Z_][a-zA-Z0-9_]*\}?)'
    const varRegex = '\$\{?([a-zA-Z_][a-zA-Z0-9_]*)\}?'

    let tokens = ($input | parse --regex $tokenRegex | rename token)
    mut s = $input

    for r in $tokens {
        let token = $r.token
        let key = $token | parse --regex $varRegex | get -o capture0.0
        let replacement = $env | get -o $key
        if ($replacement | is-empty) {
            continue
        }
        $s = ($s | str replace --all $"($token)" $replacement)
    }

    $s
}
