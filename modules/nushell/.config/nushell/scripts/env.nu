def from-env [] -> record {
    lines
        | split column '#'
        | get column1
        | compact --empty
        | parse "{key}={value}"
}

def expand-var [input: string] -> string {
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
