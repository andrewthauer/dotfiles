#
# Initialize docker environment
#

# shellcheck disable=SC2142

if ! command_exists "docker"; then
  return 1
fi

#
# Aliases
#

alias dk='docker'

# General
alias dprune='docker system prune'

# Registry
alias di-tags='docker-tags $*'

# Images
alias di='docker images'
alias diprune='docker images prune'
alias dbuild='docker build'
alias dhist='docker history'
alias dpull='docker pull'
alias dpull_all='docker images --format "{{.Repository}}:{{.Tag}}" | grep ':latest' | xargs -L1 docker pull'
alias drmi='docker rmi'
alias drmi_all='docker rmi $* $(docker images -a -q)'
alias drmi_dang='docker rmi $* $(docker images -q -f dangling=true)'
alias drmi_tags='docker-rmi-all-tags'

# Containers
alias dls='docker ps -a'
alias dps='docker ps'
alias dstart='docker start $*'
alias dstop='docker stop $*'
alias dstop_all='docker stop $* $(docker ps -q -f status=running)'
alias drestart='docker restart $*'
alias dattach='docker attach $*'
alias dexec='docker exec'
alias dexeci='docker exec -it $*'
alias drun='docker run $*'
alias drunit='docker run -it $*'
alias dinspect='docker inspect $*'
alias dlogs='docker logs'
alias dip='docker inspect --format="{{.NetworkSettings.IPAddress}}" $*'
alias drm='docker rm'
alias drm_stopped='docker rm -v $* $(docker ps -q -f status=exited)'
alias drm_all='docker rm -v $* $(docker ps -a -q)'
alias dcp='docker container prune'

# Volumes
alias dvc='docker volume create'
alias dvcp='docker volume create --label retention-policy=persistent $*'
alias dvls='docker volume ls $*'
alias dvlsa='docker volume ls --format "{{.Name}}: {{.Driver}} {{.Labels}}:"'
alias dvrm='docker volume rm $*'
alias dvp='docker volume prune'
alias dvi='docker volume inspect'
alias dvrm_clean='docker volume ls -q -f dangling=true | grep -x ".\{64,64\}" | xargs docker volume rm'
# alias dvrm_all='docker volume rm $(docker volume ls -q)'
# alias dvrm_all='docker volume ls -q | xargs docker volume rm'
# alias dvrm_dang='docker volume rm $(docker volume ls -q -f dangling=true)'
# alias dvrm_dang='docker volume ls -q -f dangling=true | docker volume rm'

# docker compose
alias dco='docker compose'
alias dcb='docker compose build'
alias dcexec='docker compose exec'
alias dcps='docker compose ps'
alias dcpull='docker compose pull'
alias dcr='docker compose run --rm'
alias dcrs='docker compose run --rm --service-ports'
alias dcrm='docker compose rm'
alias dcstart='docker compose start'
alias dcstop='docker compose stop'
alias dcrestart='docker compose restart'
alias dcup='docker compose up'
alias dcupd='docker compose up -d'
alias dcdown='docker compose down'
alias dclogs='docker compose logs'
alias dclogsf='docker compose logs -f'
alias dctail='docker compose logs --tail=all -f'

#
# Remove all tags for image name
#
# usage:
#   docker_rmi_all_tags my_image
#
function docker_rmi_all_tags() {
  docker images | grep "$1" | awk '{system("docker rmi " "'"$1:"'" $2)}'
}
