{pkgs, ...}: {
  programs = {
    chromium = {
      enable = true;
      package = (
        pkgs.chromium.override {
          commandLineArgs = [
            "--enable-features=AcceleratedVideoEncoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE"
            "--enable-features=VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport"
            "--enable-features=UseMultiPlaneFormatForHardwareVideo"
            "--enable-features=SkiaGraphite"
            "--enable-unsafe-webgpu"
            "--ignore-gpu-blocklist"
            "--enable-zero-copy"
          ];
          enableWideVine = true;
        }
      );
      extensions = [
        {id = "ddkjiahejlhfcafbddmgiahcphecmpfh";}
        {id = "ponfpcnoihfmfllpaingbgckeeldkhle";}
        {id = "mnjggcdmjocbbbhaepdhchncahnbgone";}
        {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";}
        {id = "edibdbjcniadpccecjdfdjjppcpchdlm";}
        {id = "jceaicinopjaoknlhdfdjileacogogep";}
        {id = "hdpcadigjkbcpnlcpbcohpafiaefanki";}

        {id = "giokfhncgfjkoamdbhfhfhgpikaioccc";}
      ];
    };
  };
  home.packages = with pkgs; [
    vivaldi-ffmpeg-codecs
  ];
}
