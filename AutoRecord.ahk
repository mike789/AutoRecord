#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2
#SingleInstance FORCE
;Debug := % "TRUE"

;Variables and Constants for Sleeping
SECONDS_IN_MINUTES := 60
MILlISECONDS_IN_SECONDS := 1000
MinutesForWorship := SECONDS_IN_MINUTES * MILlISECONDS_IN_SECONDS * 40
MinutesForSermon := SECONDS_IN_MINUTES * MILlISECONDS_IN_SECONDS * 40
MinutesForClosing := SECONDS_IN_MINUTES * MILlISECONDS_IN_SECONDS * 20
if Debug
{
MinutesForWorship /= 1000
MinutesForSermon /= 1000
MinutesForClosing /= 1000
}

;Check to see if Reaper is already open and if not opens it
;TODO

;Create new project and save it with correct filepath and filename
;TODO

;Ready project for recording
WinMenuSelectItem, % "REAPER",, % "Actions", % "Custom Actions", % "Go to Start"
WinMenuSelectItem, % "REAPER",, % "Actions", % "Custom Actions", % "Arm All"

;Start recording Project
WinMenuSelectItem, % "REAPER",, % "Actions", % "Custom Actions", % "Record"

Sleep, % MinutesForWorship
;Stop Recording Band
WinMenuSelectItem, % "REAPER",, % "Actions", % "Custom Actions", % "Arm All"
WinMenuSelectItem, % "REAPER",, % "Actions", % "Custom Actions", % "Toggle Arm Group 1"

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