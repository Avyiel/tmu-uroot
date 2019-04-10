get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value="$(tmux show-option -gqv "$option")"
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

_tty_info() {
  tty="$1"
  uname -s | grep -q "CYGWIN" && cygwin=true

  if [ x"$cygwin" = x"true" ]; then
    ps -af | tail -n +2 | awk -v tty="$tty" '
      $4 == tty { user[$2] = $1; child[$3] = $2 }
      END {
        for (i in user)
        {
          if (!(i in child))
          {
            file = "/proc/" i "/cmdline"; getline command < file; close(file)
            gsub(/\0/, " ", command)
            print i, user[i], command
            exit
          }
        }
      }
    '
  else
    ps -t "$tty" -o user= -o pid= -o ppid= -o command= | awk '
      { user[$2] = $1; child[$3] = $2; for (i = 4 ; i <= NF; ++i) command[$2] = i > 4 ? command[$2] FS $i : $i }
      END {
        for (i in user)
        {
          if (!(i in child))
          {
            print i, user[i], command[i]
            exit
          }
        }
      }
    '
  fi
}

_ssh_or_mosh_args() {
  args=$(printf '%s' "$1" | awk '/ssh/ && !/vagrant ssh/ && !/autossh/ && !/-W/ { $1=""; print $0; exit }')
  if [ -z "$args" ]; then
    args=$(printf '%s' "$1" | grep 'mosh-client' | sed -E -e 's/.*mosh-client -# (.*)\|.*$/\1/' -e 's/-[^ ]*//g' -e 's/\d:\d//g')
  fi

 printf '%s' "$args"
}
