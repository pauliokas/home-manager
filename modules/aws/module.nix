{ pkgs, ... }:
{
  home.packages = with pkgs; [
    aws-vault
    ssm-session-manager-plugin
  ];

  programs.awscli = {
    enable = true;
  };
}
