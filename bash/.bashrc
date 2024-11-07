# Load bash aliases if they exist
if [ -f "$HOME/.bash_aliases" ]; then
    source "$HOME/.bash_aliases"
fi

# openssl
OPENSSL_DIR="/usr/local/opt/openssl@1.0"
export PATH="$OPENSSL_DIR/bin:$PATH"
export LDFLAGS="-L$OPENSSL_DIR/lib"
export CPPFLAGS="-I$OPENSSL_DIR/include"
export PKG_CONFIG_PATH="$OPENSSL_DIR/lib/pkgconfig"

# Git completion and prompt
if [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
    source /usr/local/etc/bash_completion.d/git-prompt.sh
fi
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    source /usr/local/etc/bash_completion.d/git-completion.bash
fi

# Google Cloud SDK
GCS_SDK_DIR="/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
if [ -d "$GCS_SDK_DIR" ]; then
    source "$GCS_SDK_DIR/completion.bash.inc"
    source "$GCS_SDK_DIR/path.bash.inc"
fi

# Bash completion via Homebrew
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# Java
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"

# Brew environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# Go environment
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"

# AWS profile
export AWS_PROFILE="default"

# Starship prompt
eval "$(starship init bash)"

# broot
if command -v broot &> /dev/null; then
    if [ -f "$HOME/.config/broot/launcher/bash/br" ]; then
        source "$HOME/.config/broot/launcher/bash/br"
    fi
fi

# skim
function skcd() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | sk) && cd "$dir"
}

# zoxide
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash --cmd z)"
fi

# zoxide fuzzy finder use sk
function __zoxide_zi() {
    \builtin local result
    result="$( \
        zoxide query -ls -- "$@" \
        | sk \
            --delimiter='[^\t\n ][\t\n ]+' \
            -n2.. \
            --no-sort \
            --keep-right \
            --height='40%' \
            --layout='reverse' \
            --exit-0 \
            --select-1 \
            --bind='ctrl-z:ignore' \
            --preview='\command -p ls -F --color=always {2..}' \
        ;
    )" \
        && __zoxide_cd "${result:7}"
}

# bat preview
function btprev() {
    fd | sk --preview 'bat --style=numbers --color=always --line-range :500 {}'
}

# direnv
eval "$(direnv hook bash)"
