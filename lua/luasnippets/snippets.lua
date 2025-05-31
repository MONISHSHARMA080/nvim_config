local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("typescript", {
  s("console.log", {
    t("console.log(`"),
    i(1),
    t("`)"),
  }),
})

ls.add_snippets("go", {
  s("iferr", {
    t("if err != nil {", ""),
    i(1),
    t("}"),
  }),
})
ls.add_snippets("go", {
  s("ife", {
    t({ "if err != nil {", '\tprintln("' }),
    i(1), -- Cursor will be positioned here inside the quotes
    t({ '")', "\treturn err", "}" }),
  }),
})

ls.add_snippets("typescript", {
  s("trycatch", {

    t({ "try {", "\t ", "} catch (error) {", "\tconsole.log(`" }),
    i(1),
    t({ " error is ->`,error);", "}" }),
  }),
})
