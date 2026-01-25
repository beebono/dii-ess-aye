# DII-ESS-AYE
A janky emulationstation theme for ROCKNIX meant to make the Anbernic RG DS or AYN Thor feel a bit more like a chunky DSi.

# Known Issues (that probably won't be fixed)
1. Keyboard and horizontally longer popups are incorrectly sized.
2. Advanced Game Options is hidden.
  - Workaround by pressing your Advanced Game Options button twice.
3. Slider setting bars are way too long.

# Install
1. Download or clone this repository
2. Copy the contents of this repository into your themes folder under a folder named `dii-ess-aye`
  - Either connect to your network share and put it in the `themes` folder
  - Or copy it to `/STORAGE/.config/emulationstation/themes/` directly
3. Copy only the enable script for your device from the repository's `scripts` folder into your `roms/ports` folder
  - !!! NOTE: If you downloaded the theme as a zip, you may need to re-enable execution on the `enable_theme_*.sh` script either
              after extraction on your computer or on the device via ssh. Use `chmod +x enable_theme_*.sh` for either method.
4. After updating your gamelists, open your ports section on your device and
  - Either run the enable script every time you want to enable the theme
    - (You will have to manually change the theme setting when you want to switch back)
  - Or set the enable script to run at launch by opening the Advanced Game Options and turning on that option
    - Optionally, set the enable script's metadata Hidden option if you don't want it to clutter the ports
5. Enjoy?

# Scraping Recommendations
I recommend using Skraper and setting it to:
- Generate a gamelist.xml
- Scrape a miximage, linked to `<image>` node
- Scrape a support texture, resized to a square resolution, linked to `<thumbnail>` node
- (Optional) Scrape a video, linked to `<video>` node

If you already have a scraped collection, and just want to make it look okay enough with this theme
there are additional thumbnail scripts provided in the `scripts/thumbnails` directory of this repository
that can automatically crop (hard cut to 256x256), squish (preserves image, compresses to fit 256x256),
or resize (preserves image and aspect ratio, shrinks to 256x256) your existing boxart or support textures.
These can be run on your device after all gamelists, games, and images are in place.

# Special Thanks!
- Ant (https://github.com/anthonycaccese) for the status and slot icons and their implementation.
- Jeod (https://github.com/JeodC) for help testing the Thor variant.
- Zoiburg13 (https://github.com/Zoidburg13) for their wonderful system icons. 

# Previews
<img src="main_preview.jpeg" width="49%" /> <img src="game_preview.jpeg" width="49%" />
