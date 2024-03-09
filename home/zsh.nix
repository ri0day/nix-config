{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    initExtra = ''
      eval "$(direnv hook zsh)"
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      source <(kubectl completion zsh)
    '';

    shellAliases = {
      k = "kubectl";
      tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };
}
