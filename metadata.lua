-- metadata.lua
-- Plugin metadata and configuration
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#metadata-lua

PLUGIN = { -- luacheck: ignore
    -- Required: Tool name (lowercase, no spaces)
    name = "moonbit",

    -- Required: Plugin version (not the tool version)
    version = "0.1.0",

    -- Required: Brief description of the tool
    description = "A mise tool plugin for moonbit",

    -- Required: Plugin author/maintainer
    author = "atty303",

    -- Optional: Repository URL for plugin updates
    updateUrl = "https://github.com/atty303/mise-moonbit-plugin",

    -- Optional: Minimum mise runtime version required
    minRuntimeVersion = "0.2.0",

    -- Optional: Legacy version files this plugin can parse
    -- legacyFilenames = {
    --     ".<TOOL>-version",
    --     ".<TOOL>rc"
    -- }
}
