# Iguana's Overhaul, features
A mod, consisting of new content for Amazing Cultivation Simulator, not just changes.

## Currently implemented changes

* Focused Feng Shui restoration - Restores the Focused Feng Shui miracle, restores its place in Sixteen Steps. A temporary solution, also adds a Miracle to clear Relic Data.
* Arrogant Obsession Shendao Fix - Adds a stage for the Shendao Laws before the Peak of Attainment, making it possible to get Arrogant multiple times.
* Spiritual Wood Creation - Adds a Miracle for converting regular Trees into Spiritual Trees. Still a Work in Progress.
* Custom Titles - A rework of an existing CN mod, makes it possible to add a custom title for your Disciples.
* Qi Barrier Attachment Mod - Adds 3 new Qi Barrier Attachments, based on a previous fix. Scaled linearly compared to the existing barriers. 

## Install instructions

Download the latest release, extract the iguana_acs_features into the Mods folder. If the release is behind the Main version and you want to update to the preview version, download the repository directly, and extract the contents of the archive into the iguana_acs_features folder, located in the Mods folder.
(Due to the inclusion of Harmony Patches, it's best to stick with the Release.)

Activate the Mod in Mod Manager, make sure to load it after any of the prerequisite Mods.

For ensuring that Patches are loaded, restart the game.

## Compatibility with other mods

The full list of changed entities can be seen at the bottom. This mod does not guarantee compatibility with any of the mods that also change those entities.

### Suggested Load Order

* ModLoaderLite
* **[iguana_acs_fix](https://github.com/iguanacore/iguana_acs_fix)**
* **[iguana_acs_functions](https://github.com/iguanacore/iguana_acs_functions)**
* **[iguana_acs_features](https://github.com/iguanacore/iguana_acs_features)**
* Anything else
* Alternative Translations

## List of changed entities

Below is a list of changed entities. To revert a particular change from the mod, either comment out the relevant lines and entities, or delete the files in question. Changed files in the Language\OfficialEnglish directory are related to translation and can be reverted by removing them.

This **does not** include new entities.

### Laws/Gongs

* All Shendao `Gongs` - Arrogant Obsession Shendao Fix

### Inspiration Trees

 * `Gong1`, Node `Gong1_b2` - Feng Shui Identification, adding of layered Nodes, a part of Focused Feng Shui restoration.

### Scripts

 * `Scripts\Magic\class\Magic_FSItemCreate.lua` - Focused Feng Shui Miracle script, reversed commented out parts, as a part of Focused Feng Shui restoration.

### Functions

Modifications applied by `iguana_acs_features.dll`.

* `Wnd_NpcInfo.SetTitle` - Custom Titles, a prefix.

## List of new entities

### Manuals (Esoterica)

* `Gong1_LvUpEsoterica_9_1` - Focused Feng Shui Reversal, a part of Focused Feng Shui restoration.
* `IAF_GlowTreeCreator_Esoterica` - Spiritual Wood Creation

### Miracles (Magic)

* `IAF_FengshuiItemClear` - Focused Feng Shui Reversal, a part of Focused Feng Shui restoration.
* `IAF_GlowTreeCreator` - Spiritual Wood Creation

### Inspiration Trees

* `Gong1`, Nodes `Gong1_b2_1` and `Gong1_b2_2` - Focused Feng Shui and Focused Feng Shui Reversal, a part of Focused Feng Shui restoration.

### Scripts

* `Scripts\Magic\class\Magic_FSItemCreate.lua` - Focused Feng Shui Reversal Miracle script, a part of Focused Feng Shui restoration.
* `Scripts\Magic\class\Magic_GlowTreeCreator.lua` - Spiritual Wood Creation script

### Other

* `Language\OfficialEnglish\codedictionary.txt` - Custom Titles
* `Settings\Practice\FabaoHelian\FabaoHelian.txt` and `Language\OfficialEnglish\Settings\Practice\FabaoHelian\FabaoHelian.txt` - ID 75, 76, 77, new attachments for Qi Barrier Attachment Mod

## How to Contribute

Any Issues/Pull Requests are welcome. To ensure a similar level of quality between all parts of the mod, here's a few guidelines.

When changing vanilla aspects, keep in line with the original naming logic.
* If the original was `MapStory_Item.xml`, the PR should use the same filename with `MapStory_Item.xml`.

If the fixes exist as a standalone mod, include a link to it.