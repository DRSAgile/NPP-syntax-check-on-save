# NPP-syntax-check-on-save
An environment helper to program in JavaScript, PHP and AHK in Notepad++.

Despite the name, it actually does not help with setting it up, it only helps when everything else is done: if a file you are saving with a *Control+S* key combination in Notepad++ is a JavaScript or PHP file, the script will run a syntax check on them. When working on an AHK script, it will automatically reload it.

Lots of steps are necessary for the script to work as intended:

    **in Windows:**

1. install MAMP (uncheck "MAMP Pro", if you do not have a paid account) or a standalone PHP engine

2. set "Run as administrator" in "Compatibility" section of AHK executable's settings

3. set "Run as administrator" in "Compatibility" section of NPP executable's settings OR -- since the flag is sometimes dropped with NPP updates -- use Task Scheduler to launch it with elevated rights

    **in NPP:**

4. install JSLint plugin via "Plugins", "Plagins Admin..." menu

5. install NPPExect plugin via "Plugins", "Plagins Admin..." menu


    **in NppExec plugin:**

6. in "Console Output..." menu, set "Console input/output encoding" to "UTF8/UTF" as otherwise non-ANSI paths will not be understood

7. in "Execute NppExec Script..." menu, create "Start AHK for NPP syntax check on save" script; for example:
cmd.exe /C start "" "C:\Program Files\AutoHotkey\AutoHotkey.exe" "C:\Users\zxs\OneDrive\Рабочий стол\Прочее\NPP syntax check on save.ahk"

8. in "Advanced Options..." menu, add this script to "Execute this script when Notepad++ starts" field 

9.  in "Execute NppExec Script..." menu, create "PHP syntax check" script; for example:
"C:\MAMP\bin\php\php8.1.0\php.exe" -l "$(FULL_CURRENT_PATH)"

10. in "Advanced Options..." menu, select this (#9) script in "Associated scripts" field 


    **in NPP:**

11. restart NPP

12. assign specifically "alt+shift+F6" hotkey to the script #9) script via "Settings", "Shortcut Mapper...", "Plugin commands", "Execute NppExec Script..." (care for possible shortcut key conflicts)

13. for AHK's Function List panel to work follow the instructions like [this](https://www.autohotkey.com/boards/viewtopic.php?p=366054#p366054) and [this](https://npp-user-manual.org/docs/function-list/).
This will lead to updating `%APPDATA%\notepad++\functionList\overrideMap.xml` file and creating "akh.xml" in `%APPDATA%\notepad++\functionList\`
BE CAREFUL to correctly put the name of *User Defined Language* in `overrideMap.xml`.
