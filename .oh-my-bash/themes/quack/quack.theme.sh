#! bash oh-my-bash.module

function set_custom_colors() {
   dark_grey="\[$(tput setaf 8)\]"
   dark_purple="\[$(tput setaf 104)\]"
}

# BASED ON PURITY AND BINARYANOMALY THEME 
SCM_THEME_PROMPT_DIRTY=" ${_omb_prompt_bold_brown}⊘${_omb_prompt_normal}"
SCM_THEME_PROMPT_CLEAN=" ${_omb_prompt_bold_green}✓${_omb_prompt_normal}"
SCM_THEME_PROMPT_PREFIX="${_omb_prompt_reset_color}( "
SCM_THEME_PROMPT_SUFFIX=" ${_omb_prompt_reset_color})"

GIT_THEME_PROMPT_DIRTY=" ${_omb_prompt_bold_brown}⊘${_omb_prompt_normal}"
GIT_THEME_PROMPT_CLEAN=" ${_omb_prompt_bold_green}✓${_omb_prompt_normal}"
GIT_THEME_PROMPT_PREFIX="${_omb_prompt_reset_color}( "
GIT_THEME_PROMPT_SUFFIX=" ${_omb_prompt_reset_color})"
OMB_PROMPT_VIRTUALENV_FORMAT="%s »"
OMB_PROMPT_SHOW_PYTHON_VENV=${OMB_PROMPT_SHOW_PYTHON_VENV:=true}


OMB_THEME_PURITY_STATUS_BAD="${_omb_prompt_brown}❯${_omb_prompt_reset_color}${_omb_prompt_normal} "
OMB_THEME_PURITY_STATUS_OK="${_omb_prompt_green}❯${_omb_prompt_reset_color}${_omb_prompt_normal} "
_omb_deprecate_declare 20000 STATUS_THEME_PROMPT_BAD OMB_THEME_PURITY_STATUS_BAD sync
_omb_deprecate_declare 20000 STATUS_THEME_PROMPT_OK  OMB_THEME_PURITY_STATUS_OK  sync


# Set different host color for local and remote sessions
function set_host_color() {
  # Detect if connection is through SSH
  if [[ ! -z $SSH_CLIENT ]]; then
    printf "${lime_yellow}"
  else
    printf "${light_orange}"
  fi
}


# Set different username color for users and root
function set_user_color() {
  case $(id -u) in
    0)
      printf "${_omb_prompt_brown}"
      ;;
    *)
      printf "${_omb_prompt_teal}"
      ;;
  esac
}


function __ps_time {
   echo "$(clock_prompt)${_omb_prompt_normal}"
}

function _omb_theme_PROMPT_COMMAND {
  if (($? == 0)); then
    local ret_status=${STATUS_THEME_PROMPT_OK:-${OMB_THEME_PURITY_STATUS_OK-}}
    local status_code=""
  else
    local ret_status=${STATUS_THEME_PROMPT_BAD:-${OMB_THEME_PURITY_STATUS_BAD-}}
    local status_code="${_omb_prompt_brown}[\$?]"
  fi
  ps_username="$(set_user_color)\u${_omb_prompt_normal}"
  ps_uh_separator="${dark_purple}@${_omb_prompt_normal}"
  ps_virtualenv="${dark_purple}$(_omb_prompt_print_python_venv)${_omb_prompt_normal} "

  local hostn="\h"
  if [[ "$HOSTNAME" == "quack" ]]; then hostn="🦆"; fi
  if [[ "$HOSTNAME" == "Superball" ]]; then hostn="🔮"; fi
  if [[ "$HOSTNAME" == "frog" ]]; then hostn="🐸"; fi
	
  rightprompt() {
     printf "\n%*s"  $COLUMNS "${status_code}"
  }

 ps_hostname="$(set_host_color)${hostn}${_omb_prompt_normal}"
 PS1="\[$(tput sc; rightprompt; tput rc)\]\n$(__ps_time) ${_omb_prompt_navy}\w $(scm_prompt_info)\n${ps_virtualenv}${ps_username}${ps_uh_separator}${ps_hostname} ${ret_status}"
}


# initialize custom colors
set_custom_colors
THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"$dark_grey"}

_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND
