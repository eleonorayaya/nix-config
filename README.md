## Install

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

## Updating

To reload the configuration, run

```
darwin-rebuild switch
```

## Development

To format the code, run

```
nix fmt
```

## Wallpapers

 - [cozy-autumn-rain by genevievelacroix](https://www.genevievelacroix.com/)
 - [miami-vibes by genevievelacroix](https://www.genevievelacroix.com/)
 - [night-ramen-shop by endlesstakeout](https://www.endlesstakeout.com/)


## Docs Links

### Nix
 - [Nix Packages](https://search.nixos.org/packages)

### home-manager
 - [Config options](https://home-manager.dev/manual/24.11/options.xhtml)

### sketchybar
 - [Configuration](https://felixkratz.github.io/SketchyBar/config/items#geometry-properties)

### Neovim
 - [Nixvim Docs](https://nix-community.github.io/nixvim/24.11/)
 - [Nixvim Github](https://github.com/nix-community/nixvim/blob/nixos-24.11/)

#### Autosession
 - [Github](https://github.com/rmagatti/auto-session/)

#### Harpoon
 - [Github](https://github.com/ThePrimeagen/harpoon/tree/harpoon2)
 - [Nixvim github](https://github.com/nix-community/nixvim/blob/nixos-24.11/plugins/by-name/harpoon/default.nix)

#### Lualine (Statusbar)
 - [Docs](https://github.com/nvim-lualine/lualine.nvim/tree/master)

#### Grug-Far
 - [Docs](https://github.com/MagicDuck/grug-far.nvim)

### Rose Pine
 - [Plugins](https://rosepinetheme.com/themes/)


## Debugging

### Sketchybar

To see sketchybar logs run
```
sudo launchctl debug gui/501/org.nixos.sketchybar --stdout --stderr
```

then in a separate terminal window restart sketchybar with 

```
sudo launchctl kill 9 gui/501/org.nixos.sketchybar
```
