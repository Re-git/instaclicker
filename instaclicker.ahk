#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
#SingleInstance, force

PausedMsg := "Paused"
comments := ["Cool", "<3", "Hey, that's cool", "Pretty cool", ":) <3", "nice!", "❤️", "😍", "🤔", "🔥🔥🔥", "🔥🔥", "🔥", "😊", "😘", "Cool ❤️", "! <3", "nice! ❤️"]
random, rnum, 1, comments.MaxIndex()

SetTimer, test1, 299900 
test1:
If (A_TimeIdle < 200000) {
	Return
}
If (A_TimeIdle > 200000) {
	gosub,Start_liking
}
Return

Start_liking:
run, https://instagram.com
WinWait, ahk_exe firefox.exe
sleep, 2500
WinActivate, ahk_exe firefox.exe
Sleep, 1500
#IfWinActive Instagram - Mozilla Firefox
	Loop 20 {
		Random, rand, 1, 10
		if rand > 6
		{
			
		; Look for clicked like button -> Scroll down
			
			ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, liked.png
			if ErrorLevel = 2
				MsgBox Could not conduct the search.
			else if ErrorLevel = 1
			{
			; Look for comment button -> click and write a comment!
				
				ImageSearch, Found1X, Found1Y, 0, 0, A_ScreenWidth, A_ScreenHeight, insta-comment.png
				if ErrorLevel = 2
					MsgBox Could not conduct the search.
				else if ErrorLevel = 1
				{
					Random, randomlines, 20, 45
					Send {wheelDown %randomlines%}
					Random, rand, 600, 1900
					Sleep, %rand%
				}
				else
				{
					Click %Found1X%,%Found1Y%
					Random, rand, 600, 1900
					Sleep, %rand%
					random, rnum, 1, comments.MaxIndex()
					Send, % comments[rnum]
					sleep, 500
					Send, {Enter}
					Random, rand, 600, 1900
					Sleep, %rand%
				}
			}
			else
			{
				Random, randomlines, 20, 45
				Send {wheelDown %randomlines%}
				Random, rand, 600, 1900
				Sleep, %rand%
			}
		}
		
		
		; Look for unclicked like button -> click it!
		
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, like.png
		if ErrorLevel = 2
			MsgBox Could not conduct the search.
		else if ErrorLevel = 1
		{
			Random, randomlines, 10, 65
			Send {wheelDown %randomlines%}
			Random, rand, 500, 1000
			Sleep, %rand%
		}
		else
		{
			Click %FoundX%,%FoundY%
			Random, rand, 500, 900
			Sleep, %rand%
			Random, randomlines, 10, 65
			Send {wheelDown %randomlines%}
			Random, rand, 500, 1000
			Sleep, %rand%
		}
	}
Send ^w ; Closes firefox tab
Sleep, 500
/*
	
	run, https://facebook.com
	WinWait, ahk_exe firefox.exe
	sleep, 1000
	WinActivate, ahk_exe firefox.exe
	Sleep, 2500 ;wait for webpage to load
	
	#IfWinActive Facebook - Mozilla Firefox ;make sure that we are in facebook
		Loop 20 {
			ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, fblike.png
			if ErrorLevel = 2
				MsgBox Could not conduct the search.
			else if ErrorLevel = 1
			{
				Random, randomlines, 10, 65
				Send {wheelDown %randomlines%}
				Random, rand, 700, 1200
				Sleep, %rand%
			}
			else
			{
				Click %FoundX%,%FoundY%
				Random, rand, 700, 1200
				Sleep, %rand%
			}
		}
	Send ^w ; Closes firefox tab
	
*/

Random, randomtime, 400000,900000
sleep, randomtime
#IfWinActive
	Return


; Shortcut for testing CTRL+`
!`::
gosub,Start_liking
return

; Shortcut to pause the script PAUSE
Pause::
MsgBox,%PausedMsg%
Pause,Toggle
Return
