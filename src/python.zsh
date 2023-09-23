#!/usr/bin/env zsh

export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH

declare python_path="$(bash --norc -ec 'IFS=:; paths=($PATH); for i in ${!paths[@]}; do if [[ ${paths[i]} == "'$HOME/.pyenv/shims'" ]]; then unset '\''paths[i]'\''; fi; done; echo "${paths[*]}"')"
pathadd "$HOME/.pyenv/shims:${python_path}"
export PYENV_SHELL=zsh
source "$HOME/.pyenv/libexec/../completions/pyenv.zsh"
command pyenv rehash 2>/dev/null
pyenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(pyenv "sh-$command" "$@")"
    ;;
  *)
    command pyenv "$command" "$@"
    ;;
  esac
}

if [[ -d "$PWD/env" ]]; then
  source $PWD/env/bin/activate
fi
