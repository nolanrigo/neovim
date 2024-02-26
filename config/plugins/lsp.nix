{
  plugins.lsp = {
    enable = true;
    servers = {
      # webdev
      tsserver.enable = true;
      graphql.enable = true;
      eslint.enable = true;
      tailwindcss.enable = true;

      # Infra
      yamlls.enable = true;
      nil_ls.enable = true;
    };
  };
}
