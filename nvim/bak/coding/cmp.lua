local Icons = require("core.icons")

return {
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		version = false,
		--event = { "InsertEnter", "CmdlineEnter" },
		event = "VimEnter",
		dependencies = {
			"mfussenegger/nvim-jdtls",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = function()
			local cmp = require("cmp")
			local defaults = require("cmp.config.default")()
			local monokai_opts = Utils.plugin.opts("monokai-pro.nvim")
			local auto_select = true

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(), -- TODO
				sources = { { name = "buffer" } },
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(), -- TODO
				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})
			cmp.setup.filetype("java", { completion = { keyword_length = 2 } })
			return {
				window = vim.tbl_contains(monokai_opts.background_clear or {}, "float_win") and {
					completion = cmp.config.window.bordered({ border = "rounded" }),
					documentation = cmp.config.window.bordered({ border = "rounded" }),
				} or nil,
				performance = {
					fetching_timeout = 1,
				},
				completion = {
					completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
				},
				preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<Down>"] = cmp.mapping(
						cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
						{ "i", "c" }
					),
					["<Up>"] = cmp.mapping(
						cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
						{ "i", "c" }
					),
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<Esc>"] = cmp.mapping(function(fallback)
						require("luasnip").unlink_current()
						fallback()
					end),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer", keyword_length = 3 },
					{ name = "path" },
					{ name = "luasnip", keyword_length = 2 },
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, item)
						item.menu = ({
							codeium = "Codeium",
							copilot = "Copilot",
							nvim_lsp = item.kind,
							luasnip = "Snippet",
							buffer = "Buffer",
							path = "Path",
						})[entry.source.name]
						if Icons.kinds[item.kind] then
							item.kind = Icons.kinds[item.kind]
						end
						local brain_kind = Icons.brain[entry.source.name]
						if brain_kind then
							local hl_gr =
								require("tools.string").capitalize("CmpItemKind" .. Utils.string.capitalize(entry.source.name))
							item.kind = brain_kind
							item.kind_hl_group = hl_gr
							vim.api.nvim_set_hl(0, hl_gr, { fg = Icons.colors.brain[entry.source.name] })
						end
						return item
					end,
				},
				experimental = { ghost_text = false },
				sorting = defaults.sorting,
			}
		end,
		config = function(_, opts)
			local cmp = require("cmp")
			cmp.setup(opts)
			cmp.event:on("confirm_done", function(event)
				if vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
					Utils.cmp.auto_brackets(event.entry)
				end
			end)
		end,
	},
}