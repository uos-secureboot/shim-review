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
Wuhan Deepin Technology Co., Ltd.

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
Deepin V20.

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
Deepin is yet another linux distribution based on Debian GNU/Linux. It has been actively maintained since 2011.
Deepin has kept in the top 20 on distrowatch for last few years.
It is an amazing distribution, and for compatible reason, we here submit our siging request for shim.

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Zhang Shuang
- Position: Senior Director
- Email address: zhangshuang@deepin.com

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Li chenggang
- Position: Developer
- Email address: lichenggang@deepin.org

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
Upstream 15.4.

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
N/A

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
Deepin V20 : http://cdimage.deepin.com/releases/20/deepin-desktop-community-1002-amd64.iso
GCC: 8.3.0
Binutils: 2.31.1
GNU-Efi: 3.0.9
All above packages can install by command: `sudo apt install build-essential gnu-efi` in Deepin V20  with an internet connection.
After installation of Deepin V20 , it is recommended to update the whole system to get up-to-date packages and functions by executing command: `sudo apt update && sudo apt upgrade`.

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
https://github.com/deepin-secureboot/shim-review/blob/deepin-shim-15.4/logs.txt

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
N/A
