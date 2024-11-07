# Docker Compose Execのエイリアス
alias dce='docker compose exec'

# eza alias
alias ls='eza --icons'
alias ll='ls -alF'

# yarn & docker alias
alias dyl="dce web yarn lint --fix"

# Rails & docker alias
alias drub='dce web bundle exec rubocop -A'
alias drsp='dce web bundle exec rspec'
