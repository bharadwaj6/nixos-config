{pkgs, ...}: {
  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = ["bharadwaj"];
  environment.systemPackages = [pkgs.docker-compose];
}
