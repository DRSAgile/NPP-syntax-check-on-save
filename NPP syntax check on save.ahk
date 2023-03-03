; MUST be saved as "UTF-8 with BOM" at all times, unlike JS where it is better without BOM
;
;
; in Windows:
; 1. install MAMP (uncheck "MAMP Pro", if you do not have a paid account) or a standalone PHP engine
;
; 2. set "Run as administrator" in "Compatibility" section of AHK executable's settings
;
; 3. set "Run as administrator" in "Compatibility" section of NPP executable's settings OR -- since the flag is sometimes dropped with NPP updates -- use Task Scheduler to launch it with elevated rights
;
; in NPP:
;
; 4. install JSLint plugin via "Plugins", "Plagins Admin..." menu
;
; 5. install NPPExect plugin via "Plugins", "Plagins Admin..." menu
;
;
; in NppExec plugin:
;
; 6. in "Console Output..." menu, set "Console input/output encoding" to "UTF8/UTF" as otherwise non-ANSI paths will not be understood
;
; 7. in "Execute NppExec Script..." menu, create "Start AHK for NPP syntax check on save" script; for example:
; cmd.exe /C start "" "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\Users\zxs\OneDrive\Рабочий стол\Прочее\NPP syntax check on save.ahk"
;
; 8. in "Advanced Options..." menu, add this script to "Execute this script when Notepad++ starts" field 
;
; 9.  in "Execute NppExec Script..." menu, create "PHP syntax check" script; for example:
; "C:\MAMP\bin\php\php8.1.0\php.exe" -l "$(FULL_CURRENT_PATH)"
;
; 10. in "Advanced Options..." menu, select this (#9) script in "Associated scripts" field 
;
;
; in NPP:
;
; 11. restart NPP
;
; 12. assign specifically "alt+shift+F6" hotkey to the script #9) script via "Settings", "Shortcut Mapper...", "Plugin commands", "Execute NppExec Script..." (care for possible shortcut key conflicts)
;
; 13. for AHK's Function List panel to work follow the instruction: https://www.autohotkey.com/boards/viewtopic.php?p=366054#p366054 and https://npp-user-manual.org/docs/function-list/
; this will lead to updating %APPDATA%\notepad++\functionList\overrideMap.xml and to creating "akh.xml" in %APPDATA%\notepad++\functionList\
; BE CAREFUL to correctly put the name of User Defined Language in overrideMap.xml

#Persistent
#SingleInstance force
#IfWinActive, ahk_class Notepad++

$^vk53::
$^s::
$^sc01F::
    StatusBarGetText,text,,ahk_class Notepad++
	if (text = "JavaScript file")
	{
		WinWaitActive, ahk_class Notepad++ ; use Sleep 1000 in case if Control+S should come AFTER the text processing as otherwise the ANSI control code "DC3" will be inserted in the text instead of saving the file. Calls for plug-ins such as JSLint do not get reflected correctly in NP++'s "Ready" responses to Windows API. Saving the file is a built-in operation and thus it does not require the use of Sleep 1000 after it to properly call for a syntax check
		Send ^{vk53sc01F}
		WinWaitActive, ahk_class Notepad++
		Send ^+{F5}
		
	}
	else if (text = "PHP Hypertext Preprocessor file")
	{
		WinWaitActive, ahk_class Notepad++
		Send ^{vk53sc01F}
		WinWaitActive, ahk_class Notepad++
		Send !+{F6}
	}
	else if (text = "User Defined language file - Autohotkey")
	{
		WinWaitActive, ahk_class Notepad++
		Send ^{vk53sc01F}
		WinWaitActive, ahk_class Notepad++
		WinGetTitle, title
		StringGetPos, pos, title, %A_ScriptName%
		if (pos >= 0)
			Reload
		else
			Run % Trim(StrReplace(StrReplace(title, " - NotePad++", ""), "*", ""))
	}
	else
	{
		WinWaitActive, ahk_class Notepad++
		Send ^{vk53sc01F}
	}
    return 
#IfWinActive