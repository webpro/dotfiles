# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias -- -="cd -"                  # Go to previous dir with -

# Network
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ipl="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"

# Copy my public key to the pasteboard
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"

# GIT shortcuts
alias gca='git commit --amend'
alias gcaa='git commit --amend --no-edit'
alias gdd='git diff --cached'
alias gmff='git merge --ff-only'
alias gp='git pull'
alias gpu='git push'
alias gpff='git push --force'
alias grsh='git reset HEAD'
alias grshh='git reset --hard'
alias gs='git status'
alias gst='git stash'
alias gsta='git stash apply'
alias gconf='git grep "<<<<<<< HEAD"'
# List commits showing changed files
alias gls='git log --pretty=format:"%C(yellow)%h %C(green)(%ar) %Creset%s%Cblue [%cn]%Cred%d" --decorate -5'
# List commits in short form, with colors and branch/tag annotations.
alias gll='log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat -5'

# NPM shortcuts
alias npms='npm start'
alias npmd='npm run dev'
alias npmr='npm run'

# List all npm-linked packages
alias npmlinked='( ls -l node_modules ; ls -l node_modules/@* ) | grep ^l'

# Execute local node modules
alias npmexec='PATH=$(npm bin):$PATH'
alias npmlsg='npm list -g --depth 0'
alias nui='npx npm-check --update'

# Yarn shortcuts
alias yui='yarn upgrade-interactive'

# Docker shortcuts
alias d='docker'
alias dps='docker ps'
alias dcls='docker container ls -a'
alias di='docker image'
alias dils='docker image ls'
alias dv='docker volume'
alias dvls='docker volume ls'
alias dk='docker kill'
alias drm='docker remove'
alias drmf='docker remove --force'
alias dcu='docker-compose up'
alias dcr='docker-compose restart'
alias dcs='docker-compose stop'
