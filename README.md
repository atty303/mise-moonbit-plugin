# moonbit tool plugin for mise

> [!WARNING]
> This is a work in progress. I'm new to moonbit, I can't verify the correctness of the installation process.
> I'm only testing the installation process on my linux machine.

This is a mise tool plugin for [MoonBit CLI Tools](https://www.moonbitlang.com/).

It is an alternative to install moonbit via [shell script](https://cli.moonbitlang.com/install/unix.sh). 

## Development Workflow

### Setting up development environment

1. Install pre-commit hooks (optional but recommended):
```bash
hk install
```

This sets up automatic linting and formatting on git commits.

### Local Testing

1. Link your plugin for development:
```bash
mise plugin link --force <TOOL> .
```

2. Run tests:
```bash
mise run test
```

3. Run linting:
```bash
mise run lint
```

4. Run full CI suite:
```bash
mise run ci
```

### Code Quality

This template uses [hk](https://hk.jdx.dev) for modern linting and pre-commit hooks:

- **Automatic formatting**: `stylua` formats Lua code
- **Static analysis**: `luacheck` catches Lua issues
- **GitHub Actions linting**: `actionlint` validates workflows
- **Pre-commit hooks**: Runs all checks automatically on git commit

Manual commands:
```bash
hk check      # Run all linters (same as mise run lint)
hk fix        # Run linters and auto-fix issues
```

### Debugging

Enable debug output:
```bash
MISE_DEBUG=1 mise install <TOOL>@latest
```

## Files

- `metadata.lua` – Plugin metadata and configuration
- `hooks/available.lua` – Returns available versions from upstream
- `hooks/pre_install.lua` – Returns artifact URL for a given version
- `hooks/post_install.lua` – Post-installation setup (permissions, moving files)
- `hooks/env_keys.lua` – Environment variables to export (PATH, etc.)
- `.github/workflows/ci.yml` – GitHub Actions CI/CD pipeline
- `mise.toml` – Development tools and configuration
- `mise-tasks/` – Task scripts for testing
- `hk.pkl` – Modern linting and pre-commit hook configuration
- `.luacheckrc` – Lua linting configuration
- `stylua.toml` – Lua formatting configuration

### Checksum Verification
```lua
-- In pre_install.lua, return sha256
return {
    version = version,
    url = url,
    sha256 = "abc123...",  -- Optional but recommended
}
```

### Error Handling
```lua
if err ~= nil then
    error("Failed to fetch versions: " .. err)
end

if resp.status_code ~= 200 then
    error("API returned status " .. resp.status_code)
end
```

## Documentation

Refer to the mise docs for detailed information:

- [Tool plugin development](https://mise.jdx.dev/tool-plugin-development.html) - Complete guide to plugin development
- [Lua modules reference](https://mise.jdx.dev/plugin-lua-modules.html) - Available Lua modules and functions
- [Plugin publishing](https://mise.jdx.dev/plugin-publishing.html) - How to publish your plugin
- [mise-plugins organization](https://github.com/mise-plugins) - Community plugins repository

## Publishing

1. Ensure all tests pass: `mise run ci`
2. Create a GitHub repository for your plugin
3. Push your code
4. (Optional) Request to transfer to [mise-plugins](https://github.com/mise-plugins) organization
5. Add to the [mise registry](https://github.com/jdx/mise/blob/main/registry.toml) via PR

## License

MIT