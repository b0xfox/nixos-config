{ pkgs, ... }:
{

    nixpkgs.overlays = [

        (self: super: {
            discord = super.discord.overrideAttrs (
                _: { src = builtins.fetchTarball {
                    url = "https://discord.com/api/download?platform=linux&format=tar.gz";
                    sha256 = "0000000000000000000000000000000000000000000000000000"; # 52 0s
                }; }
            );
        })
    ];
  
}
