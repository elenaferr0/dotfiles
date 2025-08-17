return {
  "nvim-lualine/lualine.nvim",
  -- "kdheepak/tabline.nvim",
  "tpope/vim-surround",
  -- "akinsho/bufferline.nvim",
  "tpope/vim-repeat",
  "nvim-tree/nvim-tree.lua",
  "rcarriga/nvim-notify",
  "akinsho/toggleterm.nvim",
  "renerocksai/telekasten.nvim",
  "justinmk/vim-sneak",
  "antosha417/nvim-lsp-file-operations",
  "windwp/nvim-ts-autotag",
  "kaarmu/typst.vim",
  "tpope/vim-sleuth", -- heuristicaly adjust shiftwidth and expandtab based on the file
  {
    "ryanoasis/vim-devicons",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-live-grep-args.nvim", "nvim-lua/plenary.nvim" },
  },
}
