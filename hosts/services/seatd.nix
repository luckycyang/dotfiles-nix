{ config, ... }:
{
  config = {
    services.seatd = {
      enable = true;
      user = "dingduck";
    };
  };
}
