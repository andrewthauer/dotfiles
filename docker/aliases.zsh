#
# Docker related aliases
#

#
# docker
#

alias dk="docker"

# Images
alias di="docker images"
alias dbu="docker build"
alias drmi="docker rmi"
alias drmi_all="docker rmi $* $(docker images -a -q)"
alias drmi_dang='docker rmi $* $(docker images -q -f "dangling=true")'

# Containers
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dpss='docker ps -a --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}"'
alias dpsl="docker ps -l $*"
alias dstart="docker start $*"
alias dstop="docker stop $*"
alias dstop_all='docker stop $* $(docker ps -q -f "status=running")'
alias drestart="docker restart $*"
alias dattach="docker attach $*"
alias dexec="docker exec"
alias drun="docker run $*"
alias drunr="docker run --rm $*"
alias drunit="docker run --rm -it $*"
alias dinspect="docker inspect $*"
alias dlog="docker logs"
alias dip='docker inspect --format "{{ .NetworkSettings.IPAddress }}" $*'
alias drm="docker rm"
alias drm_stopped='docker rm $* $(docker ps -q -f "status=exited")'
alias drm_all="docker rm $* $(docker ps -a -q)"
alias drmv_stopped='docker rm -v $* $(docker ps -q -f "status=exited")'
alias drmv_all="docker rm -v $* $(docker ps -a -q)"

# Volumes
alias dvls="docker volume ls $*"
alias dvrm="docker volume rm $*"
alias dvrm_all="docker volume rm $(docker volume ls -q)"
alias dvrm_dang='docker volume rm $(docker volume ls -q -f "dangling=true")'

#
# docker-compose
#

# Commands
alias dco="docker-compose"
alias dcb="docker-compose build"
alias dce="docker-compose exec"
alias dcps="docker-compose ps"
alias dcr="docker-compose run --rm"
alias dcrsp="docker-compose run --rm --service-ports"
alias dcrm="docker-compose rm"
alias dcstart="docker-compose start"
alias dcstop="docker-compose stop"
alias dcrestart="docker-compose restart"
alias dcup="docker-compose up"
alias dcupd="docker-compose up -d"
alias dcdn="docker-compose down"
alias dcl="docker-compose logs"
alias dclf="docker-compose logs -f"

# TODO: Read .env file for default service name (i.e. DEFAULT_SERVICE=web)
alias dcrs="docker-compose run --rm --service-ports web"

# Special helpers
alias dctail="docker-compose logs --tail=all -f"

#
# docker-sync (docker-sync.io)
#

alias dsync="docker-sync"
alias dsyncs="docker-sync start"
alias dsyncsst="docker-sync-stack"
