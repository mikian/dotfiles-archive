autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

# get the difference between the local and remote branches
git_remote_status() {
    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)/refs\/remotes\/}
    if [[ -n ${remote} ]] ; then
        ahead=$(($(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l) + 0))
        behind=$(($(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l) + 0))

        if [ $ahead -eq 0 ] && [ $behind -gt 0 ]
        then
            echo "/-$behind"
        elif [ $ahead -gt 0 ] && [ $behind -eq 0 ]
        then
	        echo "/+$ahead"
        elif [ $ahead -gt 0 ] && [ $behind -gt 0 ]
        then
            echo "/+$ahead-$behind"
        fi
    fi
}

git_dirty() {
  st=$($git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ "$st" =~ ^nothing ]]
    then
      echo "%{$fg_bold[green]%}[$(git_prompt_info)$(git_remote_status)]%{$reset_color%}"
    else
      echo "%{$fg_bold[red]%}[$(git_prompt_info)$(git_remote_status)]%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

ruby_version() {
  if (( $+commands[rbenv] ))
  then
    echo "$(rbenv version | awk '{print $1}')"
  fi

  if (( $+commands[rvm-prompt] ))
  then
    echo "$(rvm-prompt | awk '{print $1}')"
  fi
}

rb_prompt() {
  if ! [[ -z "$(ruby_version)" ]]
  then
    echo "($(ruby_version))"
  else
    echo ""
  fi
}

directory_name() {
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

# export PROMPT=$'\n$(rb_prompt)in $(directory_name) $(git_dirty)$(need_push)\n› '
export PROMPT=$'%4~$(git_dirty)$(rb_prompt) %# '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
