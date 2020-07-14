# vim:ft=zsh ts=2 sw=2 sts=2
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts
CURRENT_BG='NONE'
if [[ -z "$PRIMARY_FG" ]]; then
	PRIMARY_FG=black
fi

# Characters
SEGMENT_SEPARATOR=$'\ue0b0'$'\ue0b1'
SEGMENT_FINISHER=$'\ue0b0'

# Second prompt end activator
snd_prompt_end_flag=false

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3  #***********************
}

# Upper Line: draw upper line
prompt_upper_line() {
  printf "╭─────────────────────────────────────────────────────────────────────────────\n"
  prompt_segment black black ''
}

# Lower Line: draw Lower line
prompt_lower_line() {
  printf "╰─────────────────────────────────────────────────────────────────────────────\n"
}

# Time: what time is it?
prompt_time() {
	prompt_segment white black $(date "+%H:%M")
}

# Emoji: write random emojis in next line
prompt_emoji() {

  local emojis_f=(😀 😃 😄 😁 😆 😅 😂 🤣 😊 😇 🙂 🙃 😉 😌 😍 🥰 😘 😗 😙 😚 😋 😛 😝 😜 🤪 🤨 🧐 🤓 😎 🤩 🥳 😏 😒 😞 😔 😟 😕 🙁 😣 😖 😫 😩 🥺 😢 😭 😤 😠 😡 🤬 🤯 😳 🥵 🥶 😱 😨 😰 😥 😓 🤗 🤔 🤭 🤫 🤥 😶 😐 😑 😬 🙄 😯 😦 😧 😮 😲 🥱 😴 🤤 😪 😵 🤐 🥴 🤢 🤮 🤧 😷 🤒 🤕 🤑 🤠 😈 👿 👹 👺 🤡 💩 👻 💀 ☠️ 👽 👾 🤖 🎃 😺 😸 😹 😻 😼 😽 🙀 😿 😾 🧳 🌂 ☂️ 🧵 🧶 👓 🕶 🥽 🥼 🦺 👔 👕 👖 🧣 🧤 🧥 🧦 👗 👘 🥻 🩱 🩲 🩳 👙 👚 👛 👜 👝 🎒 👞 👟 🥾 🥿 👠 👡 🩰 👢 👑 👒 🎩 🎓 🧢 ⛑ 💄 💍 💼 )
  local emojis_s=(👨🏻‍🦰 👩🏻‍🦰 👱🏻 👱🏻‍♂️ 👱🏻‍♀️ 🧑🏻‍🦳 👩🏻‍🦳 👨🏻‍🦳 🧑🏻‍🦲 👨🏻‍🦲 👩🏻‍🦲 🧔🏻 🧓🏻 👴🏻 👵🏻 🙍🏻 🙍🏻‍♂️ 🙍🏻‍♀️ 🙎🏻 🙎🏻‍♂️ 🙎🏻‍♀️ 🙅🏻 🙅🏻‍♂️ 🙅🏻‍♀️ 🙆🏻 🙆🏻‍♂️ 🙆🏻‍♀️ 💁🏻 💁🏻‍♂️ 💁🏻‍♀️ 🙋🏻 🙋🏻‍♂️ 🙋🏻‍♀️ 🧏🏻 🧏🏻‍♂️ 🧏🏻‍♀️ 🙇🏻 🙇🏻‍♂️ 🙇🏻‍♀️ 🤦🏻 🤦🏻‍♂️ 🤦🏻‍♀️ 🤷🏻 🤷🏻‍♂️ 🤷🏻‍♀️ 🧑🏻‍⚕️ 👨🏻‍⚕️ 👩🏻‍⚕️ 🧑🏻‍🎓 👨🏻‍🎓 👩🏻‍🎓 🧑🏻‍🏫 👨🏻‍🏫 👩🏻‍🏫 🧑🏻‍⚖️ 👨🏻‍⚖️ 👩🏻‍⚖️ 🧑🏻‍🌾 👨🏻‍🌾 👩🏻‍🌾 🧑🏻‍🍳 👨🏻‍🍳 👩🏻‍🍳 🧑🏻‍🔧 👨🏻‍🔧 👩🏻‍🔧 🧑🏻‍🏭 👨🏻‍🏭 👩🏻‍🏭 🧑🏻‍💼 👨🏻‍💼 👩🏻‍💼 🧑🏻‍🔬 👨🏻‍🔬 👩🏻‍🔬 🧑🏻‍💻 👨🏻‍💻 👩🏻‍💻 🧑🏻‍🎤 👨🏻‍🎤 👩🏻‍🎤 🧑🏻‍🎨 👨🏻‍🎨 👩🏻‍🎨 🧑🏻‍✈️ 👨🏻‍✈️ 👩🏻‍✈️ 🧑🏻‍🚀 👨🏻‍🚀 👩🏻‍🚀 🧑🏻‍🚒 👨🏻‍🚒 👩🏻‍🚒 👮🏻 👮🏻‍♂️ 👮🏻‍♀️ 🕵🏻 🕵🏻‍♂️ 🕵🏻‍♀️ 💂🏻 💂🏻‍♂️ 💂🏻‍♀️ 👷🏻 👷🏻‍♂️ 👷🏻‍♀️ 🤴🏻 👸🏻 👳🏻 👳🏻‍♂️ 👳🏻‍♀️ 👲🏻 🧕🏻 🤵🏻 👰🏻 🤰🏻 🤱🏻 👼🏻 🎅🏻 🤶🏻 🦸🏻 🦸🏻‍♂️ 🦸🏻‍♀️ 🦹🏻 🦹🏻‍♂️ 🦹🏻‍♀️ 🧙🏻 🧙🏻‍♂️ 🧙🏻‍♀️ 🧚🏻 🧚🏻‍♂️ 🧚🏻‍♀️ 🧛🏻 🧛🏻‍♂️ 🧛🏻‍♀️ 🧜🏻 🧜🏻‍♂️ 🧜🏻‍♀️ 🧝🏻 🧝🏻‍♂️ 🧝🏻‍♀️ 💆🏻 💆🏻‍♂️ 💆🏻‍♀️ 💇🏻 💇🏻‍♂️ 💇🏻‍♀️ 🚶🏻 🚶🏻‍♂️ 🚶🏻‍♀️ 🧍🏻 🧍🏻‍♂️ 🧍🏻‍♀️ 🧎🏻 🧎🏻‍♂️ 🧎🏻‍♀️ 🧑🏻‍🦯 👨🏻‍🦯 👩🏻‍🦯 🧑🏻‍🦼 👨🏻‍🦼 👩🏻‍🦼 🧑🏻‍🦽 👨🏻‍🦽 👩🏻‍🦽 🏃🏻 🏃🏻‍♂️ 🏃🏻‍♀️ 💃🏻 🕺🏻 🕴🏻 🧖🏻 🧖🏻‍♂️ 🧖🏻‍♀️ 🧗🏻 🧗🏻‍♂️ 🧗🏻‍♀️ 🏇🏻 🏂🏻 🏌🏻 🏌🏻‍♂️ 🏌🏻‍♀️ 🏄🏻 🏄🏻‍♂️ 🏄🏻‍♀️ 🚣🏻 🚣🏻‍♂️ 🚣🏻‍♀️ 🏊🏻 🏊🏻‍♂️ 🏊🏻‍♀️ ⛹🏻 ⛹🏻‍♂️ ⛹🏻‍♀️ 🏋🏻 🏋🏻‍♂️ 🏋🏻‍♀️ 🚴🏻 🚴🏻‍♂️ 🚴🏻‍♀️ 🚵🏻 🚵🏻‍♂️ 🚵🏻‍♀️ 🤸🏻 🤸🏻‍♂️ 🤸🏻‍♀️ 🤽🏻 🤽🏻‍♂️ 🤽🏻‍♀️ 🤾🏻 🤾🏻‍♂️ 🤾🏻‍♀️ 🤹🏻 🤹🏻‍♂️ 🤹🏻‍♀️ 🧘🏻 🧘🏻‍♂️ 🧘🏻‍♀️ 🛀🏻 🛌🏻 🧑🏻‍🤝‍🧑🏻 👬🏻 👭🏻 👫🏻)

  local RANDOM_f=$$$(date +%s)
  local selected_emoji_f=${emojis_f[$RANDOM_f % ${#emojis_f[@]} ][1]}
  
  local RANDOM_s=$$$(date +%s)
  local selected_emoji_s=${emojis_s[$RANDOM_s % ${#emojis_s[@]} ][1]}
  
  echo $selected_emoji_f$selected_emoji_s
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_FINISHER"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"

  printf "\n"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user (who am I)
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then #**************8
    prompt_segment magenta white $USER # "%(!.%{%F{yellow}%}.)$USER@%m " ************
  fi
}

# Git: branch/detached head, dirty status **************
prompt_git() {
  local color ref
  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules)"
  }
  ref="$vcs_info_msg_0_"
  if [[ -n "$ref" ]]; then
    if is_dirty; then
      color=red
      ref="${ref} $PLUSMINUS"
    else
      color=green
      ref="${ref} "
    fi
    if [[ "${ref/.../}" == "$ref" ]]; then
      ref="$BRANCH $ref"
    else
      ref="$DETACHED ${ref/.../}"
    fi
    prompt_segment $color white "$ref"
    snd_prompt_end_flag=true
  fi
}

# Dir: current working directory
prompt_dir() {
  dir=`echo "${PWD//*$USER/}"`
  slash_num=`tr -dc '/' <<<"$dir" | awk '{ print length; }'`
  
  if [[ $slash_num -gt 2 ]]; then
    first_section=`echo $dir | cut -d'/' -f 1,2`
    last_section_index=`echo $slash_num + 1 | bc`
    last_section=`echo $dir | cut -d'/' -f $last_section_index`
    dir=`echo "$first_section/.../$last_section"`
  fi

  prompt_segment cyan black "~$dir "
}

# Display current virtual environment
prompt_virtualenv() {
  if [[ -n $VIRTUAL_ENV ]]; then
    prompt_segment yellow white
    print -Pn "$(basename $VIRTUAL_ENV) "
    if [ $snd_prompt_end_flag = false ]; then 
      snd_prompt_end_flag=true
    fi
  fi
}

## Main prompt
prompt_agnoster_main() {
  RETVAL=$?
  CURRENT_BG='NONE'
  prompt_upper_line
  prompt_time
  prompt_context
  prompt_dir
  prompt_end
  prompt_git
  prompt_virtualenv
  if [ "$snd_prompt_end_flag" = true ]; then
    prompt_end
  fi
  prompt_lower_line
  prompt_emoji
}

prompt_agnoster_precmd() {
  vcs_info
  PROMPT='%{%f%b%k%}$(prompt_agnoster_main) '
}

prompt_agnoster_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  add-zsh-hook precmd prompt_agnoster_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_agnoster_setup "$@"
