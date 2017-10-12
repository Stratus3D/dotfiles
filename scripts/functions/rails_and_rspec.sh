# Commands that aren't present in zshell plugins
function _rspec_command () {
  if [ -e "bin/rspec" ]; then
    bin/rspec $@
  elif type bundle &> /dev/null && [ -e "Gemfile" ]; then
    bundle exec rspec $@
  else
    command rspec $@
  fi
}

function _spring_command () {
  if [ -e "bin/spring" ]; then
    bin/spring $@
  elif type bundle &> /dev/null && [ -e "Gemfile" ]; then
    bundle exec spring $@
  else
    command spring $@
  fi
}
