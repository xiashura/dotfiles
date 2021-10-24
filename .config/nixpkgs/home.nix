{ config, lib, pkgs, ... }: 
{
 imports = [
    "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
  ];

  services.vscode-server.enable = true;

  home.packages = with pkgs; [
     neofetch
		 tmux
		 unzip
		 lm_sensors
		 fzf 

  ];
  programs.git = {
    enable = true;
    userName  = "xiashura";
    userEmail = "plexanov@protonmail.com";
  };
  programs.neovim = { 
    enable = true; 
		withNodeJs   = true; # for coc.nvim
    withPython3  = true; # for plugins
    extraConfig = 
		let neovim = import ./neovim.nix;
		in neovim.config ;
		plugins = with pkgs.vimPlugins; [
			nerdtree
			vim-devicons
			coc-nvim
			vim-commentary
			nerdtree-git-plugin
			vim-gitgutter
			vim-fugitive
			vim-signify
			fzf-vim
		];
  };
}
