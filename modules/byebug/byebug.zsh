# start bye bug in the current dir
start_byebug() {
  filename=.powenv

  if [ ! -f $filename ]; then
    echo $fg[yellow]".powenv not found"
    return
  fi

  # TODO - Implement more reliable seraching for 'export BYEBUGPORT=####'
  port=$(head -n 1 .powenv | cut -c19-100)

  # echo "Starting byebug on localhost:${port}"
  byebug -R localhost:$port
}

alias bb=start_byebug
