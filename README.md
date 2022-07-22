# MekaControl
CC: Tweaked programs for managing a full Mekanism Fission Reactor setup (including boiler, turbine, and induction matrix) with emergency switches to scram the reactor if something is going wrong.

# Installation

Run the following command: `pastebin get H9gM50my startup`

It will download the mekacontrol script and start function loops that monitor various aspects of the reactor, boiler, turbine, and induction matrix, and immediately scram the reactor if anything happens that could cause a meltdown.

# Note for ATM players
For some reason, the ATM pack devs think http requests are a security issue and have disabled them. If you're in singleplayer you can renable it in the config files. If you're on a server, and they haven't already, either ask your server admins to change this, or have fun manually creating the files and copy pasting.
