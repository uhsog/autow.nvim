-- lua/autow/init.lua

local M = {}

-- Default configuration
M.config = {
    enabled = true,
    filetypes = {}, -- Empty table means all filetypes are included by default
    exclude_filenames = {}, -- List of filenames (or patterns) to exclude
}

--- Sets up the autow.nvim plugin with user-defined configurations.
--- @param opts table Configuration options.
---               - `enabled` (boolean): Whether the plugin is initially enabled. Default: true.
---               - `filetypes` (table): List of filetypes to enable autosave for. Empty table includes all. Default: {}.
---               - `exclude_filenames` (table): List of filenames (or glob patterns) to exclude from autosave. Default: {}.
function M.setup(opts)
    opts = opts or {}
    M.config = vim.tbl_deep_extend("force", M.config, opts)

    if M.config.enabled then
        M.enable_autosave()
    else
        M.disable_autosave()
    end

    vim.api.nvim_create_user_command('AutowToggle', function()
        M.toggle_autosave()
    end, { desc = 'Toggle autow.nvim autosave' })

    print("Autow.nvim: Plugin loaded. Autosave is " .. (M.config.enabled and "ON" or "OFF"))
end

--- Enables the autosave functionality.
function M.enable_autosave()
    if M.autocmd_group then
        vim.api.nvim_del_autocmd(M.autocmd_group)
    end

    M.autocmd_group = vim.api.nvim_create_augroup("AutowAutosave", { clear = true })
    vim.api.nvim_create_autocmd("InsertLeave", {
        group = M.autocmd_group,
        callback = function()
            if M.should_autosave() then
                vim.cmd('wa')
            end
        end,
    })
    M.config.enabled = true
    print("Autow.nvim: Autosave ON")
end

--- Disables the autosave functionality.
function M.disable_autosave()
    if M.autocmd_group then
        vim.api.nvim_del_autocmd(M.autocmd_group)
        M.autocmd_group = nil
    end
    M.config.enabled = false
    print("Autow.nvim: Autosave OFF")
end

--- Toggles the autosave functionality.
function M.toggle_autosave()
    if M.config.enabled then
        M.disable_autosave()
    else
        M.enable_autosave()
    end
end

--- Checks if autosave should be performed for the current buffer.
--- @return boolean True if autosave should occur, false otherwise.
function M.should_autosave()
    if not M.config.enabled then
        return false
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local filetype = vim.bo[bufnr].filetype
    local filename = vim.fn.bufname(bufnr)

    -- Check filetype exclusion/inclusion
    if #M.config.filetypes > 0 then
        local found_filetype = false
        for _, ft in ipairs(M.config.filetypes) do
            if ft == filetype then
                found_filetype = true
                break
            end
        end
        if not found_filetype then
            return false -- Filetype not in the allowed list
        end
    end

    -- Check filename exclusion
    for _, exclude_pattern in ipairs(M.config.exclude_filenames) do
        -- Basic glob pattern matching (can be extended if needed)
        if filename:match(exclude_pattern:gsub("%%", "%%%%"):gsub("%.", "%%."):gsub("%*", ".*")) then
            return false -- Filename matches an exclusion pattern
        end
    end
    
    -- Ensure the buffer has a name and is modifiable (not a scratch buffer, etc.)
    if filename == "" or vim.bo[bufnr].modifiable == false or vim.bo[bufnr].readonly == true then
        return false
    end

    return true
end

return M
