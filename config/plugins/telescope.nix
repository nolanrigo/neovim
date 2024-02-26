{
  plugins.telescope = {
    enable = true;
    defaults = null;
    extraOptions = {};
    highlightTheme = "tokyonight";

    keymapsSilent = false;

    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        desc = "[F]ind exising [F]iles";
      };
      "<leader>fg" = {
        action = "live_grep";
        desc = "[F]ind file by [G]rep";
      };
      "<leader>fb" = {
        action = "buffers";
        desc = "[F]ind existing [B]uffers";
      };
      "<leader><space>" = {
        action = "buffers";
        desc = "[F]ind existing [B]uffers";
      };
      /*
      "<leader>fd" = {
        action = "find_diagnostics";
        desc = "[F]ind exising [D]";
      };
      "<leader>fr" = {
        action = "oldfiles";
        desc = "[F]ind [R]ecently opened files";
      };
      "<leader>fs" = {
        action = ''
          function ()
            grep_string({ search = vim.fn.input("Grep > ") })
          end
        '';
        desc = "";
      };
      "<leader>/" = {
        action = ''
          current_buffer_fuzzy_find(themes.get_dropdown {
            winblend = 10,
            previewer = false,
          })
        '';
        desc = "[/] Fuzzily search in current buffer";
      };*/
    };
  };
}
