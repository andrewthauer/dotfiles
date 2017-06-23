# Docker zsh functions & aliases

# =====================================
# docker
# ====================================

# Images
alias di='docker images'
alias drmi='docker rmi'
alias dbu='docker build'
alias drmi_all='docker rmi $* $(docker images -a -q)'
alias drmi_dang='docker rmi $* $(docker images -q -f "dangling=true")'

# Containers
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dpsl='docker ps -l $*'
alias drm='docker rm'
alias dexec='docker exec'
alias drun"docker run $*"
alias dinspect="docker inspect $*"
alias dlog='docker logs'
alias dip='docker inspect --format "{{ .NetworkSettings.IPAddress }}" $*'
alias dstart="docker start $*"
alias dstop="docker stop $*"
alias dattach="docker attach $*"
alias dstop_all='docker stop $* $(docker ps -q -f "status=running")'
alias drm_stopped='docker rm $* $(docker ps -q -f "status=exited")'
alias drmv_stopped='docker rm -v $* $(docker ps -q -f "status=exited")'
alias drm_all='docker rm $* $(docker ps -a -q)'
alias drmv_all='docker rm -v $* $(docker ps -a -q)'

# Volumes
alias dvls='docker volume ls $*'
alias dvrm_all='docker volume rm $(docker volume ls -q)'
alias dvrm_dang='docker volume rm $(docker volume ls -q -f "dangling=true")'

# =====================================
# docker-compose
# =====================================

# Use dco as alias for docker-compose, since dc on *nix is 'dc - an arbitrary precision calculator'
# https://www.gnu.org/software/bc/manual/dc-1.05/html_mono/dc.html

# aliases from oh-my-zsh/plugins/docker-compose
alias dco='docker-compose'
alias dcb='docker-compose build'
alias dce='docker-compose exec'
alias dcps='docker-compose ps'
alias dcrestart='docker-compose restart'
alias dcrm='docker-compose rm'
alias dcr='docker-compose run'
alias dcstop='docker-compose stop'
alias dcup='docker-compose up'
alias dcdn='docker-compose down'
alias dcl='docker-compose logs'
alias dclf='docker-compose logs -f'

# custom aliases
alias dcrestart='docker-compose restart'
alias dcstart='docker-compose start'
alias dcstop='docker-compose stop'

# =====================================
# docker-sync (docker-sync.io)
# =====================================

alias dks='docker-sync'
alias dkss='docker-sync-stack'
