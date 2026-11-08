vim.pack.add { gh "mfussenegger/nvim-jdtls" }

local function project_source_paths(root)
	if not root then
		return nil
	end

	for _, marker in ipairs {
		'pom.xml',
		'build.gradle',
		'build.gradle.kts',
		'settings.gradle',
		'settings.gradle.kts',
		'.project',
		'.classpath',
	} do
		if vim.fn.filereadable(root .. '/' .. marker) == 1 then
			return nil
		end
	end

	if vim.fn.isdirectory(root .. '/src/main/java') == 1 then
		return { 'src/main/java' }
	end

	if vim.fn.isdirectory(root .. '/src') == 1 then
		return { 'src' }
	end
end

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'java',
	callback = function()
		-- ~/.config/nvim/ftplugin/java.lua

		local jdtls = require 'jdtls'
		local jdtls_install = vim.fn.expand '~/.emacs.d/share/eclipse.jdt.ls'

		-- Platform-specific config folder
		local config_dir = (vim.fn.has 'mac' == 1 and 'config_mac')
		or (vim.fn.has 'unix' == 1 and 'config_linux')
		or 'config_win'

		-- One workspace directory per project (required by jdtls)
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
		local workspace_dir = vim.fn.stdpath 'cache' .. '/jdtls-workspace/' .. project_name

		local launcher_jar = vim.fn.glob(
			jdtls_install .. '/plugins/org.eclipse.equinox.launcher_1.8.0.v20260804-1928.jar',
			false,
			true
		)[1]

		local root_dir = require('jdtls.setup').find_root {
			'.git', '.project', '.classpath', 'mvnw', 'gradlew',
			'pom.xml', 'build.gradle', 'build.gradle.kts',
			'settings.gradle', 'settings.gradle.kts',
		}

		local settings = {
			java = {},
		}

		local source_paths = project_source_paths(root_dir)
		if source_paths then
			settings.java.project = {
				sourcePaths = source_paths,
			}
		end

		local config = {
			cmd = {
			  'java',
			  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
			  '-Dosgi.bundles.defaultStartLevel=4',
			  '-Declipse.product=org.eclipse.jdt.ls.core.product',
			  '-Dlog.protocol=true',
			  '-Dlog.level=ALL',
			  '-Xmx1g',
			  '--add-modules=ALL-SYSTEM',
			  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
			  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
			  '-jar', vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
			  '-configuration', jdtls_install .. '/' .. config_dir,
			  '-data', workspace_dir,
			},

			root_dir = root_dir,
			settings = settings,
			init_options = source_paths and { settings = settings } or nil,
		}

		jdtls.start_or_attach(config)
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client and client.name == "jdtls" then
            vim.lsp.semantic_tokens.enable(false, {
                bufnr = args.buf,
                client_id = client.id,
            })
        end
    end,
})
