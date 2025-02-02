#
# From https://github.com/NixOS/nix/pull/10439
#
export-env {
    # Only execute this file once per shell.
    if ('__ETC_PROFILE_NIX_SOURCED' not-in $env) {
        mut NIX_LINK = [$env.HOME '.nix-profile'] | path join;
        mut NIX_LINK_NEW = [$env.HOME '.local/state/nix/profile'];
        if 'XDG_STATE_HOME' in $env {
            $NIX_LINK_NEW = [$env.XDG_STATE_HOME 'nix/profile'];
        }
        $NIX_LINK_NEW = ($NIX_LINK_NEW | path join);
        if ($NIX_LINK_NEW | path exists) {
            $NIX_LINK = $NIX_LINK_NEW;
        }

        # NOTE: This might vary per system
        let localstatedir = '/nix/var';

        let NIX_PROFILES = ([$'($localstatedir)/nix/profiles/default' $NIX_LINK] | str join ' ');

        # Populate bash completions, .desktop files, etc
        mut XDG_DATA_DIRS = '';
        if 'XDG_DATA_DIRS' not-in $env {
            # According to XDG spec the default is /usr/local/share:/usr/share, don't set something that prevents that default
            $XDG_DATA_DIRS = (['/usr/local/share' '/usr/share'] | str join (char esep));
        }
        $XDG_DATA_DIRS = (
            $XDG_DATA_DIRS
            | split row (char esep)
            | append ([$NIX_LINK 'share'] | path join)
            | append '/nix/var/nix/profiles/default/share'
            | str join (char esep)
        );

        # Set $NIX_SSL_CERT_FILE so that Nixpkgs applications like curl work.
        mut NIX_SSL_CERT_FILE = '';
        if ('NIX_SSL_CERT_FILE' in $env) {
            # Allow users to override the NIX_SSL_CERT_FILE
        } else if ('/etc/ssl/certs/ca-certificates.crt' | path exists) { # NixOS, Ubuntu, Debian, Gentoo, Arch
            $NIX_SSL_CERT_FILE = '/etc/ssl/certs/ca-certificates.crt';
        } else if ('/etc/ssl/ca-bundle.pem' | path exists) { # openSUSE Tumbleweed
            $NIX_SSL_CERT_FILE = '/etc/ssl/ca-bundle.pem';
        } else if ('/etc/ssl/certs/ca-bundle.crt' | path exists) { # Old NixOS
            $NIX_SSL_CERT_FILE = '/etc/ssl/certs/ca-bundle.crt';
        } else if ('/etc/pki/tls/certs/ca-bundle.crt' | path exists) { # Fedora, CentOS
            $NIX_SSL_CERT_FILE = '/etc/pki/tls/certs/ca-bundle.crt';
        } else {
            # Fall back to what is in the nix profiles, favouring whatever is defined last.
            let last = $NIX_PROFILES
                | split row (char space)
                | where ([$it 'etc/ssl/certs/ca-bundle.crt'] | path join | path exists)
                | last;

            $NIX_SSL_CERT_FILE = ([$last 'etc/ssl/certs/ca-bundle.crt'] | path join);
        }

        $env.NIX_PROFILES = $NIX_PROFILES
        $env.XDG_DATA_DIRS = $XDG_DATA_DIRS
        $env.NIX_SSL_CERT_FILE = $NIX_SSL_CERT_FILE
        $env.PATH = ($env.PATH | prepend $'($localstatedir)/nix/profiles/default/bin' | prepend ([$NIX_LINK 'bin'] | path join));
    }

    $env.__ETC_PROFILE_NIX_SOURCED = 1;
}
