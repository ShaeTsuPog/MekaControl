# MekaControl
CC: Tweaked programs for managing a full Mekanism Fission Reactor setup (including boiler, turbine, and induction matrix) with emergency switches to scram the reactor if something is going wrong.

Low coolant? scrammed.
Nowhere for heated collant to go? scrammed.
Waste filling up? scrammed.
Induction Matrix filling up? scrammed.
Something disconnects from the network? scrammed, and the script stops and leaves the reactor off, because this is an easy way to get a meltdown otherwise.

# Installation

Run the following command: `pastebin get H9gM50my startup`

It will download the mekacontrol script and start function loops that monitor various aspects of the reactor, boiler, turbine, and induction matrix, and immediately scram the reactor if anything happens that could cause a meltdown.

**NOTE: This script is meant to monitor all 4 previously listed multiblocks, as well as cast info to a monitor, and will not work unless reactor, boiler, turbine, matrix, and a monitor are networked together.**

# Note for ATM players
For some reason, the ATM pack devs think http requests are a security issue and have disabled them. If you're in singleplayer you can renable it in the config files. If you're on a server, and they haven't already, either ask your server admins to change this, or have fun manually creating the files and copy pasting.

# Credit
Some code in the startup script was copied from Krakaen's popular bigger reactor control script, because it served this purpose well. Shoutout to him and his amazing reactor control script.
