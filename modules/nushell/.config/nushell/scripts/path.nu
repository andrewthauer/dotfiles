use std "path add"

def --env prepand_path [p: string] {
    if ($p | path exists) {
        path add $p
    }
}
