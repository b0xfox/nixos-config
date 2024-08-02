{
    imports = [
        ./home-modules/bundle.nix
        ./home-modules/user_packages.nix
    ];

    home = {
        username = "fox";
        homeDirectory = "/home/fox";
        stateVersion = "24.05";

        sessionVariables = {
            # EDITOR = "emacs";
        };
    };

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
