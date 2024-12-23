# Parse a dotenv file into a record
def "from env" [
    --expand (-e)  # Expand the variables in the input
]: list -> record {
    mut $e = lines
        | split column '#'
        | get column1
        | compact --empty
        | parse "{key}={value}"
        | each { |i| $i | str trim --char '"' | str trim --char "'" }
        | transpose --header-row --as-record

    if ($expand) {
        $e = ($e
            | items {|k, v| {key: $k, value: (expand-var $v)} }
            | transpose --header-row --as-record)
    }

    $e
}

def expand-var [input: string]: nothing -> string {
    const tokenRegex = '(\$\{?[a-zA-Z_][a-zA-Z0-9_]*\}?)'
    const varRegex = '\$\{?([a-zA-Z_][a-zA-Z0-9_]*)\}?'

    let tokens = ($input | parse --regex $tokenRegex | rename token)
    mut s = $input

    for r in $tokens {
        let token = $r.token
        let key = $token | parse --regex $varRegex | get -i capture0.0
        let replacement = $env | get -i $key
        if ($replacement | is-empty) {
            continue
        }
        $s = ($s | str replace --all $"($token)" $replacement)
    }

    $s
}
