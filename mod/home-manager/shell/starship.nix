{
  config,
  lib,
  ...
}: {
  options.xfaf.shell.starship.enable = lib.mkEnableOption "install 0x5a4s starship config";

  config = lib.mkIf config.xfaf.shell.starship.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;

      settings = {
        add_newline = false;

        shell = {
          disabled = false;
          fish_indicator = "🐟";
        };

        git_metrics.disabled = false;

        status = {
          symbol = "🔴";
          map_symbol = true;
          disabled = false;
        };

        character = {
          success_symbol = "[](bold green) ";
          error_symbol = "[](bold red) ";
          vicmd_symbol = "[](bold green) ";
        };

        gcloud.disabled = true;

        # boring symbols override
        jobs.symbol = "⏰";
        aws.symbol = "  ";
        buf.symbol = " ";
        c.symbol = " ";
        conda.symbol = " ";
        crystal.symbol = " ";
        dart.symbol = " ";
        directory.read_only = " 󰌾";
        docker_context.symbol = " ";
        elixir.symbol = " ";
        elm.symbol = " ";
        fennel.symbol = " ";
        fossil_branch.symbol = " ";
        git_branch.symbol = " ";
        golang.symbol = " ";
        guix_shell.symbol = " ";
        haskell.symbol = " ";
        haxe.symbol = " ";
        hg_branch.symbol = " ";
        hostname.ssh_symbol = " ";
        java.symbol = " ";
        julia.symbol = " ";
        kotlin.symbol = " ";
        lua.symbol = " ";
        memory_usage.symbol = "󰍛 ";
        meson.symbol = "󰔷 ";
        nim.symbol = "󰆥 ";
        nix_shell.symbol = " ";
        nodejs.symbol = " ";
        ocaml.symbol = " ";

        os.symbols = {
          Alpaquita = " ";
          Alpine = " ";
          AlmaLinux = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Kali = " ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          RockyLinux = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Void = " ";
          Windows = "󰍲 ";
        };

        package.symbol = "󰏗 ";
        perl.symbol = " ";
        php.symbol = " ";
        pijul_channel.symbol = " ";
        python.symbol = " ";
        rlang.symbol = "󰟔 ";
        ruby.symbol = " ";
        rust.symbol = " ";
        scala.symbol = " ";
        swift.symbol = " ";
        zig.symbol = " ";
      };
    };
  };
}
