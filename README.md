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
Endless OS Foundation LLC
https://endlessos.org/

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
Upstream commit `a4a1fbe7`.

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/endlessm/shim/, branch `master`, commit hash `f60ba438`.

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
We are applying the same patches applied by Ubuntu on version
`15+1552672080.a4a1fbe-0ubuntu2` plus a few Endless-specific patches to the
fallback program. No Endless-specific patches change the shim binary.

The full list of commits can be found below:

From Ubuntu's `15+1552672080.a4a1fbe-0ubuntu2`:

- `13631c19 [UBUNTU] Fix OBJ_create() to tolerate a NULL sn and ln`
- `36170184 [UBUNTU] MokManager: avoid -Werror=address-of-packed-member`
- `f3b3734d [UBUNTU] tpm: Define EFI_VARIABLE_DATA_TREE as packed`
- `02c285b8 [UBUNTU] tpm: Fix off-by-one error when calculating event size`
- `9a5c7e0e [UBUNTU] tpm: Don't log duplicate identical events`
- `21598b93 [UBUNTU] MokManager: console mode modification for hi-dpi screen devices`
- `a5c0630a [UBUNTU] Fix a use of strlen() instead of Strlen()`

One small code improvement that removes an un-necessary call to StrLen:

- `b71ce459 fallback: Store label size instead of calculating on every use`

One patch to make fallback check all boot variables instead of only the numbers
listed in BootOrder when looking for duplicates, to address a problem where the
firmware re-generates BootOrder every boot to only including its pre-determined
boot entries, but still leaving user-created boot entries intact (only removing
them from BootOrder):

- `393df2f4 fallback: Consider all Boot* vars when checking for duplicates`

Two patches to make fallback silent by default so we get a flicker-free
experience on the fallback path as well:

- `117a7291 fallback: Only use VerbosePrint for debug messages`
- `3d3327d0 fallback: Be silent by default`

Four patches to improve the debug output from the fallback binary:

- `0e06758c fallback: Print original BootOrder value in verbose mode`
- `6cd6a597 fallback: Wait before chainloading as well in verbose mode`
- `5cce553a fallback: Make verbose mode's wait time configurable`
- `81a7cffe fallback: Allow defining FALLBACK_VERBOSE at build time`

One patch to always chain-load the newly created boot entry instead of
rebooting the system to avoid a reboot loop on firmwares that re-generate
BootOrder every boot to only including their pre-determined boot entries:

- `af56d403 [Endless] fallback: Always try to chain-load the first entry`

A set of changes to have fallback treat boot entries with the same label as
duplicates, and remove any entries that are a duplicate of the entry we are
about to create from the CSV file in the fallback path. This is necessary for
Endless OS because randomize the partition ids during the first boot, since the
partition layout is created by the server at image build time and the image in
simply dd'ed to the disk during installation. We explicitly do not support have
two Endless OS installations side-by-side on the same machine, even on
different disks, so the added restriction of not allowing to boot entries with
the same name is not a problem for us:

- `acb37f45 [Endless] Partially revert "fallback: work around the issue of boot option creation with AMI BIOS"`
- `681aa66f [Endless] fallback: Clean-up duplicate boot entries`
- `e1e66a48 [Endless] fallback: Use a dynamic buffer when list var names`
- `be188ca9 [Endless] fallback: Print info on GetNextVariableName errors`
- `f60ba438 [Endless] fallback: Do not remove vars while listing var names`

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
This was manually built on Debian Buster, to make it possible to reproduce,
since we currently don't make development tools publicly available on Endless
OS. The versions of gcc, binutils and gnu-efi are listed bellow.

- gcc 8.3.0-6
- binutils 2.31.1-16
- gnu-efi 3.0.9-1

Inspired by Debian's submission, we are providing a Dockerfile in this repo
that can be used to reproduce the build pulling all dependencies from the
Debian repositories -- instructions are availabled in BUILDING.txt.

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
https://github.com/endlessm/shim-review/blob/endless-shim-x64-20200819/logs.txt

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
The `debian` directory with the package building recipes and scripts, vendor
certificate, vendor DBX contents etc, is available at
https://github.com/endlessm/shim/commits/debian-master, commit `ce6ec5cd`.

The code and packaging up for review here are based on the same code up for
review at https://github.com/rhboot/shim-review/issues/92. The Endless-specific
patches listed here are also present on shim images previously signed by
Microsoft and shipped with our current releases.

Our previous community review request can be found at
https://github.com/rhboot/shim-review/issues/61.
