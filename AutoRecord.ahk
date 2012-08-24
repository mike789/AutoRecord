#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2
#SingleInstance FORCE
;Debug := % "TRUE"

;Variables and Constants for Sleeping
SECONDS_IN_MINUTES := 60
MILLISECONDS_IN_SECONDS := 1000
MinutesForWorship := SECONDS_IN_MINUTES * MILLISECONDS_IN_SECONDS * 40
MinutesForSermon := SECONDS_IN_MINUTES * MILLISECONDS_IN_SECONDS * 40
MinutesForClosing := SECONDS_IN_MINUTES * MILLISECONDS_IN_SECONDS * 20

TemplateName := "Weekend Service"

if Debug
{
MinutesForWorship /= 1000
MinutesForSermon /= 1000
MinutesForClosing /= 1000
}

WinGetActiveTitle, LastWindow
;Check to see if Reaper is already open and if not opens it
IfWinNotExist, ahk_class REAPERwnd
{
	Run, % "C:\Program Files\REAPER (x64)\reaper.exe"
}
WinActivate, ahk_class REAPERwnd
WinWaitActive, ahk_class REAPERwnd
Sleep, 500
IfWinExist, "About REAPER"
{
	Sleep, 5000
	Send, {Enter}
}

;Initialize Menus for Use
WinActivate, "REAPER" 
Send, !f
Sleep, 500
Send,{ESCAPE}
Sleep, 500
Send, !a
Sleep, 500
Send,{ESCAPE}
Sleep, 500


;Create new project and save it with correct filepath and filename
WinMenuSelectItem, % "REAPER",, % "File", % "Project templates", % TemplateName
Sleep, 2000
FormatTime, FileName, , yyyy-MM-dd
FileName .= "-" . (A_Hour + 1) . "_00.RPP"
FilePath := "E:\Documents\REAPER Media\"
WinMenuSelectItem, % "REAPER",, % "File", % "Save"
WinWaitActive, % "Save Project"
Sleep, 500
Send, % FilePath
Sleep, 500
Send, % FileName
Sleep, 500
Send, {Enter}
Sleep, 500
WinActivate, % LastWindow



;Ready project for recording
WinMenuSelectItem, % "REAPER",, % "Actions", % "Custom Actions", % "Go to Start"
WinMenuSelectItem, % "REAPER",, % "Actions", % "Custom Actions", % "Arm All"

Sleep, 1000
;Start recording Project
WinMenuSelectItem, % "REAPER",, % "Actions", % "Custom Actions", % "Record"

Sleep, % MinutesForWorship
;Stop Recording Band
WinMenuSelectItem, % "REAPER",, % "Actions", % "Custom Actions", % "Arm All"
WinMenuSelectItem, % "REAPER",, % "Actions", % "Custom Actions", % "Toggle Arm Group 01"

Sleep, % MinutesForSermon
;Resume Recording Band
WinMenuSelectItem, % "REAPER",, % "Actions", % "Custom Actions", % "Arm All"

Sleep, % MinutesForClosing
;Stop Recording
WinMenuSelectItem, % "REAPER",, % "Actions", % "Custom Actions", % "Stop"
Sleep, 500
WinMenuSelectItem, % "REAPER",, % "Actions", % "Custom Actions", % "Unarm All"
Sleep, 500
WinMenuSelectItem, % "REAPER",, % "Actions", % "Custom Actions", % "Unselect All"
Sleep, 500
WinMenuSelectItem, % "REAPER",, % "Actions", % "Custom Actions", % "Save"