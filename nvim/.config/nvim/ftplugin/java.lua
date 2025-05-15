local system = "linux"
if vim.fn.has("win32") then
    system = "win"
elseif vim.fn.has("mac") then
    system = "mac"
end

local home = os.getenv("HOME")
local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local workspace_dir = home .. "/.cache/jdtls/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local equinox_path = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("jdtls").start_or_attach({
    cmd = {
        -- 💀
        "java", -- or '/path/to/java21_or_newer/bin/java'

        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        -- 💀
        "-jar",
        equinox_path,

        -- 💀
        "-configuration",
        jdtls_path .. "/config_" .. system,

        -- 💀
        -- See `data directory configuration` section in the README
        "-data",
        workspace_dir,
    },

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    --
    -- vim.fs.root requires Neovim 0.10.
    -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
    root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "build.xml" }),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            server = { launchMode = "Hybrid" },
            eclipse = {
                downloadSources = true,
            },
            maven = {
                downloadSources = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            implementationsCodeLens = {
                enabled = false,
            },
            referenceCodeLens = {
                enabled = false,
            },
            inlayHints = {
                parameterNames = {
                    enabled = "none",
                },
            },
            signatureHelp = {
                enabled = true,
                description = {
                    enabled = true,
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
        },
        redhat = { telemetry = { enabled = false } },
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = vim.split(
            vim.fn.glob("$HOME/.local/share/nvim/mason/packages/java-*/extension/server/*.jar", true),
            "\n"
        ),
    },
    capabilities = capabilities,
})
