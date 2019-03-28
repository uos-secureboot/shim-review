Make sure you have provided the following information:

 - [X] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag
   https://github.com/endlessm/shim-review/tree/endless-shim-x64-20190410
 - [X] completed README.md file with the necessary information
   https://github.com/endlessm/shim-review/blob/endless-shim-x64-20190410/README.md
 - [X] shim.efi to be signed
   https://github.com/endlessm/shim-review/blob/endless-shim-x64-20190410/shimx64.efi
 - [X] public portion of your certificate embedded in shim (the file passed to VENDOR_CERT_FILE)
   https://github.com/endlessm/shim-review/blob/endless-shim-x64-20190410/endless-uefi-ca.der
 - [X] any extra patches to shim via your own git tree or as files
   The last 16 commits on https://github.com/endlessm/shim/commits/master.
 - [X] any extra patches to grub via your own git tree or as files
   The grub source code we use can be found on the master branch of
   https://github.com/endlessm/grub. We are based on tag grub-2.02 from
   upstream.
 - [X] build logs
   https://github.com/endlessm/shim-review/blob/endless-shim-x64-20190410/logs.txt


###### What organization or people are asking to have this signed:
Endless Mobile, Inc.
https://endlessos.com/

###### What product or service is this for:
Endless OS.

###### What is the origin and full version number of your shim?
Our code is based on upstream tag `15` with a few changes to the fallback
program. The packaging bits are based on the packaging from Debian Buster,
`version 0.9+1474479173.6c180c6-1`. The full version of our package is
`15+dev16.b56aab6-7bem1`.

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
We use GRUB as the bootloader, with the Secure Boot patchset from Red Hat /
Fedora which adds integration between GRUB and shim. The grub source code we
use can be found on the master branch of https://github.com/endlessm/grub. We
are based on tag grub-2.02 from upstream.

###### If your SHIM launches any other components, please provide further details on what is launched
Our shim does not load any other components.

###### How do the launched components prevent execution of unauthenticated code?
N/A.

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
No, our grub does not allow loading unsigned kernels when secure boot is
enabled. Our grub EFI binary only includes the `linuxefi` module, which
verifies the kernel via shim, and does not include the `linux` module.

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
Linux 5.0 with secure boot support.

###### What changes were made since your SHIM was last signed?
Rebased on a newer upstream version.

###### What is the hash of your final SHIM binary?
e592a7f77ed424c30c7afa4f79a66346b86ea2246bf1394d386fd180a9aa5f6b  shimx64.efi
