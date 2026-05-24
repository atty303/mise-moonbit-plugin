local function get_platform()
    -- RUNTIME object is provided by mise/vfox
    -- RUNTIME.osType: "Windows", "Linux", "Darwin"
    -- RUNTIME.archType: "amd64", "386", "arm64", etc.

    local os_name = RUNTIME.osType:lower()
    local arch = RUNTIME.archType

    -- Map to your tool's platform naming convention
    -- Adjust these mappings based on how your tool names its releases
    local platform_map = {
        ["darwin"] = {
            ["arm64"] = "darwin-aarch64",
        },
        ["linux"] = {
            ["amd64"] = "linux-x86_64",
            ["arm64"] = "linux-aarch64",
        },
        ["windows"] = {
            ["amd64"] = "windows-x86_64",
        },
    }

    local os_map = platform_map[os_name]
    if os_map then
        return os_map[arch] or "linux-amd64" -- fallback
    end

    -- Default fallback
    return "linux-amd64"
end

--- Returns download information for a specific version
--- Documentation: https://mise.jdx.dev/tool-plugin-development.html#preinstall-hook
--- @param ctx {version: string, runtimeVersion: string} Context
--- @return table Version and download information
function PLUGIN:PreInstall(ctx)
    local version = ctx.version
    -- ctx.runtimeVersion contains the full version string if needed

    -- Example 1: Simple binary download
    -- local url = "https://github.com/<GITHUB_USER>/<GITHUB_REPO>/releases/download/v" .. version .. "/<TOOL>-linux-amd64"

    -- Example 2: Platform-specific binary
    -- local platform = get_platform() -- Uncomment the helper function below
    -- local url = "https://github.com/<GITHUB_USER>/<GITHUB_REPO>/releases/download/v" .. version .. "/<TOOL>-" .. platform

    -- Example 3: Archive (tar.gz, zip) - mise will extract automatically
    -- local url = "https://github.com/<GITHUB_USER>/<GITHUB_REPO>/releases/download/v" .. version .. "/<TOOL>-" .. version .. "-linux-amd64.tar.gz"

    -- Example 4: Raw file from repository
    -- local url = "https://raw.githubusercontent.com/<GITHUB_USER>/<GITHUB_REPO>/" .. version .. "/bin/<TOOL>"

    -- Replace with your actual download URL pattern
    local target = get_platform()
    local url = "https://cli.moonbitlang.com/binaries/" .. version .. "/moonbit-" .. target .. ".tar.gz"

    -- Optional: Fetch checksum for verification
    local http = require("http")
    -- GET request
    local resp, err = http.get({
        url = url .. ".sha256",
        headers = {
            ["User-Agent"] = "mise-plugin",
        },
    })
    if err ~= nil then
        error("Request failed: " .. err)
    end
    if resp.status_code ~= 200 then
        error("HTTP error: " .. resp.status_code)
    end

    local sha256 = resp.body:match("^(^%S+)")

    return {
        version = version,
        url = url,
        sha256 = sha256, -- Optional but recommended for security
        note = "Downloading moonbit " .. version,
        -- addition = { -- Optional: download additional components
        --     {
        --         name = "core",
        --         url = "https://cli.moonbitlang.com/cores/core-" .. version .. ".tar.gz"
        --     }
        -- }
    }
end
