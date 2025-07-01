return {
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
    config = function()
      -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
      local java_path = string.gsub(vim.fn.system '/usr/libexec/java_home -v 21', '\n$', '')
      java_path = java_path .. '/bin/java'

      local jdtls_path = string.gsub(vim.fn.system 'which jdtls', '\n$', '')
      local jdtls_launcher_path = jdtls_path .. '/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'
      local jdtls_system_config_path = jdtls_path .. '/config_mac'

      local config = {
        -- The command that starts the language server
        -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
        cmd = {

          -- 💀
          -- This command works only on MacOS
          java_path, -- or '/path/to/java21_or_newer/bin/java'
          -- depends on if `java` is in your $PATH env variable and if it points to the right version.

          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xmx1g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens',
          'java.base/java.util=ALL-UNNAMED',
          '--add-opens',
          'java.base/java.lang=ALL-UNNAMED',

          -- 💀
          '-jar',
          jdtls_launcher_path,

          -- 💀
          '-configuration',
          jdtls_system_config_path,
          -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
          -- Must point to the                      Change to one of `linux`, `win` or `mac`
          -- eclipse.jdt.ls installation            Depending on your system.

          -- 💀
          -- See `data directory configuration` section in the README
          '-data',
          '/path/to/unique/per/project/workspace/folder',
        },

        -- 💀
        -- This is the default if not provided, you can remove it. Or adjust as needed.
        -- One dedicated LSP server & client will be started per unique root_dir
        --
        -- vim.fs.root requires Neovim 0.10.
        -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
        root_dir = vim.fs.root(0, { '.git', 'mvnw', 'gradlew' }),

        -- Here you can configure eclipse.jdt.ls specific settings
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- for a list of options
        settings = {
          java = {},
        },

        -- Language server `initializationOptions`
        -- You need to extend the `bundles` with paths to jar files
        -- if you want to use additional eclipse.jdt.ls plugins.
        --
        -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
        --
        -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
        init_options = {
          bundles = {},
        },
      }
      -- This starts a new client & server,
      -- or attaches to an existing client & server depending on the `root_dir`.
      require('jdtls').start_or_attach(config)
    end,
  },
}
