# hylu-atomic

A minimal Fedora Atomic image with [Niri](https://github.com/YaLTeR/niri), [Noctalia Shell](https://github.com/noctalia-dev/noctalia), and [Noctalia Greeter](https://github.com/noctalia-dev/noctalia-greeter), built for Nvidia hardware using [BlueBuild](https://blue-build.org/).

Built from [`ghcr.io/ublue-os/base-main`](https://github.com/ublue-os/main), with Nvidia drivers (`nvidia-open`) added via the `akmods` module.

## Installation

> [!WARNING]
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation onto this image, use whichever tool your system has: `bootc` (modern bootc-native systems) or `rpm-ostree` (classic ostree-based systems).

### Using bootc

- Switch to the image:
  ```
  sudo bootc switch ghcr.io/hylu-dev/hylu-atomic:latest
  ```
- Reboot to complete the switch:
  ```
  systemctl reboot
  ```
- On future updates, just run:
  ```
  sudo bootc upgrade
  systemctl reboot
  ```

By default, `bootc switch` does not enforce cosign signature verification. To require it (see [Verification](#verification) below for the corresponding public key), add `--enforce-container-sigpolicy`.

### Using rpm-ostree

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/hylu-dev/hylu-atomic:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/hylu-dev/hylu-atomic:latest
  ```
- Reboot again to complete the installation:
  ```
  systemctl reboot
  ```
- On future updates, just run:
  ```
  rpm-ostree upgrade
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## ISO

If built on Fedora Atomic, you can generate an offline ISO with the instructions available [here](https://blue-build.org/how-to/generate-iso/#_top). These ISOs cannot unfortunately be distributed on GitHub for free due to large sizes, so for public projects something else has to be used for hosting.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/hylu-dev/hylu-atomic
```
