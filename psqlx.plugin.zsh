#####################################################################
# Init
#####################################################################

function psqlx () {
  [[ $# -gt 0 ]] || {
    _psqlx::help
    return 1
  }

  local command="$1"
  shift

  (( $+functions[_psqlx::$command] )) || {
    _psqlx::help
    return 1
  }

  _psqlx::$command "$@"
}

function _psqlx {
  local -a cmds subcmds
  cmds=(
    'help:Usage information'
    'init:Initialisation information'
  )

  if (( CURRENT == 2 )); then
    _describe 'command' cmds
  elif (( CURRENT == 3 )); then
    case "$words[2]" in
      search) subcmds=(
        'name:description'
        )
        _describe 'command' subcmds ;;
    esac
  fi

  return 0
}

compdef _psqlx psqlx

function _psqlx::help {
    cat <<EOF
Usage: psqlx <command> [options]

Available commands:

  init

EOF
}

function _psqlx::init {
  echo "============================================="
  echo "============================================="
}
