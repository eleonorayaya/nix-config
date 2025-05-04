Install nix package manager via Lix. Answer Y to both prompts.

```
curl -sSf -L https://install.lix.systems/lix | sh -s -- install --nix-build-group-id 30000
```

Source the nix profile

```
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```
