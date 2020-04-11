# OpenVPN

## Usage

```sh
# looks for `~/.config/openvpn/profiles/[profile-name]/client.ovpn` directory.
vpn [profile-name]
```

To use with [Tunnelblick](https://tunnelblick.net/) place a `.env` file in the
vpn profile directory.

```sh
export USE_TUNNELBLICK=true
```
