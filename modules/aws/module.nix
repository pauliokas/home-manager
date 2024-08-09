{ pkgs, ... }:
{
  home.packages = with pkgs; [
    aws-vault
    ssm-session-manager-plugin
    opentofu
  ];

  programs.awscli = {
    enable = true;
  };
}
