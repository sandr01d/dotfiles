eval "$(starship init zsh)"

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
  [[ $1 =~ ^[0-9]+$ ]] || return 1
  for _ in {1.."$1"}
  do
    cd ..
  done
}

# Fetch a license from GitHub
function license() {
  local license
  license=$(gh api \
    -H "Accept: application/json" \
    -H "X-Github-Api-Version: 2022-11-28" \
    /licenses | jq -r ".[].key" | fzf)
  gh api \
    -H "Accept: application/json" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    /licenses/"$license" | jq -r .body
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Aliases
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias q="exit"
alias ll="eza --icons=always -l"
alias e="erd --human --icons --layout=inverted"
alias cls="clear"
alias grep='grep --color=auto'					                        # Color grep output
alias gp='git pull'
alias gP='git push'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gS='git status'
alias gc='git commit'
alias gr='git reset'
alias gpp='git pull && git push'
alias diff='diff --color=auto'					                        # Color diff output
alias hx='helix'
alias xc='wl-copy'
alias code='code --ozone-platform-hint=auto'
alias gcl='forgit::clean'

## Environment Variables
export EDITOR=helix
ARROW=$'\xe2\x9d\xaf\x0a'
export FZF_DEFAULT_OPTS=\
"--cycle \
--prompt=$ARROW \
--pointer=$ARROW \
--marker=$ARROW"
# Use delta with pacdiff
export DIFFPROG='delta --diff-so-fancy'
# Rootless docker
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

## Plugins
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zoxide
eval "$(zoxide init zsh)"
# Use fzf completion
source /usr/share/fzf/completion.zsh
# Use fzf key bindings
source /usr/share/fzf/key-bindings.zsh
# Use autosuggestion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
bindkey '^@'    autosuggest-accept                              # Ctrl+Space
bindkey '^[^M'  autosuggest-execute                             # Alt+Enter
bindkey '^['    autosuggest-clear                               # Escape key

# Use git-extras completions
source /usr/share/doc/git-extras/git-extras-completion.zsh
# Use forgit git plugin
export FORGIT_COPY_CMD='wl-copy'
export FORGIT_CHECKOUT_BRANCH_BRANCH_GIT_OPTS='--all --sort=-committerdate'
export FORGIT_BLAME_GIT_OPTS='--date=iso8601'
export FORGIT_DIR_VIEW='erd --human --icons --layout=inverted --color force'
source /usr/share/zsh/plugins/forgit-git/forgit.plugin.zsh

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
