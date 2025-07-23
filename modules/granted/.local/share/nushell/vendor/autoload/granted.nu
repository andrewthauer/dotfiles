# https://gist.github.com/abusch/aadadfdfe4684813945daed7a4a052d6

# nushell support for https://github.com/common-fate/granted
# Save this file to `granted.nu` in your nushell config dir, then add `use granted.nu *` in your config.nu

# assume - https://granted.dev
export def --env --wrapped assume [...rest: string] {
  const var_names = [
    "AWS_ACCESS_KEY_ID",
    "AWS_SECRET_ACCESS_KEY",
    "AWS_SESSION_TOKEN",
    "AWS_PROFILE",
    "AWS_REGION",
    "AWS_SESSION_EXPIRATION",
    "GRANTED_SSO",
    "GRANTED_SSO_START_URL",
    "GRANTED_SSO_ROLE_NAME",
    "GRANTED_SSO_REGION",
    "GRANTED_SSO_ACCOUNT_ID"
  ]

  # Run assumego and collect its output
  let output = with-env {GRANTED_ALIAS_CONFIGURED: "true"} {
    assumego ...$rest
  }
  let granted_output = $output | lines

  # scope variables | print

  # First line is the command
  let command = $granted_output | get -o 0 | default "" | str trim | split row " "

  let flag = $command | get 0
  # Collect environment variables to set
  let envvars = do {
    let values = $command | skip 1
    let vars = $var_names |
      zip $values |
      where {|x| $x.1 != "None"} |
      reduce --fold {} {|it, acc| $acc | insert $it.0 $it.1}
    $vars
  }
  match $flag {
    "GrantedOutput" => {
      # The rest of the output (if any)
      let to_display = $granted_output | skip 1
      $to_display | str join "\n" | print
    },
    "GrantedAssume" => {
      for v in $var_names {
        hide-env -i $v
      }
      load-env $envvars
    },
    "GrantedDesume" => {
      for v in $var_names {
        hide-env -i $v
      }
    },
    "GrantedExec" => {
      let num_vars = ($var_names | length)
      let cmd = $command | range ($num_vars + 1).. | str join " "
      with-env $envvars { nu -c $"($cmd)"}
    }
    _ => {
      # most likely no output, so nothing to do
    }
  }
}
