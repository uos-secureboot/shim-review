Make sure you have provided the following information:

 - [X] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag
   https://github.com/endlessm/shim-review/tree/endless-shim-x64-20200819
 - [X] completed README.md file with the necessary information
   https://github.com/endlessm/shim-review/blob/endless-shim-x64-20200819/README.md
 - [X] shim.efi to be signed
   https://github.com/endlessm/shim-review/blob/endless-shim-x64-20200819/shimx64.efi
 - [X] public portion of your certificate embedded in shim (the file passed to VENDOR_CERT_FILE)
   https://github.com/endlessm/shim-review/blob/endless-shim-x64-20200819/endless-uefi-ca.der
 - [X] any extra patches to shim via your own git tree or as files
   The last 21 commits on https://github.com/endlessm/shim/commits/master.
 - [X] any extra patches to grub via your own git tree or as files
   The grub source code we use can be found on the master branch of
   https://github.com/endlessm/grub. We are based on tag grub-2.04 from
   upstream, and Debian's package version 2.04-9.
 - [X] build logs
   https://github.com/endlessm/shim-review/blob/endless-shim-x64-20200819/logs.txt


###### What organization or people are asking to have this signed:
Endless OS Foundation LLC
https://endlessos.org/

###### What product or service is this for:
Endless OS.

###### What is the origin and full version number of your shim?
Our code is based on upstream commit `a4a1fbe7`, plus the same patches shipped
by Ubuntu on version `15+1552672080.a4a1fbe-0ubuntu2` and a few
Endless-specific changes to the fallback program. The packaging bits are based
on the packaging from Ubuntu, version `15+1552672080.a4a1fbe-0ubuntu2`. The
full version of our package is `15+dev76.f60ba43-13`.

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
Endless OS is a Linux distribution available for anyone to download on
https://endlessos.com/download/ and also shipped with computers sold directly
by us and by our OEM partners like Asus and Acer.

###### How do you manage and protect the keys used in your SHIM?
We have generated our own secure boot CA private key which is stored offline
with physical security protection and only accessed to provision new signing
keys. The CA public key is the one present in the shim binary. The signing keys
which are used in our build servers to sign the bootloader and kernel are
stored on J3A081 80K smartcard HW encryption devices. This is based on the
procedure described at
https://fedoraproject.org/wiki/User:Pjones/SecureBootSmartCardDeployment

###### Do you use EV certificates as embedded certificates in the SHIM?
No.

###### What is the origin and full version number of your bootloader (GRUB or other)?
We use GRUB2 as the bootloader, with Debian's package version 2.04-9 as base,
including their downstream patches.

The GRUB2 source code we use can be found at https://github.com/endlessm/grub,
on branches master (for code) and debian-master (for packaging). Our master
branch is based on tag grub-2.04 from upstream.

###### If your SHIM launches any other components, please provide further details on what is launched
Our shim does not load any other components.

###### How do the launched components prevent execution of unauthenticated code?
N/A.

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
No, the GRUB version we ship does not allow loading unsigned kernels under
secure boot. The `linux` loader in our grub EFI binary always hands-off loading
to the `linuxefi` module, which verifies the kernel via the shim protocol under
secure boot.

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
We are based on Ubuntu's kernel 5.4.0-42.46, which in includes the most recent
fixes for secure boot enforcement.

###### What changes were made since your SHIM was last signed?
Rebased on a newer upstream version. All signing certificates used to sign
previous versions of GRUB or the Linux kernel are being included in shim's
internal `vendor_dbx`, via the build-time macro `VENDOR_DBX_FILE`.

###### What is the hash of your final SHIM binary?
4a2f9d9c740c0b7b3c3e0450281bdd024e7a1e24323b42458dadb0443b88a36f  shimx64.efi
