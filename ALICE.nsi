# Basic installer (slightly more advanced than unzip) originally based on 
# http://nsis.sourceforge.net/A_simple_installer_with_start_menu_shortcut_and_uninstaller

# Lets use the so-called "Modern UI" (no, not *that* "Modern UI")
!include MUI2.nsh
 
# In a decent script, most settings can be tweaked by editing the !defines at the top here
!define APPNAME "Raven Shield Map - ALICE"
!define COMPANYNAME "Yabsa and KeithZG"
!define DESCRIPTION "Arbitrarily Limited Integrated Combat Environment installer"


# Set some general options
RequestExecutionLevel admin ;Require admin rights on NT6+ (When UAC is turned on)
SetCompressor /SOLID lzma
# If we don't find a registry key, assume the default Steam install location for 64-bit Windows
InstallDir "C:\Program Files (x86)\Steam\steamapps\common\Rainbow Six 3 Gold\"
;InstallDirRegKey HKLM "SOFTWARE\G. Michaels Consulting Ltd." "InstallDir"
outFile "RavenShield-map-Alice.exe"
!include LogicLib.nsh
 
# This will be in the installer/uninstaller's title bar
Name "${APPNAME}"

# Set general MUI options
;!define MUI_ICON "Help.ico"
;!define MUI_UNICON "Help.ico"
;!define MUI_HEADERIMAGE_RIGHT

# Set MUI welcome page options
!define MUI_WELCOMEPAGE_TITLE "ALICE"
!define MUI_WELCOMEPAGE_TEXT "Arbitrarily Limited Integrated Combat Environment"
;!define MUI_WELCOMEFINISHPAGE_BITMAP "welcome.bmp"

# MUI Finish page options
!define MUI_FINISHPAGE_TEXT "Alright, you've installed the mission, now lets hope that copy protection doesn't fuck you over."

 
# Now defining the pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "English"
 
!macro VerifyUserIsAdmin
UserInfo::GetAccountType
pop $0
${If} $0 != "admin" ;Require admin rights on NT4+
        messageBox mb_iconstop "Administrator rights required!"
        setErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
        quit
${EndIf}
!macroend
 
function .onInit
	setShellVarContext all
	!insertmacro VerifyUserIsAdmin
functionEnd
 
section "install"
	# Files for the install directory - to build the installer, these should be in the same directory as the install script (this file)
	setOutPath $INSTDIR
	# Files added here should be removed by the uninstaller (see section "uninstall")
	file /r ALICE\*
	# Add any other files for the install directory (license files, app data, etc) here
	
sectionEnd
 
