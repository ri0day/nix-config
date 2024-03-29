"""
  Set proxy for nix-daemon to speed up downloads
  You can safely ignore this file if you don't need a proxy.

  https://github.com/NixOS/nix/issues/1472#issuecomment-1532955973
"""
import os
import sys
import plistlib
import shlex
import subprocess
from pathlib import Path


NIX_DAEMON_PLIST = Path("/Library/LaunchDaemons/org.nixos.nix-daemon.plist")
NIX_DAEMON_NAME = "org.nixos.nix-daemon"
# http proxy provided by clash or other proxy tools
HTTP_PROXY = sys.argv[1]
pl = plistlib.loads(NIX_DAEMON_PLIST.read_bytes())

# set http proxy
pl["EnvironmentVariables"]["HTTP_PROXY"] = HTTP_PROXY
pl["EnvironmentVariables"]["HTTPS_PROXY"] = HTTP_PROXY

# Homebrew Mirror
pl["EnvironmentVariables"].update({
  "HOMEBREW_API_DOMAIN": "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api",
  "HOMEBREW_BOTTLE_DOMAIN": "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles",
  "HOMEBREW_BREW_GIT_REMOTE": "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git",
  "HOMEBREW_CORE_GIT_REMOTE": "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git",
  "HOMEBREW_PIP_INDEX_URL": "https://pypi.tuna.tsinghua.edu.cn/simple",
  "NIX_SSL_CERT_FILE": "/nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt"
})

os.chmod(NIX_DAEMON_PLIST, 0o644)
NIX_DAEMON_PLIST.write_bytes(plistlib.dumps(pl))
os.chmod(NIX_DAEMON_PLIST, 0o444)

# reload the plist
for cmd in (
	f"launchctl unload {NIX_DAEMON_PLIST}",
	f"launchctl load {NIX_DAEMON_PLIST}",
):
    print(cmd)
    subprocess.run(shlex.split(cmd), capture_output=False)
print("you may also need add proxy settings in /nix/store/*-builer.sh which use curl download files")
print("for example: sudo vim  /nix/store/g0gn91m56b267ncx05w93kihyqia39cm-builder.sh , add curl -x http://xxx:7890 ")
