-- C++ and Java specific plugins
return {
  -- 🔧 C++ ENHANCED HIGHLIGHTING: Better C++ syntax colors
  {
    "octol/vim-cpp-enhanced-highlight",
    -- What it does: More detailed C++ syntax highlighting
    -- Features: STL containers, member functions, etc.
    ft = { "cpp", "c" },
  },

  -- 🏗️ CMAKE SUPPORT: Build system integration
  {
    "cdelledonne/vim-cmake",
    -- What it does: CMake project management
    -- Features: Build, run, configure CMake projects
    ft = { "cpp", "c", "cmake" },
  },

  -- ☕ JAVA LSP: Advanced Java support
  {
    "mfussenegger/nvim-jdtls",
    -- What it does: Eclipse JDT language server for Java
    -- Features: Advanced Java completions, refactoring
    ft = "java",
  },
}
