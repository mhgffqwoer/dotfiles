local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep

return {
	s("algo", {
		t("package main"),
		t({ "", "" }),
		t({ "", "import (" }),
		t({ "", "\t\"testing\"" }),
		t({ "", ")" }),
		t({ "", "" }),
		t({ "", "func Task_" }), i(1, "Number"), t("("), i(2, "args"), t(" "), i(3, "T"), t(") "), i(4, "T"), t(" {"),
		t({ "", "\t" }), i(5, ""),
		t({ "", "}" }),
		t({ "", "" }),
		t({ "", "func Test_" }), rep(1), t("(t *testing.T) {"),
		t({ "", "\ttestCases := []struct {" }),
		t({ "", "\t\tname string" }),
		t({ "", "\t\t" }), rep(2), t(" "), rep(3),
		t({ "", "\t\twant " }), rep(4),
		t({ "", "" }),
		t({ "", "\t}{" }),
		t({ "", "\t\t{" }),
		t({ "", "\t\t\tname: \"1\"," }),
		t({ "", "\t\t\t" }), rep(2), t(": ,"),
		t({ "", "\t\t\twant: ," }),
		t({ "", "" }),
		t({ "", "\t\t}," }),
		t({ "", "\t}" }),
		t({ "", "\tfor _, tC := range testCases {" }),
		t({ "", "\t\tt.Run(tC.name, func(t *testing.T) {" }),
		t({ "", "\t\t\tgot := Task_"}), rep(1), t("(tS."), rep(2), t(")"),
		t({ "", "\t\t\tif got != tC.want {"}),
		t({ "", "\t\t\t\tt.Errorf(\"want: %v, got: %v\", tC.want, got)"}),
		t({ "", "\t\t\t}"}),
		t({ "", "\t\t})" }),
		t({ "", "\t}" }),
		t({ "", "}" }),
	}),
}
