use std "path add"

def --env prepend_path [p: string] {
    if ($p | path exists) {
        path add $p
    }
}
