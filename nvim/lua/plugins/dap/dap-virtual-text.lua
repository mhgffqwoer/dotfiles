local M = {}

M.opts = {
	enabled = true,                        -- включить этот плагин (по умолчанию включен)
    enabled_commands = true,               -- создать команды: DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (и DapVirtualTextForceRefresh для ручного обновления, если адаптер отладки не сообщил о завершении)
    highlight_changed_variables = false,    -- подсвечивать изменившиеся значения с помощью `NvimDapVirtualTextChanged`, иначе всегда использовать `NvimDapVirtualText`
    highlight_new_as_changed = false,      -- подсвечивать новые переменные так же, как и изменённые (если включена `highlight_changed_variables`)
    show_stop_reason = true,               -- показывать причину остановки при исключениях
    commented = false,                     -- добавлять префикс комментария к виртуальному тексту
    only_first_definition = false,          -- показывать виртуальный текст только на первом определении переменной (если их несколько)
    all_references = false,                -- показывать виртуальный текст на всех ссылках переменной, а не только на определениях
    clear_on_continue = false,             -- очищать виртуальный текст при команде "continue" (может вызывать мерцание при пошаговой отладке)
    
    display_callback = function(variable, buf, stackframe, node, options)
		local name = variable.name or ""
		local value = variable.value or ""

		value = value:gsub("github%.com/[^%s{}()]*/", "")
		value = value:gsub("%s+", " ")
		local full_text = name .. ' = ' .. value

		return full_text
    end,

    -- позиция виртуального текста, см. `:h nvim_buf_set_extmark()`, по умолчанию текст будет встроен. Используйте 'eol', чтобы разместить его в конце строки
    virt_text_pos = 'eol',
	separator = ', ',

    -- экспериментальные функции:
    all_frames = true,                    -- отображать виртуальный текст для всех стеков вызовов, а не только текущего (работает только с debugpy у автора)
    virt_lines = true,                    -- отображать виртуальные строки вместо виртуального текста (может мерцать!)
    virt_text_win_col = nil                -- зафиксировать позицию виртуального текста по колонке окна (начиная с первой текстовой колонки),
                                           -- например, 80 — чтобы закрепить текст в 80-й колонке, см. `:h nvim_buf_set_extmark()`
}

return M