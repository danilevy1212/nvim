require('dan.lib.lsp').setup_lsp_server('nixd', {
    cmd = { 'nixd' },
    settings = {
        nixd = {
            nixpkgs = {
                expr = 'import <nixpkgs> { }',
            },
            formatting = {
                command = { 'alejandra' },
            },
            options = {
                nixos = {
                    expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.bootse.options',
                },
                home_manager = {
                    expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."bootse@dlevym".options',
                },
            },
        },
    },
})
