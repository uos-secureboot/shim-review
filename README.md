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
Endless Mobile, Inc.
https://endlessos.com/

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
Endless OS.

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
Endless OS is a Linux distribution available for anyone to download on
https://endlessos.com/download/ and also shipped with computers sold directly
by us and by our OEM partners like Asus and Acer.

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Robert McQueen
- Position: Chief of Engineering
- Email address: rob@endlessm.com
- PGP key, signed by the other security contacts, and preferably also with
  signatures that are reasonably well known in the linux community:
  `F864269C9010B282EE51BD607F94998DE06F63B5`

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Will Thompson
- Position: Senior Software Engineer
- Email address: wjt@endlessm.com
- PGP key, signed by the other security contacts, and preferably also with
  signatures that are reasonably well known in the linux community:
  `1E68E58CF255888301645B563422DC0D7AD482A7`

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
Upstream tag `15`, commit hash `51413d1deb0df0debdf1d208723131ff0e36d3a3`.
https://github.com/rhboot/shim/tree/15

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/endlessm/shim/commits/master
Branch `master`, commit hash `b59aab6e1e011e02bcc0cbbe53e050a010244797`.

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
There are no patches that change the behavior of the shim binary.

There is one patch to remove the use of `git` in the build process because our
build servers start from a distribuition tarball which does not contain the
`.git` directory: `af37fc2 Makefile: Don't use git for cleaning`.

All other patches only affect the fallback binary.

- Two patches to make fallback silent by default so we get a flicker-free
  experience on the fallback path as well.
  `cc162f1 fallback: Only use VerbosePrint for debug messages`
  `025982a fallback: Be silent by default`

- Four patches to make the process of debugging the fallback binary easier.
  `5cc4d65 fallback: Allow defining FALLBACK_VERBOSE at build time`
  `3ea2c3a fallback: Wait before chainloading as well in verbose mode`
  `3455285 fallback: Make verbose mode's wait time configurable`
  `bf2915d fallback: Print original BootOrder value in verbose mode`

- One patch to make fallback check all boot variables instead of only the
  numbers listed in BootOrder when looking for duplicates, to address a problem
  where the firmware re-generates BootOrder every boot to only including its
  pre-determined boot entries, but still leaving user-created boot entries
  intact (only removing them from BootOrder).
  `d3a2489 fallback: Consider all Boot* vars when checking for duplicates`

- One patch to always chain-load the newly created boot entry instead of
  rebooting the system to avoid a reboot loop on firmwares that re-generate
  BootOrder every boot to only including their pre-determined boot entries.
  `e3513c8 [Endless] fallback: Always try to chain-load the first entry`

- One small code improvement that removes an un-necessary call to StrLen.
  `e26c5b1 fallback: Store label size instead of calculating on every use`

- A set of changes to have fallback treat boot entries with the same label as
  duplicates, and remove any entries that are a duplicate of the entry we are
  about to create from the CSV file in the fallback path. This is necessary for
  Endless OS because randomize the partition ids during the first boot, since
  the partition layout is created by the server at image build time and the
  image in simply dd'ed to the disk during installation. We explicitly do not
  support have two Endless OS installations side-by-side on the same machine,
  even on different disks, so the added restriction of not allowing to boot
  entries with the same name is not a problem for us.
  `3e70ad8 [Endless] Partially revert "fallback: work around the issue of boot option creation with AMI BIOS"`
  `f7c0d9b [Endless] fallback: Clean-up duplicate boot entries`
  `a81b858 [Endless] fallback: Use a dynamic buffer when list var names`
  `cb0b03b [Endless] fallback: Print info on GetNextVariableName errors`
  `f6267f1 [Endless] fallback: Do not remove vars while listing var names`

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
This was manually built on Debian Buster, to make it possible to reproduce,
since we currently don't make development tools publicly available on Endless
OS. The versions of gcc, binutils and gnu-efi are listed bellow.

gcc 8.3.0-4
binutils 2.31.1-15
gnu-efi 3.0.9-1

Inspired by Debian's own submission, we are providing a Dockerfile in this repo
that can be used to reproduce the build pulling all dependencies from the
Debian repositories -- instructions are availabled in BUILDING.txt.

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
https://github.com/endlessm/shim-review/blob/endless-shim-x64-20190410/logs.txt

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
The `debian` directory with the package building recipes and scripts, vendor
certificate included in the shim image etc, is available at
https://github.com/endlessm/shim/commits/debian-master, commit id
`0ca72677098e173e4d48e67d3d7e9344d25f408c`.

We already ship a previous version of shim with same patches listed above,
signed by Microsoft, in our currently available releases.
