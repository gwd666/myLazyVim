require("dbee").setup({
  sources = {
    require("dbee.sources").MemorySource:new({
      {
        name = "wsl_pgres",
        type = "postgres",
        url = "localhost:5432",
      },
      -- ...
    }),
    require("dbee.sources").EnvSource:new("DBEE_CONNECTIONS"),
    -- require("dbee.sources").FileSource:new(vim.fn.stdpath("cache") .. "/dbee/persistence.json"),
  },
  -- ...
})
