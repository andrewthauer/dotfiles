# shellcheck disable=SC2142

#
# Aliases
#

alias dk="docker"

# General
alias dprune="docker system prune"

# Images
alias di="docker images"
alias diprune="docker images prune"
alias dbuild="docker build"
alias dhist="docker history"
alias dpull="docker pull"
alias dpull_all="docker images --format '{{.Repository}}:{{.Tag}}' | grep ':latest' | xargs -L1 docker pull"
alias drmi="docker image rm"
alias drmi_all="docker images -a -q | xargs docker image rm"
alias drmi_dang="docker images -q -f dangling=true | xargs docker image rm"
alias drmi_tags="docker-rmi-all-tags"

# Containers
alias dls="docker ps -a"
alias dps="docker ps"
alias dstart="docker start"
alias dstop="docker stop"
alias dstop_all="docker ps -q -f status=running | xargs docker stop"
alias drestart="docker restart"
alias dattach="docker attach"
alias dexec="docker exec"
alias dexeci="docker exec -it"
alias drun="docker run"
alias drunit="docker run -it"
alias dinspect="docker inspect"
alias dlogs="docker logs"
alias dip="docker inspect --format='{{.NetworkSettings.IPAddress}}'"
alias drm="docker rm"
alias drm_stopped="docker ps -q -f status=exited | xargs docker rm -v"
alias drm_all="docker ps -a -q | xargs docker rm -v"
alias dcp="docker container prune"

# Volumes
alias dvc="docker volume create"
alias dvcp="docker volume create --label retention-policy=persistent"
alias dvls="docker volume ls"
alias dvlsa="docker volume ls --format '{{.Name}}: {{.Driver}} {{.Labels}}:'"
alias dvrm="docker volume rm"
alias dvp="docker volume prune"
alias dvi="docker volume inspect"
alias dvrm_clean="docker volume ls -q -f dangling=true | grep -x '.{64,64}' | xargs docker volume rm"
alias dvrm_all="docker volume ls -q | xargs docker volume rm"
alias dvrm_dang="docker volume ls -q -f dangling=true | xargs docker volume rm"

# docker compose
alias dco="docker compose"
alias dcb="docker compose build"
alias dcexec="docker compose exec"
alias dcps="docker compose ps"
alias dcpull="docker compose pull"
alias dcr="docker compose run --rm"
alias dcrs="docker compose run --rm --service-ports"
alias dcrm="docker compose rm"
alias dcstart="docker compose start"
alias dcstop="docker compose stop"
alias dcrestart="docker compose restart"
alias dcup="docker compose up"
alias dcupd="docker compose up -d"
alias dcdown="docker compose down"
alias dclogs="docker compose logs"
alias dclogsf="docker compose logs -f"
alias dctail="docker compose logs --tail=all -f"
