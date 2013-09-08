# From http://dotfiles.org/~_why/.zshrc
# Sets the window title nicely no matter where you are
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  # Set Apple Terminal.app resume directory
  if [[ $TERM_PROGRAM == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]] {
    # local SEARCH=' '
    # local REPLACE='%20'
    local PWD_URL="file://$HOSTNAME${PWD// /%20}"
    print -Pn '\e]7;$PWD\a'
  }

  case $TERM in
  screen)
    print -Pn "\ek$a:$3\e\\" # screen title (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$3\a" # plain xterm title ($3 for pwd)
    ;;
  esac
}
