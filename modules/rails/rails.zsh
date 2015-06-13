# ===========================================================
# Rails aliases & functions
#
# These are meant to compliment existing oh-my-zsh plugins:
# - oh-my-zsh/plugins/bundler
# - oh-my-zsh/plugins/ruby
# - oh-my-zsh/plugins/rails
# ===========================================================

# start bye bug in the current dir
start_rails() {
  filename=.railsrc~

  if [ ! -f $filename ]; then
    echo $fg[yellow]"${filename} not found"
    return
  fi

  # TODO - Implement more reliable seraching for 'export BYEBUGPORT=####'
  port=$(head -n 1 $filename)

  # echo "Starting rails on localhost:${port}"
  bundle exec rails s -p $port
}

alias choo=start_rails

alias testdropdb="bundle exec rake db:drop RAILS_ENV=test"
alias testcreatedb="bundle exec rake db:create RAILS_ENV=test"
alias testloaddb="bundle exec rake db:schema:load RAILS_ENV=test"
alias testreset="testdropdb; testcreatedb; testloaddb; testprep"

alias testprep="bundle exec rake db:migrate RAILS_ENV=test"
alias schemas="bundle exec rake db:migrate; testprep"

alias be="bundle exec"
alias rdm="bundle exec rake db:migrate"

alias brspec="bundle exec rspec"
