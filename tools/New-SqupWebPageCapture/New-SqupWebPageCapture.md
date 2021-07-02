# New-SqupWebPageCapture #

Capture web pages via a PowerShell script using Puppeteer.

## Description ##

The `New-SqupWebPageCapture` script requires NodeJS and Puppeteer to be installed before first use.
Once NodeJS and Puppeteer are installed, this script captures an image of a given web page, in a specific size and saves it to a specific location.

**Requirements:**

- PowerShell 3.0+
- Google Puppeteer: [https://github.com/puppeteer/puppeteer](https://github.com/puppeteer/puppeteer "Google Puppeteer") 
- NodeJS: [https://nodejs.org/en/](https://nodejs.org/en/ "NodeJS") 


## Examples ##

### Example 1: Call `New-SqupWebPageCapture` cmdlet with the defaults ###

This examples assumes the Puppeteer files are located in the "C:\apps\Puppeteer" directory.

1. Make note of the URL you would like to capture, for example `https://squaredup.com/`.
2. Identify the directory and file name of the screen capture, for example `c:\users\user\desktop\test_image.png`.

**PowerShell:**

    PS C:\>.\New-SqupWebPageCapture.ps1 -URL "https://squaredup.com/" -FilePath "c:\users\user\desktop\test_image.png" 


**Output:**

	New-SqupWebPageCapture.ps1
	Copyright 2018 Squared Up Limited, All Rights Reserved.
	
	WARN: Defaulting to c:\Puppeteer\ directory
	NOTE: Puppeteer exists in this path
	NOTE: FilePath exists
	WARN: Wait needs to be 1 millisecond or longer, setting to 6000
	WARN: Width needs to be non-zero in lenth, setting to a default of 2560
	WARN: Height needs to be non-zero in lenth, setting to a default of 2560
	INFO Create the index.js file
	INFO Starting capture
	INFO Capture complete
	INFO Remove the index.js file

### Example 2: Call `New-SqupWebPageCapture` cmdlet, but pass in a different Puppeteer directory ###

1. Make note of the Puppeteer installation directory path, for example `D:\apps\Puppeteer`.
2. Make note of the URL you would like to capture, for example `https://squaredup.com/`.
3. Identify the directory and file name of the screen capture, for example `c:\users\user\desktop\test_image.png`.


**PowerShell:**

    PS C:\>.\New-SqupWebPageCapture.ps1 -URL "https://squaredup.com/" -Path "D:\apps\Puppeteer" -FilePath "c:\users\user\desktop\test_image.png"


**Output:**

	New-SqupWebPageCapture.ps1
	Copyright 2018 Squared Up Limited, All Rights Reserved.
	
	NOTE: Puppeteer exists in this path
	NOTE: FilePath exists
	WARN: Wait needs to be 1 millisecond or longer, setting to 6000
	WARN: Width needs to be non-zero in lenth, setting to a default of 2560
	WARN: Height needs to be non-zero in lenth, setting to a default of 2560
	INFO Create the index.js file
	INFO Starting capture
	INFO Capture complete
	INFO Remove the index.js file


### Example 3: Call `New-SqupWebPageCapture` cmdlet, but pass in different values for wait, height, and width ###

1. Make note of the URL you would like to capture, for example `https://squaredup.com/`.
2. Identify the directory and file name of the screen capture, for example `c:\users\user\desktop\test_image.png`.
3. Set a default wait time of 1000 milliseconds.
4. Set a default height of 2560 pixels.
5. Set a default width of 768 pixels (narrow, to mimic a phone screen size).


**PowerShell:**

    PS C:\>.\New-SqupWebPageCapture.ps1 -URL "https://squaredup.com/" -Wait 1000 -Height 2560 -Width 768 -FilePath "c:\users\user\desktop\test_image.png"


**Output:**

	New-SqupWebPageCapture.ps1
	Copyright 2018 Squared Up Limited, All Rights Reserved.
	
	WARN: Defaulting to c:\Puppeteer\ directory
	NOTE: Puppeteer exists in this path
	NOTE: FilePath exists
	INFO Create the index.js file
	INFO Starting capture
	INFO Capture complete
	INFO Remove the index.js file


## Parameters ##

### -URL ###

(Required) The name of the web page that is to be captured to an image file.

### -Wait ###

(Optional) If supplied, the amount of time that the script will wait until it captures the image, which is important for web pages that take a few seconds to load. If not supplied, the script will supply a value of 6000 milliseconds.

### -Height ###

(Optional) If supplied, the height of the screen capture in pixels. If not supplied, the script will supply a value of 2560 pixels.

### -Width ###

(Optional) If supplied, the width of the screen capture in pixels. If not supplied, the script will supply a value of 2560 pixels.  

### -Path ###

(Optional) The path where the Puppeteer files are located. If not supplied, the script will supply a value of c:\puppeteer\ for the path.  The path will be checked for the existence of the Puppeteer installation files and if not found, will exit.

### -FilePath ###

(Required) The target path where the screen capture will be saved.  If the FilePath is invalid, the script will exit.