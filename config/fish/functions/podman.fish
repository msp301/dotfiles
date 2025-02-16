function podman --wraps=podman-remote --description 'alias podman-remote podman'
  podman-remote $argv
end
