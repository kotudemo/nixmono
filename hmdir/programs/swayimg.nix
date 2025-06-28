{
  programs.swayimg = {
    enable = true;

    settings = {
      general = {
        mode = "viewer";
        position = "parent";
        size = "parent";
        sigusr1 = "reload";
        sigusr2 = "next_file";
        app_id = "swayimg";
      };

      viewer = {
        window = "#00000000";
        transparency = "grid";
        scale = "optimal";
        fixed = true;
        antialiasing = false;
        slideshow = false;
        slideshow_time = 3;
        history = 1;
        preload = 1;
      };

      gallery = {
        size = 200;
        cache = 100;
        fill = true;
        antialiasing = false;
        window = "#00000000";
        background = "#202020ff";
        select = "#404040ff";
        border = "#000000ff";
        shadow = "#000000ff";
      };

      list = {
        order = "alpha";
        loop = true;
        recursive = false;
        all = true;
      };

      font = {
        name = "JetBrainsMonoNerdFontMono:size=12:weight=SemiBold";
        size = 14;
        color = "#ccccccff";
        shadow = "#000000a0";
      };

      info = {
        show = true;
        info_timeout = 5;
        status_timeout = 3;
      };

      "info.viewer" = {
        top_left = "+name,+format,+filesize,+imagesize,+exif";
        top_right = "index";
        bottom_left = "scale,frame";
        bottom_right = "status";
      };

      "info.gallery" = {
        top_left = "none";
        top_right = "none";
        bottom_left = "none";
        bottom_right = "name,status";
      };

      "keys.viewer" = {
        F1 = "help";
        Home = "first_file";
        End = "last_file";
        "Alt+Space" = "skip_file";
        Next = "next_file";
        Space = "next_file";
        "Shift+d" = "prev_dir";
        d = "next_dir";
        "Shift+o" = "prev_frame";
        o = "next_frame";
        c = "prev_file";
        s = "animation";
        f = "fullscreen";
        Return = "mode";
        Left = "step_left 10";
        Right = "step_right 10";
        Up = "step_up 10";
        Down = "step_down 10";
        Equal = "zoom +10";
        Plus = "zoom +10";
        Minus = "zoom -10";
        w = "zoom width";
        "Shift+w" = "zoom height";
        z = "zoom fit";
        "Shift+z" = "zoom fill";
        "0" = "zoom real";
        BackSpace = "zoom optimal";
        bracketleft = "rotate_left";
        bracketright = "rotate_right";
        m = "flip_vertical";
        "Shift+m" = "flip_horizontal";
        a = "antialiasing";
        r = "reload";
        i = "info";
        "Shift+Delete" = ''exec rm "%"; skip_file'';
        Escape = "exit";
        q = "exit";

        ScrollLeft = "step_right 5";
        ScrollRight = "step_left 5";
        ScrollUp = "step_up 5";
        ScrollDown = "step_down 5";
        "Ctrl+ScrollUp" = "zoom +10";
        "Ctrl+ScrollDown" = "zoom -10";
        "Shift+ScrollUp" = "prev_file";
        "Shift+ScrollDown" = "next_file";
        "Alt+ScrollUp" = "prev_frame";
        "Alt+ScrollDown" = "next_frame";
      };

      "keys.gallery" = {
        F1 = "help";
        Home = "first_file";
        End = "last_file";
        Left = "step_left";
        Right = "step_right";
        Up = "step_up";
        Down = "step_down";
        Prior = "page_up";
        Next = "page_down";
        c = "skip_file";
        f = "fullscreen";
        Return = "mode";
        a = "antialiasing";
        r = "reload";
        i = "info";
        "Shift+Delete" = ''exec rm "%"; skip_file'';
        Escape = "exit";
        q = "exit";

        ScrollLeft = "step_right";
        ScrollRight = "step_left";
        ScrollUp = "step_up";
        ScrollDown = "step_down";
      };
    };
  };
}
