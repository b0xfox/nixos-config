{

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  sound = {

    enable = true;
    mediaKeys.enable = true;

  };
  services.pipewire = {

    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    #jack.enable = true;

  };
  
}