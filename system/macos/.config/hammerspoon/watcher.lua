-- --------------------------------------
-- Watcher to load the configuration in case of changes
-- --------------------------------------

function reloadConfig(files)
  hs.reload()
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.config/hammerspoon/", reloadConfig):start()
