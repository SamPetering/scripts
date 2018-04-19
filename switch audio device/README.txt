These scripts are used to switch the default audio device of the computer by utilizing the command line utility NirCmd (included in this directory)

The two scripts included are:
defaultHP.cmd (sets headphones to default)
defaultSP.cmd (sets speakers to default).


CONFIGURATION:
1. Run the executables located in the file NirCmd OR visit http://www.nirsoft.net/utils/nircmd.html and get it from there.

2. Open each script in an editor and, inside the quotation marks, enter the names of whichever audio playback device that script should be setting as the default. Save and Close.
		Example:
		nircmd setdefaultsounddevice "Speakers" 1
		-
		or
		-
		nircmd setdefaultsounddevice "Headphones" 1

3. Finished. Running either script should now set its respective device as the default audio playback device.