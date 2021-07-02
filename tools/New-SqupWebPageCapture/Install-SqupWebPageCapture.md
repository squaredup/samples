# Install-SqupWebPageCapture #

A simple script to install the prerequisites to capture images of web pages via a PowerShell script using Puppeteer.

## Description ##

The `Install-SqupWebPageCapture` script can be executed as is, but does have some parameters that can be set for business requirements.

This script will install the following:

- Google Puppeteer: [https://github.com/puppeteer/puppeteer](https://github.com/puppeteer/puppeteer "Google Puppeteer") 
- NodeJS: [https://nodejs.org/en/](https://nodejs.org/en/ "NodeJS") 


The script is broken up into seven sections as follows:

1. Constants
2. Set the local execution policy
3. Execute some function to refresh the System.Environment
4. Support functions
5. Create a sample capture
6. Finish        

Only the Constants section contains parameters that can be modified.

## Parameters ##
The only parameters that should be changed are as follows:

### $fPuppeteer ###

(Required) The name of the installation directory for the Puppeteer application.

### $fImages ###

(Required) The name of the Images directory that is used to capture the first image.  
This directory can be removed once the installation is complete.

### $pRoot ###

(Required) The root directory.  Used to move the installation path from `c:\puppeteer` to `d:\puppeteer`.

### $nodejsVer ###

(Required) The version of NodeJS that will be installed.  At the time of this project, version 14.17.1 was the most current.  This is user serviceable to allow for different user requirements.  The most current version of Puppeteer will always be downloaded since we're using the NPM repository.

### $ImageFile ###

(Required) The name of the web page that is to be captured to an image file.


 
