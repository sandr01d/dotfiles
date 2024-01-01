# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## zsh options
setopt correct                                                  # Auto correct mistakes
setopt hashlistall                                              # Hash the entire path before command completion or corrections. Prevents false reports of spelling errors.
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt share_history                                            # Share history between multiple running instances
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.

# Completions
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "$\{(s.:.)$(dircolors)}"     # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' menu select                              # Show which entry of the completions is selected
# Speed up completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# History
HISTFILE=~/.zhistory
HISTSIZE=2500
SAVEHIST=3000
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

## Keybindings
bindkey '^A'	beginning-of-line				# Ctrl-a
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^E'	end-of-line					# Ctrl-e
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                      # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word
bindkey '^[Od' backward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[3;5~' kill-word				                              # delete next world with ctrl+delete
bindkey '^[[Z' undo                                             # Shift+tab undo last action

# Functions
function dsf() {
  diff -u "$1" "$2" | diff-so-fancy
}
# Travel up n directories
function u() {
  for _ in {1.."$1"}
  do
    cd ..
  done
}

# Aliases
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias q="exit"
alias ls="ls -lh --color"					                              # ls output as list with human-readable sizes and color
alias cls="clear"
alias grep='grep --color=auto'					                        # Color grep output
alias gp='git pull'
alias gP='git push'
alias gf='git fetch'
alias gS='git status'
alias gc='git commit'
alias gr='git reset'
alias gpp='git pull && git push'
alias diff='diff --color=auto'					                        # Color diff output
alias code='vscodium'
alias xc='xclip -selection clipboard'

## Environment Variables
export EDITOR=nvim
ARROW=$'\xe2\x9d\xaf\x0a'
export FZF_DEFAULT_OPTS=\
"--cycle \
--prompt=$ARROW \
--pointer=$ARROW \
--marker=$ARROW"
# Use delta with pacdiff
export DIFFPROG='delta --diff-so-fancy'

## Plugins
# Use syntax highlighting
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  echo 'zsh-syntax-highlighting not found'
fi

# zoxide
eval "$(zoxide init zsh)"

# nnn
# cd on quit (^G)
if [ -f /usr/share/nnn/quitcd/quitcd.bash_zsh ]; then
    source /usr/share/nnn/quitcd/quitcd.bash_zsh
fi
# configure plugins
export NNN_PLUG='z:autojump;o:fzopen;c:fzcd;l:launch'

# Use fzf completion
if [ -f /usr/share/fzf/completion.zsh ]; then
  source /usr/share/fzf/completion.zsh
elif [ -f /usr/share/doc/fzf/examples/completion.zsh ]; then
  source /usr/share/doc/fzf/examples/completion.zsh
else
  echo 'fzf completion not found'
fi
# Use fzf key bindings
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
elif [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
else
 echo 'fzf key bindings not found'
fi

# Use autosuggestion
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
else
  echo 'zsh-autosuggestions not found'
fi
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
bindkey '^@'    autosuggest-accept                              # Ctrl+Space
bindkey '^[^M'  autosuggest-execute                             # Alt+Enter
bindkey '^['    autosuggest-clear                               # Escape key

# Use powerlevel10k theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Use git-extras completions
source /usr/share/doc/git-extras/git-extras-completion.zsh

# Use forgit git plugin
if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
  export FORGIT_COPY_CMD='wl-copy'
else
  export FORGIT_COPY_CMD='xclip -selection clipboard'
fi
export FORGIT_CHECKOUT_BRANCH_BRANCH_GIT_OPTS='--all --sort=-committerdate'
source /usr/share/zsh/plugins/forgit-git/forgit.plugin.zsh
source /usr/share/zsh/plugins/forgit-git/completions/git-forgit.zsh

# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# Bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Add packages installed with cargo to PATH
export PATH="$HOME/.cargo/bin:$PATH"
