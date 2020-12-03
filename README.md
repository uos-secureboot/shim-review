This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your branch

Note that we really only have experience with using grub2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
Uniontech Technology Co., Ltd.

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
UOS.

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
UOS is yet another linux distribution based on Debian GNU/Linux. It has been actively maintained since 2019.
It is an amazing distribution, and for compatible reason, we here submit our siging request for shim.

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Zhang Shuang
- Position: Senior Director
- Email address: zhangshuang@uniontech.com

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Zhang Yueqian
- Position: Senior Developer
- Email address: zhangyueqian@uniontech.com

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
Upstream commit a4a1fbe7.

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/uos-secureboot/shim, branch master, commit hash f60ba438.

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
N/A

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
UOS : https://www.uniontech.com/next/product/desktop-system?edition=Professional
GCC: 8.3.0
Binutils: 2.31.1
GNU-Efi: 3.0.9
All above packages can install by command: `sudo apt install build-essential gnu-efi` in UOS  with an internet connection.
After installation of UOS, it is recommended to update the whole system to get up-to-date packages and functions by executing command: `sudo apt update && sudo apt upgrade`.

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
https://github.com/uos-secureboot/shim-review/blob/uos-shim/logs.txt

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
N/A
