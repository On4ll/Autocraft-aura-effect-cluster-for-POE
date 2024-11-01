PREFIXES := ["Agent of Destruction", "Dark Messenger", "Empowered Envoy", "Endbringer", "Heraldry", "Lasting Impression", "Purposeful Harbinger", "Self-Fulfilling Prophecy", "increased Damage", "to Armour", "to Evasion", "to Maximum Energy Shield", "to Maximum Life", "to Maximum Mana", "increased Effect"]

SUFFIXES := ["increased Attack and Cast Speed while affected by a Herald", "increased Mana Regeneration Rate", "to All Attributes", "to Dexterity", "to Intelligence", "to Strength", "to all Elemental Resistances", "to Chaos Resistance", "to Cold Resistance", "to Fire Resistance", "to Lightning Resistance", "of Life per Second"] 

DESIRED_MODS := ["Purposeful Harbinger", "Lasting Impression", "Empowered Envoy", "Heraldry"]

;DESIRED_MODS_FULL := ["Purposeful Harbinger", "Lasting Impression"]

MUST_HAVE_MODS := ["Purposeful Harbinger", "Lasting Impression", "Empowered Envoy", "Heraldry"]



CRAFTING_DONE := 0
PREFIX_CHECK_DONE := 0
DETECTED_MOD := "None"
OLD_COPY := "None"
EXHAUSTED := 0
clipboard := ""
;isPreviousActionAlteration = 0
isShiftDown := 0  ;send {Shift down}


Logger(text)
{
    Log := FileOpen("Log.txt", "a")
    Log.Write(text)
    Log.Close()
}

Logger("________________________New Log_________________________`r `n")

ClickItem()
{
    Logger("Current Item: " clipboard "`n")
    global OLD_COPY
    global EXHAUSTED

    OLD_COPY := clipboard

    Click, 234 324 Left

    sleep, 90

    Send, ^c

    sleep, 90

    if InStr(OLD_COPY, clipboard)
    {
        Loop, 15
        {
            sleep, 100
            Send, ^c
            if (InStr(OLD_COPY, clipboard))
            {
                EXHAUSTED := EXHAUSTED + 1
            }
            else
            {
                EXHAUSTED := 0
                break
            }
        }
        if(EXHAUSTED = 15)
        {
            if(IsTwoDesiredMods())
    		{
        		send {Shift up}
			MsgBox "Done__This should not have happened!"
            		ExitApp
    		}
	    else
            {
                ;ClickItem()
		clipboard := "none"
            }
        }
    }
}

Transmute()
{
    Logger("`nTransmute()`n")
    global isShiftDown

    if(isShiftDown)
    {
        send {Shift up}
        isShiftDown = 0
    }
    Click, 37 190 Right
    ClickItem()
}

Alteration()
{
    Logger("`nAlteration()`n")

    global isShiftDown

    if(isShiftDown = 0)
    {
        Click, 78 192 Right
        send {Shift down}
        isShiftDown = 1
    }
    ClickItem()
}

Regal()
{
    Logger("`nRegal()`n")
    global isShiftDown

    if(isShiftDown)
    {
        send {Shift up}
        isShiftDown = 0
    }
    Click, 309 189 Right
    ClickItem()
    ;Log.Write("Regal()" "`r `n")
}

Scour()
{
    Logger("`nScour()`n")
    global isShiftDown

    if(isShiftDown)
    {
        send {Shift up}
        isShiftDown = 0
    }
    Click, 308 359 Right
    ClickItem()
    ;Log.Write("Scour()" "`r `n")
}

Augment()
{
    Logger("`nAugment()`n")
    global isShiftDown

    if(isShiftDown)
    isShiftDown = 0
    {
        send {Shift up}
    }
    Click, 162 230 Right
    ClickItem()
    ;Log.Write("Augment()" "`r `n")
}

DoesPrefixExist()
{
    global PREFIXES
    global DETECTED_MOD

    for index, substring in PREFIXES
    {
        if InStr(clipboard, substring)
        {
            DETECTED_MOD := substring
            Logger("DETECTED_MOD: " DETECTED_MOD "`n")
            ;Log.Write("DETECTED_MOD = " DETECTED_MOD "(DoesPrefixExist)" "`r `n")
            ;MsgBox %DETECTED_MOD%
            return 1
        }
    }
    return 0
}

DoesSuffixExist()
{
    global SUFFIXES

    for index, substring in SUFFIXES
    {
        if InStr(clipboard, substring)
        {
            ;MsgBox "Suffix Found"
            return 1
        }
    }
    return 0
}

IsDesired()
{
    global MUST_HAVE_MODS
    global DETECTED_MOD

    for index, substring in MUST_HAVE_MODS
    {
        ;MsgBox %DETECTED_MOD%
        ;Log.Write("DETECTED_MOD = " DETECTED_MOD "(IsDesired)" "`r `n")

        if InStr(DETECTED_MOD, substring)
        {
            ;MsgBox %DETECTED_MOD%
            return 1
        }
    }
    return 0

}

IsTwoDesiredMods()
{
    global DESIRED_MODS
    global MUST_HAVE_MODS
    count := 0

    for index, substring in DESIRED_MODS
    {
        If Instr(clipboard, substring)
        {
            count := count + 1
            if(count = 2)
            {
                return 1
            }
        }
    }
    return 0
}

]::
Loop, 50
{
    if(CRAFTING_DONE)
    {
        MsgBox "Complete"
        Reload
	    sleep, 1000
    }

    Transmute()
    Loop, 100
    {
       if(PREFIX_CHECK_DONE)
       {
            break
       }
       else
       {
            if(DoesPrefixExist() = 0)
            {
                Augment()
            }
            
            temp := DoesPrefixExist()

            if(IsDesired())
            {
                  PREFIX_CHECK_DONE := 1
            }
            else
            {
                Alteration()
            }
       }
    }

    if(DoesSuffixExist() = 0)
    {
        Augment()
    }

    Regal()

    if(IsTwoDesiredMods())
    {
        CRAFTING_DONE := 1
    }
    else
    {
        Scour()
        PREFIX_CHECK_DONE := 0
    }
}
return

;p::
;Scour()
;Send, ]
;return

[::
MsgBox "Terminated"
ExitApp
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Debug Functions;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

q::
DoesPrefixExist()
if(IsDesired())
{
    MsgBox "yes"
}

else
{
    MsgBox "no"
}
return

r::
OLD_COPY := "haha"
if InStr(OLD_COPY, clipboard)
{
    MsgBox "Yup"
}
return