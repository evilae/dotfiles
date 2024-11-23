# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
#  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;

  networking.hostName = "evilai"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  nixpkgs.config.allowUnfree = true;
  boot.supportedFilesystems = [ "btrfs" "ext2" "ext3" "ext4" "exfat" "f2fs" "fat8" "fat16" "fat32" "ntfs" "xfs" ];
  programs.fish.enable = true;
  services.tailscale.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  security.polkit.enable = true;
  services.flatpak.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true; 
  programs.hyprland.systemd.setPath.enable = true;  
  programs.hyprland.portalPackage = pkgs.xdg-desktop-portal;  
  services.hypridle.enable = true;  
  services.displayManager.sddm.enable = true;
  programs.hyprlock.enable = true; 
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";  # Prevent hardware cursor issues
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";  # Use NVIDIA's GLX implementation
  };
  system.stateVersion = "24.05";
  systemd = {
  user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };
 };
  services.openssh = {
  enable = true;
  ports = [ 22 8022 ];
  settings = {
    PasswordAuthentication = true;
    AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
    UseDns = true;
    X11Forwarding = false;
    PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
  };
};
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.evilae = {
    isNormalUser = true;
    description = "evilae";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

    #sound.enable = true;

  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  nixpkgs.config.qt5 = {
  enable = true;
  platformTheme = "qt5ct"; 
    style = {
      package = pkgs.utterly-nord-plasma;
      name = "Utterly Nord Plasma";
    };
 };


    # Enable OpenGL
  hardware.graphics.enable = true;

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  nixpkgs.config.packageOverrides = pkgs: {
    wallhaven-cli = pkgs.callPackage /home/evilae/nix-builds/default-wallhaven-cli.nix { };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  wget
  njam
  ninvaders
  nix-prefetch-git
  i3
  wallhaven-cli
  kitty
  gowall
  polybar
  git
  feh
  fuzzel
  waybar
  pyenv
  hyprland
  nim
  vscode
  wofi
  zed-editor
  libnotify
  lsd
  eza
  bat
  firefox
  python312Packages.pip
  obs-studio
  ffmpeg
  hyprlock
  hyprpaper
  _2048-cli
  wpaperd
  steam
  protonup-qt
  pywal
  cava
  xorg.xev
  fzf
  chafa
  neovim
  rofi
  jftui
  jellyfin-media-player
  jftui
  qbittorrent
  fish
  pipx
  swaylock
  okular
  hyprlock
  clipse
  wlogout
  dunst
  blueberry
  hyprls
  thunderbird
  wl-clipboard
  binutils
  audacious
  libsForQt5.qtstyleplugin-kvantum
  libsForQt5.qt5ct
  catppuccin-cursors
  grim
  discord
  slurp
  rhythmbox
  swww
  gzip
  rustplayer
  gay
  pcre
  swaybg
  ncdu
  jmtpfs
  stow
  usbutils
  libargon2
  figlet
  cemu
  pipreqs
  polkit_gnome
  nerdfetch
  goreleaser
  blahaj
  xss-lock
  unrar
  ventoy
  nix-search-cli
  ueberzugpp
  xfce.thunar
  starship
  cmake
  gnumake
  lxappearance
  gvfs
  spaceFM
  xfce.thunar-volman
  lxqt.lxqt-policykit
  polkit
  nim_builder
  picom
  upscayl
  xscreensaver
  grub2
  moc
  os-prober
  pipewire
  gimp
  i3lock-color
  ntfs3g
  ripgrep
  rtkit
  ani-cli
  vesktop
  go
  poetry
  pipes
  pokemonsay
  xclip
  dolphin-emu
  zip
  yazi
  unzip
  python3
  xdotool
  mommy
  flameshot
  pipes-rs
  alacritty
  autotiling
  viu
  zscroll
  spotify
  playerctl
  spicetify-cli
  cmus
  ];

  fonts.packages = with pkgs; [
  nerdfonts
  noto-fonts
  noto-fonts-cjk-sans
  noto-fonts-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  mplus-outline-fonts.githubRelease
  dina-font
  proggyfonts
  font-awesome
];

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
  services.xserver = {
    enable = true;
   
    desktopManager = {
      xterm.enable = false;
    };
   
    displayManager = {
        defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
  };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # Did you read the comment?
}
