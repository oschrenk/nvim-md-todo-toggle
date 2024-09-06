# Neovim Markdown Todo Toggler

## Setup

Lazy:

```
return {
  "oschrenk/nvim-md-todo-toggle",
  keys = {
    {
      "<C-r>",
      function()
        require("nvim-md-todo-toggle").toggle()
      end,
      desc = "Toggle todo",
    },
    {
      "<C-e>",
      function()
        require("nvim-md-todo-toggle").add()
      end,
      desc = "Add todo",
    },
  },
  config = function()
    require("nvim-md-todo-toggle").setup({
      marker = { " ", "x", "-" },
    })
  end,
}
```

## Commands

- `:TDToggle`
- `:TDAdd`

![Nvim Todo Markdown Toggler in action](toggler.gif)
