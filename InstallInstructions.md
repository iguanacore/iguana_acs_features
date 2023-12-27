# Install instructions

There are multiple ways to install the mod, depending on how familiar one is with GitHub or any alternative version control platform.

## Beginner method - Steam Workshop

The easiest method is to subscribe to a Steam Workshop mirror. Just like any other workshop mod, it should be clear enough. Just pay attention to the mod loading order, and ensure that the prerequisite mods are available **and** activated.

## Intermediate method - Manual Download

The middle of the road in complexity, and a requirement for anyone without access to the Workshop, a manual download.

For the full release versions:
* Download the zipped archive under [releases](https://github.com/iguanacore/iguana_acs_features/releases)
* Extract the archive contents into `ACS Install Directory\Mods`
* After ensuring the proper mod loading order in Mod Manager, Activate the Mod
* Restart the game to ensure that the Assemblies are properly loaded 

If there have been further contributions after a release, it's also possible to download the unmarked preview version. These versions may not be fully tested, but they can contain additional aspects if you're after the cutting edge experience.

For the preview versions:
* Download a ZIP of the repository, listed under [Code](https://github.com/iguanacore/iguana_acs_features/archive/refs/heads/main.zip)
* Extract the archive contents into `ACS Install Directory\Mods`
* Rename the Folder according to info.json
  * In this case, turning `ACS Install Directory\Mods\iguana_acs_features-main` into  `ACS Install Directory\Mods\iguana_acs_features`
* After ensuring the proper mod loading order in Mod Manager, Activate the Mod
* Restart the game to ensure that the Assemblies are properly loaded

## Advanced method - Git Cloning

Iguana's ACS suite is built as a set of distributable mods. Each repository is technically a stand-alone mod ready for direct usage. As a result, cloning the repository directly into `ACS Install Directory\Mods\iguana_acs_features` will work, no matter which method of version control you use.

The Author uses a combination of [Github Desktop](https://desktop.github.com/) together with [Visual Studio Code](https://code.visualstudio.com/download), but anything with git related functionalities will work.