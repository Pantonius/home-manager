{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    nixvim.enable = lib.mkEnableOption "enables nixvim";
  };

  config = lib.mkIf config.nixvim.enable {
    programs.ripgrep.enable = true; # Required for Telescope

    # see https://github.com/nix-community/nixvim
    programs.nixvim = {
      enable = true;
      defaultEditor = true;

      colorschemes = {
        nord.enable = true;
        tokyonight = {
          settings = {
            style = "storm";
            lualine_bold = true;
          };
        };
      };

      globals.mapleader = " ";

      extraConfigLuaPre =
        # lua
        ''
          local slow_format_filetypes = {}

          vim.api.nvim_create_user_command("FormatDisable", function(args)
             if args.bang then
              -- FormatDisable! will disable formatting just for this buffer
              vim.b.disable_autoformat = true
            else
              vim.g.disable_autoformat = true
            end
          end, {
            desc = "Disable autoformat-on-save",
            bang = true,
          })
          vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
          end, {
            desc = "Re-enable autoformat-on-save",
          })
          vim.api.nvim_create_user_command("FormatToggle", function(args)
            if args.bang then
              -- Toggle formatting for current buffer
              vim.b.disable_autoformat = not vim.b.disable_autoformat
            else
              -- Toggle formatting globally
              vim.g.disable_autoformat = not vim.g.disable_autoformat
            end
          end, {
            desc = "Toggle autoformat-on-save",
            bang = true,
          })

          vim.g.coqtail_noimap = 1
        '';
      plugins = {
        lualine.enable = true;
        treesitter.enable = true;
        telescope.enable = true;

        fugitive.enable = true;
        indent-blankline.enable = true;
        web-devicons.enable = true;

        # rich presence
        presence-nvim = {
          enable = true;

          autoUpdate = true;
          mainImage = "file";
          neovimImageText = "Nixvim";
        };

        # harpoon
        harpoon.enable = true;

        # neo-tree
        neo-tree = {
          enable = true;
        };

        # typst
        typst-vim.enable = true;

        # Language Servers
        lsp = {
          enable = true;
          inlayHints = true;

          servers = {
            nil_ls.enable = true;
            nixd.enable = true; # Nix
            ts_ls.enable = true; # Typescript
            pylsp.enable = true; # Python
            ccls.enable = true; # C/C++
            rust_analyzer = {
              # Rust
              enable = true;
              installCargo = true;
              installRustc = true;
            };
            erlangls.enable = true; # Erlang
            texlab.enable = true; # Latex
            bashls.enable = true; # Bash
            jsonls.enable = true; # JSON
          };

          keymaps = {
            silent = true;

            lspBuf = {
              gd = {
                action = "definition";
                desc = "Goto Definition";
              };
              gr = {
                action = "references";
                desc = "Goto References";
              };
              gD = {
                action = "declaration";
                desc = "Goto Declaration";
              };
              gI = {
                action = "implementation";
                desc = "Goto Implementation";
              };
              gT = {
                action = "type_definition";
                desc = "Type Definition";
              };
              K = {
                action = "hover";
                desc = "Hover";
              };
              "<leader>cw" = {
                action = "workspace_symbol";
                desc = "Workspace Symbol";
              };
              "<leader>cr" = {
                action = "rename";
                desc = "Rename";
              };
            };
            diagnostic = {
              "<leader>cd" = {
                action = "open_float";
                desc = "Line Diagnostics";
              };
              "[d" = {
                action = "goto_next";
                desc = "Next Diagnostic";
              };
              "]d" = {
                action = "goto_prev";
                desc = "Previous Diagnostic";
              };
            };
          };
        };

        lsp-lines = {
          enable = true;
        };

        lsp-format = {
          enable = true;
        };

        conform-nvim = {
          enable = true;

          settings = {
            format_on_save = ''
              function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end

                if slow_format_filetypes[vim.bo[bufnr].filetype] then
                  return
                end

                local function on_format(err)
                  if err and err:match("timeout$") then
                    slow_format_filetypes[vim.bo[bufnr].filetype] = true
                  end
                end

                return { timeout_ms = 200, lsp_fallback = true }, on_format
               end
            '';

            format_after_save = ''
              function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end

                if not slow_format_filetypes[vim.bo[bufnr].filetype] then
                  return
                end

                return { lsp_fallback = true }
              end
            '';

            notify_on_error = true;

            formatters_by_ft = {
              nix = [ "nixfmt-rfc-style" ];
              rust = [ "rustfmt" ];
              cpp = [ "clang-format" ];
              bash = [
                "shellcheck"
                "shellharden"
                "shfmt"
              ];
            };

            formatters = {
              clang-format = {
                command = "${lib.getExe' pkgs.clang-tools "clang-format"}";
              };
              rustfmt = {
                command = "${lib.getExe pkgs.rustfmt}";
              };
              nixfmt-rfc-style = {
                command = "${lib.getExe pkgs.nixfmt-rfc-style}";
              };
              shellcheck = {
                command = "${lib.getExe pkgs.shellcheck}";
              };
              shfmt = {
                command = "${lib.getExe pkgs.shfmt}";
              };
            };
          };
        };

        # Completion
        cmp = {
          enable = true;

          settings = {
            autoEnableSources = true;

            sources = [
              { name = "git"; }
              { name = "nvim_lsp"; }
              { name = "buffer"; }
              { name = "path"; }
            ];

            mapping = {
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<C-j>" = "cmp.mapping.select_next_item()";
              "<C-k>" = "cmp.mapping.select_prev_item()";
              "<C-e>" = "cmp.mapping.abort()";
              "<C-b>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-Space>" = "cmp.mapping.complete()";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
            };
          };
        };

        cmp-nvim-lsp = {
          enable = true; # LSP
        };

        cmp-buffer = {
          enable = true;
        };

        cmp-path = {
          enable = true; # file system paths
        };
      };

      extraPlugins = with pkgs.vimPlugins; [
        LanguageTool-nvim
        vimtex
        Coqtail
        coq-lsp-nvim
        # mdx-analyzer
      ];

      keymaps = [
        # Harpoon
        {
          mode = "n";
          key = "<leader>a";
          action.__raw = "function() require'harpoon':list():add() end";
        }
        {
          mode = "n";
          key = "<C-e>";
          action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
        }
        {
          mode = "n";
          key = "<C-j>";
          action.__raw = "function() require'harpoon':list():select(1) end";
        }
        {
          mode = "n";
          key = "<C-k>";
          action.__raw = "function() require'harpoon':list():select(2) end";
        }
        {
          mode = "n";
          key = "<C-l>";
          action.__raw = "function() require'harpoon':list():select(3) end";
        }
        {
          mode = "n";
          key = "<C-m>";
          action.__raw = "function() require'harpoon':list():select(4) end";
        }

        # Compile tex file with xelatex
        {
          mode = "n";
          key = "<leader>cx";
          action = ":VimtexCompile<CR>";
        }

        # Open explorer
        {
          mode = "n";
          key = "<leader>pv";
          action = "<cmd>Neotree toggle<CR>";
        }

        # move lines up and down in visual mode
        {
          mode = "v";
          key = "J";
          action = ":m '>+1<CR>gv=gv";
        }
        {
          mode = "v";
          key = "K";
          action = ":m '<-2<CR>gv=gv";
        }

        # copy to clipboard
        {
          mode = [
            "n"
            "v"
          ];
          key = "<leader>y";
          action = "+y";
        }
        {
          mode = "n";
          key = "<leader>Y";
          action = "+Y";
        }

        # LSP Diagnostics
        {
          action = "<cmd>Telescope diagnostics bufnr=1<CR>";
          key = "<leader>D";
        }

        # Telescope
        {
          action = "<cmd>Telescope live_grep<CR>";
          key = "<leader>fw";
        }
        {
          action = "<cmd>Telescope find_files<CR>";
          key = "<leader>ff";
        }
        {
          action = "<cmd>Telescope git_commits<CR>";
          key = "<leader>fg";
        }
        {
          action = "<cmd>Telescope oldfiles<CR>";
          key = "<leader>fh";
        }
        {
          action = "<cmd>Telescope colorscheme<CR>";
          key = "<leader>ch";
        }
        {
          action = "<cmd>Telescope man_pages<CR>";
          key = "<leader>fm";
        }

        # Rust
        {
          action = "<cmd>RustRun<CR>";
          key = "<leader>rr";
        }
      ];

      clipboard = {
        providers.wl-copy.enable = true;
      };

      opts = {
        number = true; # Show line numbers
        relativenumber = true; # Show relative line numbers

        tabstop = 2; # Tab width should be 2 spaces
        softtabstop = 2;
        showtabline = 2;
        expandtab = true; # Use spaces instead of tabs

        smartindent = true;
        shiftwidth = 2; # Indentation should be 2 spaces
        breakindent = true;

        clipboard = "unnamedplus"; # Use system clipboard
      };
    };
  };
}
