{
  description = "Nix for NixOS, macOS, and RPi5 configurations";

  # the nixConfig here only affects the flake itself, not the system configuration!
  # nixConfig = {
  # substituters = [
  # Query the mirror of USTC first, and then the official cache.
  # "https://mirrors.ustc.edu.cn/nix-channels/store"
  # "https://cache.nixos.org"
  # ];
  # };

  # This is the standard format for flake.nix. `inputs` are the dependencies of the flake,
  # Each item in `inputs` will be passed as a parameter to the `outputs` function after being pulled and built.
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.11-darwin";
    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      # inputs.nixpkgs.follows = "nixpkgs-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    stylix.url = "github:danth/stylix/cf8b6e2d4e8aca8ef14b839a906ab5eb98b08561";
    flake-utils.url = "github:numtide/flake-utils";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    omarchy-nix = {
      url = "github:henrysipp/omarchy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  # The `outputs` function will return all the build results of the flake.
  # A flake can have many use cases and different types of outputs,
  # parameters in `outputs` are defined in `inputs` and can be referenced by their names.
  # However, `self` is an exception, this special parameter points to the `outputs` itself (self-reference)
  # The `@` syntax here is used to alias the attribute set of the inputs's parameter, making it convenient to use inside the function.
  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    darwin,
    home-manager,
    stylix,
    flake-utils,
    disko,
    zen-browser,
    omarchy-nix,
    ...
  }: let
    # Load local user configuration
    user = import ./user.nix;
    username = user.username;
    useremail = user.useremail;
    specialArgs =
      inputs
      // {
        inputs = inputs;
        inherit username useremail;
      };

    mkHome = homeModule: imports: [
      homeModule
      ({
        config,
        pkgs,
        ...
      }: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = specialArgs;
        home-manager.users.${username} = {imports = imports;};
        home-manager.backupFileExtension = "backup";
      })
    ];
  in {
    nixosConfigurations = {
      # Configuration for NixOS Desktop Alpha (x86_64-linux)
      alpha = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [
            ./hosts/alpha/configuration.nix
            stylix.nixosModules.stylix
            ./modules/stylix.nix
          ]
          ++ mkHome home-manager.nixosModules.home-manager [
            ./modules/home/linux-desktop.nix
            ./modules/home/linux-apps-x86_64.nix
          ];
      };

      # Configuration for NixOS Desktop Bravo (x86_64-linux)
      bravo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [
            ./hosts/bravo/configuration.nix
            stylix.nixosModules.stylix
            ./modules/stylix.nix
          ]
          ++ mkHome home-manager.nixosModules.home-manager [
            ./modules/home/linux-desktop.nix
            ./modules/home/linux-apps-x86_64.nix
          ];
      };

      # Configuration for NixOS on MacBookPro14,1 Charlie (x86_64-linux)
      charlie = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [
            ./hosts/charlie/configuration.nix
            stylix.nixosModules.stylix
            ./modules/stylix.nix
          ]
          ++ mkHome home-manager.nixosModules.home-manager [
            ./modules/home/linux-desktop.nix
            ./modules/home/linux-apps-x86_64.nix
          ];
      };

      # Configuration for NixOS on MacBookPro8,2 (x86_64-linux)
      golf = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [
            ./hosts/golf/configuration.nix
            stylix.nixosModules.stylix
            ./modules/stylix.nix
          ]
          ++ mkHome home-manager.nixosModules.home-manager [
            ./modules/home/linux-desktop.nix
            ./modules/home/linux-apps-x86_64.nix
          ];
      };

      # Configuration for NixOS Kilo on Beelink EQR5 (x86_64-linux)
      kilo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [
            ./hosts/kilo/configuration.nix
            stylix.nixosModules.stylix
            ./modules/stylix.nix
          ]
          ++ mkHome home-manager.nixosModules.home-manager [
            ./modules/home/linux-desktop.nix
            ./modules/home/linux-apps-x86_64.nix
          ];
      };

      # Configuration for NixOS Mike (x86_64-linux)
      mike = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [
            ./hosts/mike/configuration.nix
            stylix.nixosModules.stylix
            ./modules/stylix.nix
          ]
          ++ mkHome home-manager.nixosModules.home-manager [
            ./modules/home/linux-desktop.nix
            ./modules/home/linux-apps-x86_64.nix
          ];
      };

      # Configuration for NixOS November (x86_64-linux)
      november = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [
            ./hosts/november/configuration.nix
            stylix.nixosModules.stylix
            ./modules/stylix.nix
          ]
          ++ mkHome home-manager.nixosModules.home-manager [
            ./modules/home/linux-desktop.nix
            ./modules/home/linux-apps-x86_64.nix
          ];
      };

      # Configuration for NixOS Oscar (x86_64-linux)
      oscar = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [
            ./hosts/oscar/configuration.nix
            stylix.nixosModules.stylix
            ./modules/stylix.nix
          ]
          ++ mkHome home-manager.nixosModules.home-manager [
            ./modules/home/linux-desktop.nix
            ./modules/home/linux-apps-x86_64.nix
          ];
      };

      # Configuration for NixOS Papa (x86_64-linux)
      papa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [
            ./hosts/papa/configuration.nix
            stylix.nixosModules.stylix
            ./modules/stylix.nix
          ]
          ++ mkHome home-manager.nixosModules.home-manager [
            ./modules/home/linux-desktop.nix
            ./modules/home/linux-apps-x86_64.nix
          ];
      };

      # # Configuration for NixOS on Digital Ocean droplets (x86_64-linux)
      # hotel = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     ./hosts/hotel/configuration.nix
      #     ./modules/nixos/base.nix
      #     ./modules/nixos/docker.nix
      #     stylix.nixosModules.stylix
      #     ./modules/stylix.nix
      #     # make home-manager as a module of nixos
      #     # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
      #     home-manager.nixosModules.home-manager
      #     {
      #       home-manager.useGlobalPkgs = true;
      #       home-manager.useUserPackages = true;
      #       home-manager.users.budchris = {
      #         imports = [
      #           ./modules/home/linux.nix
      #         ];
      #       };
      #       # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
      #       home-manager.backupFileExtension = "backup";
      #     }
      #   ];
      # };

      # Configuration for Digital Ocean droplets
      digitalocean = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          [
            disko.nixosModules.disko
            {disko.devices.disk.disk1.device = "/dev/vda";}
            {
              # do not use DHCP, as DigitalOcean provisions IPs using cloud-init
              networking.useDHCP = nixpkgs.lib.mkForce false;

              services.cloud-init = {
                enable = true;
                network.enable = true;
              };
            }
            ./hosts/digitalocean/configuration.nix
            stylix.nixosModules.stylix
            ./modules/stylix.nix
          ]
          ++ mkHome home-manager.nixosModules.home-manager [
            ./modules/home/linux.nix
          ];
      };
    };

    darwinConfigurations = {
      # Configuration for 2017 13-inch MacBook Pro (two Thunderbolt 3 ports, MacBookPro14,1) Charlie (x86_64-darwin)
      charlie = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        specialArgs =
          specialArgs
          // {
            hostname = "charlie";
          };
        modules =
          [
            ./modules/darwin/nix-core.nix
            ./modules/darwin/system.nix
            ./modules/darwin/apps.nix
            # ./modules/homebrew-mirror.nix # comment this line if you don't need a homebrew mirror
            ./modules/darwin/host-users.nix
            stylix.darwinModules.stylix
            ./modules/stylix.nix
          ]
          ++ mkHome home-manager.darwinModules.home-manager [
            ./modules/home/darwin.nix
          ];
      };

      # Configuration for 2022 M2 MacBook Air (Mac14,2) Delta (aarch64-darwin)
      # Optimized for closed-clamshell desktop operation with external monitor
      delta = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs =
          specialArgs
          // {
            hostname = "delta";
          };
        modules =
          [
            ./modules/darwin/nix-core.nix
            ./modules/darwin/system.nix
            ./hosts/delta/desktop-configuration.nix  # Closed-clamshell desktop configuration
            ./modules/darwin/apps.nix
            ./modules/darwin/apps-aarch64.nix
            # ./modules/homebrew-mirror.nix # comment this line if you don't need a homebrew mirror
            ./modules/darwin/host-users.nix
            # stylix.darwinModules.stylix
            # ./modules/stylix.nix
          ]
          ++ mkHome home-manager.darwinModules.home-manager [
            ./modules/home/darwin.nix
          ]
          ++ [
            # Overlay to disable tests for dnspython
            {
              nixpkgs.overlays = [
                (self: super: {
                  python3Packages = super.python3Packages.override {
                    overrides = self: super: {
                      dnspython = super.dnspython.overrideAttrs (oldAttrs: {
                        doCheck = false;
                      });
                    };
                  };
                })
              ];
            }
          ];
      };

      # Configuration for 2024 base M4 Mac mini (Mac16,10) Juliet (aarch64-darwin)
      juliet = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs =
          specialArgs
          // {
            hostname = "juliet";
          };
        modules =
          [
            ./modules/darwin/nix-core.nix
            ./modules/darwin/system.nix
            ./modules/darwin/apps.nix
            ./modules/darwin/apps-aarch64.nix
            # ./modules/homebrew-mirror.nix # comment this line if you don't need a homebrew mirror
            ./modules/darwin/host-users.nix
            stylix.darwinModules.stylix
            ./modules/stylix.nix
          ]
          ++ mkHome home-manager.darwinModules.home-manager [
            ./modules/home/darwin.nix
          ]
          ++ [
            # Overlay to disable tests for dnspython
            {
              nixpkgs.overlays = [
                (final: prev: {
                  nodejs = prev.nodejs_20;
                })
                (self: super: {
                  python3Packages = super.python3Packages.override {
                    overrides = self: super: {
                      dnspython = super.dnspython.overrideAttrs (oldAttrs: {
                        doCheck = false;
                      });
                    };
                  };
                })
              ];
            }
          ];
      };

      # Configuration for MacBook Pro (Retina, 13-inch, Early 2013, MacBookPro10,2) Foxtrot (x86_64-darwin)
      foxtrot = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        specialArgs =
          specialArgs
          // {
            hostname = "foxtrot";
          };
        modules =
          [
            ./modules/darwin/nix-core.nix
            ./modules/darwin/system.nix
            ./modules/darwin/apps.nix
            # ./modules/homebrew-mirror.nix # comment this line if you don't need a homebrew mirror
            ./modules/darwin/host-users.nix
            stylix.darwinModules.stylix
            ./modules/stylix.nix
          ]
          ++ mkHome home-manager.darwinModules.home-manager [
            ./modules/home/darwin.nix
          ];
      };
    };

    homeConfigurations = {
      # Configuration for Raspberry Pi RPi5
      echo = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "aarch64-linux";
          config = {
            allowUnfree = true;
          };
        };
        extraSpecialArgs = specialArgs;
        modules = [
          {
            home.username = "${username}";
            home.stateVersion = "24.11"; # Update this to the appropriate version
            home.homeDirectory = "/home/${username}";
          }
          stylix.homeManagerModules.stylix
          ./modules/stylix.nix
          ./modules/home/linux-desktop.nix
        ];
      };

      # Configuration for Steam Deck India running SteamOS
      india = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = {
            allowUnfree = true;
          };
        };
        extraSpecialArgs = specialArgs;
        modules = [
          {
            home.username = "${username}";
            home.stateVersion = "24.11";
            home.homeDirectory = "/home/${username}";
          }
          stylix.homeManagerModules.stylix
          ./modules/stylix.nix
          ./modules/home/linux-desktop.nix
          ./modules/home/linux-apps-x86_64.nix
        ];
      };
    };

    devShells = {
      aarch64-darwin = let
        pkgs = import nixpkgs {system = "aarch64-darwin";};
      in {
        azure-pern-infra = import ./devshells/azure-pern-infra.nix {inherit pkgs;};
        python-fasthtml = import ./devshells/python-fasthtml.nix {inherit pkgs;};
        github-pages = import ./devshells/github-pages.nix {inherit pkgs;};
        kali-linux = import ./devshells/kali-linux.nix {inherit pkgs;};
        python-data-science = import ./devshells/python-data-science.nix {inherit pkgs;};
        python-devops = import ./devshells/python-devops.nix {inherit pkgs;};
        python-ytdlp = import ./devshells/python-ytdlp.nix {inherit pkgs;};
        typescript-devops = import ./devshells/typescript-devops.nix {inherit pkgs;};
      };
      aarch64-linux = let
        pkgs = import nixpkgs {system = "aarch64-linux";};
      in {
        azure-pern-infra = import ./devshells/azure-pern-infra.nix {inherit pkgs;};
        python-fasthtml = import ./devshells/python-fasthtml.nix {inherit pkgs;};
        github-pages = import ./devshells/github-pages.nix {inherit pkgs;};
        kali-linux = import ./devshells/kali-linux.nix {inherit pkgs;};
        python-data-science = import ./devshells/python-data-science.nix {inherit pkgs;};
        python-devops = import ./devshells/python-devops.nix {inherit pkgs;};
        python-ytdlp = import ./devshells/python-ytdlp.nix {inherit pkgs;};
        typescript-devops = import ./devshells/typescript-devops.nix {inherit pkgs;};
      };
      x86_64-darwin = let
        pkgs = import nixpkgs {system = "x86_64-darwin";};
      in {
        azure-pern-infra = import ./devshells/azure-pern-infra.nix {inherit pkgs;};
        python-fasthtml = import ./devshells/python-fasthtml.nix {inherit pkgs;};
        github-pages = import ./devshells/github-pages.nix {inherit pkgs;};
        kali-linux = import ./devshells/kali-linux.nix {inherit pkgs;};
        python-data-science = import ./devshells/python-data-science.nix {inherit pkgs;};
        python-devops = import ./devshells/python-devops.nix {inherit pkgs;};
        python-ytdlp = import ./devshells/python-ytdlp.nix {inherit pkgs;};
        typescript-devops = import ./devshells/typescript-devops.nix {inherit pkgs;};
      };
      x86_64-linux = let
        pkgs = import nixpkgs {system = "x86_64-linux";};
      in {
        azure-pern-infra = import ./devshells/azure-pern-infra.nix {inherit pkgs;};
        python-fasthtml = import ./devshells/python-fasthtml.nix {inherit pkgs;};
        github-pages = import ./devshells/github-pages.nix {inherit pkgs;};
        kali-linux = import ./devshells/kali-linux.nix {inherit pkgs;};
        python-data-science = import ./devshells/python-data-science.nix {inherit pkgs;};
        python-devops = import ./devshells/python-devops.nix {inherit pkgs;};
        python-ytdlp = import ./devshells/python-ytdlp.nix {inherit pkgs;};
        typescript-devops = import ./devshells/typescript-devops.nix {inherit pkgs;};
      };
    };

    # nix code formatter for both systems
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.alejandra;
    formatter.x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.alejandra;
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
