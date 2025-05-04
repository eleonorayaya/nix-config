1. Install nix package manager via Lix. Answer Y to both prompts.

   ```
   curl -sSf -L https://install.lix.systems/lix | sh -s -- install --nix-build-group-id 30000
   ```

2. Source the nix profile

   ```
   . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
   ```

3. Create the nix-darwin configuration directory

   ```
   sudo mkdir -p /etc/nix-darwin
   sudo chown $(id -nu):$(id -ng) /etc/nix-darwin
   ```

4. Clone the nix-darwin repository

   ```
   git clone git@github.com:eleonorayaya/nix-config.git /etc/nix-darwin
   ```

5. Apply the configuration

   ```
   nix run nix-darwin/nix-darwin-24.11#darwin-rebuild -- switch
   ```
