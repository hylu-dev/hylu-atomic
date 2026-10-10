#!/usr/bin/env bash

# Give /nix proper SELinux labels. Without rules, everything under /nix is
# default_t, and systemd (init_t) is denied creating nix-daemon.socket there.
# These match the Determinate Nix installer's SELinux setup.
set -oue pipefail

# nix.mount binds /var/lib/nix over /nix; label the backing directory as if it
# were /nix so restorecon on either path agrees.
semanage fcontext -a -e /nix /var/lib/nix

semanage fcontext -a -t etc_t '/nix/store/[^/]+/etc(/.*)?'
semanage fcontext -a -t lib_t '/nix/store/[^/]+/lib(/.*)?'
semanage fcontext -a -t systemd_unit_file_t '/nix/store/[^/]+/lib/systemd/system(/.*)?'
semanage fcontext -a -t man_t '/nix/store/[^/]+/man(/.*)?'
semanage fcontext -a -t bin_t '/nix/store/[^/]+/s?bin(/.*)?'
semanage fcontext -a -t usr_t '/nix/store/[^/]+/share(/.*)?'
semanage fcontext -a -t var_run_t '/nix/var/nix/daemon-socket(/.*)?'
semanage fcontext -a -t usr_t '/nix/var/nix/profiles(/per-user/[^/]+)?/[^/]+'
