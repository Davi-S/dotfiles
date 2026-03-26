# Coding
# ======
# Developer tooling and configuration.
# Packages, editor configs and helper utilities used for development.


## Main editor ##
AddPackage neovim # Fork of Vim aiming to improve user experience, plugins, and GUIs
CopyFile /home/davi/.config/nvim/init.lua '' davi davi
CopyFile /home/davi/.config/nvim/lazy-lock.json '' davi davi
CopyFile /home/davi/.config/nvim/lua/config/keymaps.lua '' davi davi
CopyFile /home/davi/.config/nvim/lua/config/lazy.lua '' davi davi
CopyFile /home/davi/.config/nvim/lua/config/options.lua '' davi davi
CopyFile /home/davi/.config/nvim/lua/plugins/colorscheme.lua '' davi davi
CopyFile /home/davi/.config/nvim/lua/plugins/completion.lua '' davi davi
CopyFile /home/davi/.config/nvim/lua/plugins/git.lua '' davi davi
CopyFile /home/davi/.config/nvim/lua/plugins/lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lua/plugins/nvim-obsidian.lua '' davi davi
CopyFile /home/davi/.config/nvim/lua/plugins/telescope.lua '' davi davi
CopyFile /home/davi/.config/nvim/lua/plugins/treesitter.lua '' davi davi
CopyFile /home/davi/.config/nvim/lua/plugins/yazi.lua '' davi davi
CopyFile /home/davi/.config/nvim/lua/plugins_helpers/colorscheme_helper.lua '' davi davi
CopyFile /home/davi/.config/nvim/lua/plugins_helpers/completions_helper.lua '' davi davi
CopyFile /home/davi/.config/nvim/lua/plugins_helpers/lsp_helper.lua '' davi davi
CopyFile /home/davi/.config/nvim/lua/plugins_helpers/nvim-obsidian_helper.lua '' davi davi
CopyFile /home/davi/.config/nvim/lua/plugins_helpers/telescope_helper.lua '' davi davi
CopyFile /home/davi/.config/nvim/spell/en.utf-8.add '' davi davi
CopyFile /home/davi/.config/nvim/spell/en.utf-8.add.spl '' davi davi
CopyFile /home/davi/.config/nvim/spell/pt.utf-8.spl '' davi davi
SetFileProperty /home/davi/.config/nvim group davi
SetFileProperty /home/davi/.config/nvim owner davi
SetFileProperty /home/davi/.config/nvim/lua group davi
SetFileProperty /home/davi/.config/nvim/lua owner davi
SetFileProperty /home/davi/.config/nvim/lua/config group davi
SetFileProperty /home/davi/.config/nvim/lua/config owner davi
SetFileProperty /home/davi/.config/nvim/lua/plugins group davi
SetFileProperty /home/davi/.config/nvim/lua/plugins owner davi
SetFileProperty /home/davi/.config/nvim/lua/plugins_helpers group davi
SetFileProperty /home/davi/.config/nvim/lua/plugins_helpers owner davi
SetFileProperty /home/davi/.config/nvim/spell group davi
SetFileProperty /home/davi/.config/nvim/spell owner davi


# Python package managers 
AddPackage uv # An extremely fast Python package installer and resolver written in Rust
AddPackage python-pip # The PyPA recommended tool for installing Python packages
AddPackage python-pipx # Install and Run Python Applications in Isolated Environments


AddPackage git # the fast distributed version control system
CopyFile /home/davi/.gitconfig '' davi davi


# Primarily required by git for some commands. Is not a mandatory dependency
AddPackage less # A terminal based program for viewing text files
 

# Installed for the LSP of nvim to remove a warning
AddPackage inotify-tools # inotify-tools is a C library and a set of command-line programs for Linux providing a simple interface to inotify.


# Initially installed for the Revelo LLM Projects
AddPackage docker # Pack, ship and run any application as a lightweight container


# Initially installed for a university assignment
AddPackage valgrind # Tool to help find memory-management problems in programs


# VScode from microsoft
# Used for the Revelo LLM Project
AddPackage --foreign visual-studio-code-bin # Visual Studio Code (vscode): Editor for building and debugging modern web and cloud applications (official binary version)


# Git terminal user interface
AddPackage lazygit # Simple terminal UI for git commands
CopyFile /home/davi/.config/lazygit/config.yml '' davi davi
SetFileProperty /home/davi/.config/lazygit group davi
SetFileProperty /home/davi/.config/lazygit owner davi


# Installed as a dependency of the telescope nvim plugin
AddPackage fd # Simple, fast and user-friendly alternative to find


# Installed to be able to install some LSP for nvim
AddPackage npm # JavaScript package manager


# Installed as a dependency of nvim plugins
AddPackage ripgrep # A search tool that combines the usability of ag with the raw speed of grep


# Dependency of the treesitter nvim plugin
AddPackage tree-sitter-cli # CLI tool for developing, testing, and using Tree-sitter parsers


# Configuration for the C lang formatter
CopyFile /home/davi/.clang-format '' davi davi


# Installed as a requirement for a Revelo project
AddPackage tmux # Terminal multiplexer
CopyFile /home/davi/.tmux.conf '' davi davi


# These are the configurations recipes from the nvim-lspconfig plugin which I downloaded locally and edited 
CopyFile /home/davi/.config/nvim/lsp/ada_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/agda_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/aiken.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/air.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/alloy_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/anakin_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/angularls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ansiblels.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/antlersls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/apex_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/arduino_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/asm_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ast_grep.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/astro.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/atlas.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/atopile.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/autohotkey_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/autotools_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/awk_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/azure_pipelines_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/bacon_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ballerina.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/basedpyright.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/bashls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/basics_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/bazelrc_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/beancount.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/bicep.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/biome.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/bitbake_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/blueprint_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/bqls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/bright_script.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/bsl_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/buck2.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/buddy_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/buf_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/bzl.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/c3_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/cairo_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ccls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/cds_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/cir_lsp_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/circom-lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/clangd.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/clarinet.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/clojure_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/cmake.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/cobol_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/codebook.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/coffeesense.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/contextive.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/copilot.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/coq_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/crystalline.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/csharp_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/cspell_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/css_variables.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/cssls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/cssmodules_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/cucumber_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/cue.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/custom_elements_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/cypher_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/daedalus_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/dafny.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/dagger.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/dartls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/dcmls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/debputy.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/denols.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/dhall_lsp_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/diagnosticls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/digestif.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/djls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/djlsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/docker_compose_language_service.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/docker_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/dockerls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/dolmenls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/dotls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/dprint.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ds_pinyin_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/dts_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/earthlyls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ecsact.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/efm.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/elixirls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/elmls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/elp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ember.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/emmet_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/emmet_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/emmylua_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/erg_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/erlangls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/esbonio.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/eslint.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/expert.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/facility_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/fennel_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/fennel_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/fish_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/flow.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/flux_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/foam_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/fortls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/fsautocomplete.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/fsharp_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/fstar.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/futhark_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/gdscript.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/gdshader_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/gh_actions_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ghcide.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ghdl_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ginko_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/gitlab_ci_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/glasgow.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/gleam.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/glint.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/glsl_analyzer.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/glslls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/gnls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/golangci_lint_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/gopls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/gradle_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/grammarly.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/graphql.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/groovyls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/guile_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/harper_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/hdl_checker.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/helm_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/herb_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/hhvm.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/hie.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/hlasm.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/hls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/hoon_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/html.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/htmx.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/hydra_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/hyprls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/idris2_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/intelephense.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/janet_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/java_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/jdtls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/jedi_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/jinja_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/jqls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/jsonls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/jsonnet_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/julials.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/just.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/kcl.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/koka.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/kotlin_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/kotlin_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/kulala_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/laravel_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/lean3ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/leanls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/lelwel_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/lemminx.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/lexical.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/lsp_ai.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ltex.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ltex_plus.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/lua_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/luau_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/lwc_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/m68k.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/markdown_oxide.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/marko-js.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/marksman.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/matlab_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/mdx_analyzer.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/mesonlsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/metals.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/millet.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/mint.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/mlir_lsp_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/mlir_pdll_lsp_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/mm0_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/mojo.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/motoko_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/move_analyzer.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/msbuild_project_tools_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/muon.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/mutt_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/nelua_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/neocmake.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/nextflow_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/nextls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/nginx_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/nickel_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/nil_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/nim_langserver.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/nimls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/nixd.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/nomad_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ntt.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/nushell.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/nxls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ocamllsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ols.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/omnisharp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/opencl_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/openscad_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/openscad_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/oxlint.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/pact_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/pasls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/pbls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/perlls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/perlnavigator.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/perlpls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/pest_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/phan.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/phpactor.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/phptools.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/pico8_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/please.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/pli.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/poryscript_pls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/postgres_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/powershell_es.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/prismals.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/prolog_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/prosemd_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/protols.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/psalm.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/pug.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/puppet.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/purescriptls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/pylsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/pylyzer.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/pyre.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/pyrefly.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/pyright.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/qmlls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/quick_lint_js.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/r_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/racket_langserver.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/raku_navigator.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/reason_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/regal.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/regols.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/remark_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/rescriptls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/rls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/rnix.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/robotcode.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/robotframework_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/roc_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/rome.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/roslyn_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/rpmspec.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/rubocop.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ruby_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ruff.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ruff_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/rune_languageserver.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/rust_analyzer.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/salt_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/scheme_langserver.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/scry.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/selene3p_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/serve_d.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/shopify_theme_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/sixtyfps.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/slangd.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/slint_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/smarty_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/smithy_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/snakeskin_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/snyk_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/solang.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/solargraph.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/solc.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/solidity.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/solidity_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/solidity_ls_nomicfoundation.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/somesass_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/sorbet.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/sourcekit.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/sourcery.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/spectral.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/spyglassmc_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/sqlls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/sqls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/sqruff.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/standardrb.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/starlark_rust.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/starpls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/statix.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/steep.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/stimulus_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/stylelint_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/stylua.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/stylua3p_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/superhtml.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/svelte.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/svlangserver.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/svls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/swift_mesonls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/syntax_tree.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/systemd_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/tabby_ml.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/tailwindcss.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/taplo.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/tblgen_lsp_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/teal_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/templ.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/termux_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/terraform_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/terraformls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/texlab.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/textlsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/tflint.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/theme_check.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/thriftls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/tilt_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/tinymist.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/tofu_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/tombi.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ts_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ts_query_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/tsgo.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/tsp_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ttags.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/turbo_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/turtle_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/tvm_ffi_navigator.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/twiggy_language_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ty.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/typeprof.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/typos_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/typst_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/uiua.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ungrammar_languageserver.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/unison.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/unocss.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/uvls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/v_analyzer.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/vacuum.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/vala_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/vale_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/vectorcode_server.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/verible.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/veridian.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/veryl_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/vespa_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/vhdl_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/vimls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/visualforce_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/vls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/volar.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/vscoqtop.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/vtsls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/vue_ls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/wasm_language_tools.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/wgsl_analyzer.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/yamlls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/yang_lsp.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/yls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ziggy.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/ziggy_schema.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/zk.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/zls.lua '' davi davi
CopyFile /home/davi/.config/nvim/lsp/zuban.lua '' davi davi
