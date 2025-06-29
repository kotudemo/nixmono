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
        }
      );
    };
  };
  home.packages = with pkgs; [
    vivaldi-ffmpeg-codecs
  ];
}
