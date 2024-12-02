export-env {
  $env.config = {
    hooks: {
      env_change: {
          PWD: [{ ||
              if (which direnv | is-empty) {
                  return
              }

              direnv export json | from json | default {} | load-env
          }]
      }
    }
  }
}
