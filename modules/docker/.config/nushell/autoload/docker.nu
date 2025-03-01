def "dk" [] { docker }

# General
def "dprune" [] { docker system prune }

# Registry
def "di-tags" [args: string] { docker-tags $args }

# Images
def "di" [] { docker images }
def "diprune" [] { docker images prune }
def "dbuild" [] { docker build }
def "dhist" [] { docker history }
def "dpull" [] { docker pull }
def "dpull_all" [] { docker images --format "{{.Repository}}:{{.Tag}}" | grep ':latest' | xargs -L1 docker pull }
def "drmi" [] { docker rmi }
def "drmi-all" [args: string] { docker rmi $args (docker images -a -q) }
def "drmi-dang" [args: string] { docker rmi $args (docker images -q -f dangling=true) }
def "drmi-tags" [] { docker-rmi-all-tags }

# Containers
def "dls" [] { docker ps -a }
def "dps" [] { docker ps }
def "dstart" [args: string] { docker start $args }
def "dstop" [args: string] { docker stop $args }
def "dstop-all" [args: string] { docker stop $args (docker ps -q -f status=running) }
def "drestart" [args: string] { docker restart $args }
def "dattach" [args: string] { docker attach $args }
def "dexec" [] { docker exec }
def "dexeci" [args: string] { docker exec -it $args }
def "drun" [args: string] { docker run $args }
def "drunit" [args: string] { docker run -it $args }
def "dinspect" [args: string] { docker inspect $args }
def "dlogs" [] { docker logs }
def "dip" [args: string] { docker inspect --format="{{.NetworkSettings.IPAddress}}" $args }
def "drm" [] { docker rm }
def "drm-stopped" [args: string] { docker rm -v $args (docker ps -q -f status=exited) }
def "drm-all" [args: string] { docker rm -v $args (docker ps -a -q) }
def "dcp" [] { docker container prune }

# Volumes
def "dvc" [] { docker volume create }
def "dvcp" [args: string] { docker volume create --label retention-policy=persistent $args }
def "dvls" [args: string] { docker volume ls $args }
def "dvlsa" [] { docker volume ls --format "{{.Name}}: {{.Driver}} {{.Labels}}:" }
def "dvrm" [args: string] { docker volume rm $args }
def "dvp" [] { docker volume prune }
def "dvi" [] { docker volume inspect }
def "dvrm-clean" [] {
    docker volume ls -q -f dangling=true | grep -x ".\{64,64\}" | xargs docker volume rm
}

# def "dvrm-all" [] { docker volume rm (docker volume ls -q) }
# def "dvrm-all" [] { docker volume ls -q | xargs docker volume rm }
# def "dvrm-dang" [] { docker volume rm (docker volume ls -q -f dangling=true) }
# def "dvrm-dang" [] { docker volume ls -q -f dangling=true | docker volume rm }

# docker compose
def "dco" [] { docker compose }
def "dcb" [] { docker compose build }
def "dcexec" [] { docker compose exec }
def "dcps" [] { docker compose ps }
def "dcpull" [] { docker compose pull }
def "dcr" [] { docker compose run --rm }
def "dcrs" [] { docker compose run --rm --service-ports }
def "dcrm" [] { docker compose rm }
def "dcstart" [] { docker compose start }
def "dcstop" [] { docker compose stop }
def "dcrestart" [] { docker compose restart }
def "dcup" [] { docker compose up }
def "dcupd" [] { docker compose up -d }
def "dcdown" [] { docker compose down }
def "dclogs" [] { docker compose logs }
def "dclogsf" [] { docker compose logs -f }
def "dctail" [] { docker compose logs --tail=all -f }
