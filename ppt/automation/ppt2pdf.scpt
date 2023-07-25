-- 2018-01-31
-- https://github.com/irmowan/Convert-ppt-to-pdf/blob/master/Convert-ppt-to-pdf.applescript
-- modified by WF 2020-11-15
-- 
-- ppt2Pdf({"/Users/wf/Projekte/2020/Infrastruktur2020/ppt2pdf", "TestMe.pptx"})

--http://hints.macworld.com/article.php?story=20050523140439734
-- passing command line arguments to applescript
on run (argv)
	log (count (argv))
	if ((count of argv) < 2) then
		log "usage: ppt2pdf basepath [filenames]"
	else
		my ppt2Pdf(argv)
	end if
end run

--
-- convert powerpoint to pdf on the given list of files
--
on ppt2Pdf(fileNames)
	log "launching Powerpoint ..."
	set pp to "Microsoft PowerPoint"
	tell application pp -- work on version 15.15 or newer
		launch
		set isfirst to true
		repeat with fileName in fileNames
			if isfirst then
				set basepath to fileName
				log "base path is " & basepath
				set isfirst to false
			else
				if fileName ends with ".ppt" or fileName ends with ".pptx" or fileName ends with ".pptm" then
					set filePath to basepath & "/" & fileName
					-- set filePath to POSIX path of fileAlias
					set pdfPath to my makeNewPath(filePath)
					log "trying to convert powerpoint file " & filePath & " to " & pdfPath
					open filePath
					
					-- save active presentation in pdfPath as save as PDF 
					-- save in same folder
					-- https://macscripter.net/viewtopic.php?id=26342
					--tell application "System Events"
					--	set listOfProcesses to (name of every process where background only is false)
					--	tell me to set selectedProcesses to choose from list listOfProcesses with multiple selections allowed
					--end tell
					--repeat with processName in selectedProcesses
					--	log processName
					--end repeat
					
					if not my chooseMenuItem(pp, "Datei", "Drucken...") then
						error number -128
					end if
					
					--my showUiElements(pp, "menu button")
					-- my waitFor(button whose description is "PDF", 5, 0.5)
					my choosePopUp(pp, "Layout für den Druck", "Notizen")
					my choosePopUp(pp, "Farbausgabeformat", "Farbe")
					--my chooseMenuButtonItem(pp, "PDF", "Als PDF sichern")
					local myTitle
					tell application "System Events"
						-- the magic of Applescript
						-- if you really want the title and not a reference to it you need to use an operator
						-- http://books.gigatux.nl/mirror/applescriptdefinitiveguide/applescpttdg2-CHP-12-SECT-5.html
						set myTitle to title of window 1 of process pp & ""
					end tell
					my chooseMenuButtonItem(pp, "PDF", "In Vorschau öffnen")
					delay 1
					tell application "System Events"
						log "waiting for Vorschau to display " & myTitle
						set timeLeft to my waitForAppearWindow(myTitle, "Vorschau", 30, 0.5)
						if timeLeft < 0 then
							log "Vorschau " & myTitle & " window didn't show up after 30 secs"
							error number -128
						else
							log "Vorschau appeared with " & timeLeft & "secs left"
							tell process "Vorschau"
								delay 0.2
								click menu item "Als PDF exportieren …" of menu 1 of menu bar item "Ablage" of menu bar 1
								delay 0.5
								-- CMD-SHIFT-G to set the export director
								-- https://dougscripts.com/itunes/itinfo/keycodes.php
								keystroke "g" using {command down, shift down}
								delay 0.2
								
								tell sheet 1 of window (myTitle)
									tell sheet 1
										-- dereference basePath
										local basePathStr
										set basePathStr to basepath & ""
										set value of first combo box to basePathStr
										delay 0.2
										click button "Öffnen"
										delay 0.2
									end tell
									click button "Sichern"
									set timeLeft to my waitForAppear(sheet 1, 3, 0.2)
									tell sheet 1
										if timeLeft > 0 then
											click button "Ersetzen"
										end if
									end tell
									delay 5
									keystroke "q" using {command down}
								end tell
								
							end tell
						end if
					end tell
					
					--tell application "System Events"
					--	set timeLeft to my waitForAppear("button", button "Sichern" of sheet 1 of sheet 1 of window 1 of process pp, 5, 0.5)
					--	if timeLeft < 0 then
					--		log "Sichern button didn't show up after 5 secs"
					--		error number -128
					--	end if
					--	click button "Sichern" of sheet 1 of sheet 1 of window 1 of process pp
					--end tell
					
					--tell application "System Events"
					--	delay 0.5
					--	try
					--		set timeLeft to my waitForAppear("button", button "Ersetzen" of sheet 1 of sheet 1 of sheet 1 of window 1 of process pp, 5, 0.5)
					--		if timeLeft < 0 then
					--			log "Ersetzen button didn't show up after 5 secs"
					--			error number -128
					--		end if
					--		click button "Ersetzen" of sheet 1 of sheet 1 of sheet 1 of window 1 of process pp
					--	end try
					--end tell
					log "done ..."
					-- close filePath
				end if
			end if
		end repeat
		-- still in tell powerpoint context
		--tell application "System Events"
		--	delay 0.5
		--	try
		--		set timeLeft to my waitForVanish("window", window "Sichern" of process pp, 60, 1)
		--		if timeLeft < 0 then
		--			log "print dialog didn't vanish after 60 secs"
		--			error number -128
		--		end if
		--	end try
		--end tell
		quit
	end tell
end ppt2Pdf

on showElement(uiElem)
	local className
	set className to class of uiElem as string
	log (((«class pDSC» of uiElem as string) & "=" & value of uiElem as string) & "(" & className) & ")"
end showElement

--
-- show all UI elements
--
on showUiElements(appName, filterClassName)
	tell application "System Events"
		tell process appName
			tell (1st window whose value of attribute "AXMain" is true)
				repeat with uiElem in entire contents of it as list
					try
						local className
						set className to class of uiElem as string
						if filterClassName is missing value or className is filterClasssname then
							log (((description of uiElem as string) & "=" & value of uiElem as string) & "(" & className) & ")"
						end if
					end try
				end repeat
			end tell
		end tell
	end tell
end showUiElements

--
-- wait for the given element to appear
--
on waitForAppearWindow(elementName, processName, time, slice)
	set timeLeft to time
	set appeared to false
	tell application "System Events"
		repeat until (appeared) or timeLeft ≤ 0
			try
				set appeared to window elementName of process processName exists
			end try
			delay slice
			log "."
			set timeLeft to timeLeft - slice
		end repeat
	end tell
	log timeLeft
	return timeLeft
end waitForAppearWindow

--
-- wait for the given element to appear
--
on waitForAppear(element, time, slice)
	set timeLeft to time
	set appeared to false
	repeat until (appeared) or timeLeft ≤ 0
		try
			set appeared to element exists
		end try
		delay slice
		log "."
		set timeLeft to timeLeft - slice
	end repeat
	log timeLeft
	return timeLeft
end waitForAppear

---
--- wait for the given element to vanish
---
on waitForVanish(element, time, slice)
	set timeLeft to time
	try
		repeat while (exists element) and timeLeft > 0
			delay slice
			log "."
			set timeLeft to timeLeft - slice
		end repeat
	end try
	log timeLeft
	return timeLeft
end waitForVanish


on chooseMenuButtonItem(appName, buttonName, itemName)
	tell application "System Events"
		tell process appName
			tell window 1
				local win1
				set win1 to it
				tell sheet 1
					log "choosing " & itemName & " of menu button " & buttonName
					tell menu button buttonName
						click
						delay 0.1
						tell menu 1
							click menu item itemName
						end tell
					end tell
				end tell
			end tell
		end tell
	end tell
end chooseMenuButtonItem
--
-- choose a popup 
--
on choosePopUp(appName, buttonName, itemName)
	tell application "System Events"
		tell process appName
			tell window 1
				tell sheet 1
					log "choosing " & itemName & " of pop up menu " & buttonName
					--repeat with pbutton in pop up buttons
					--	local pbutton1
					--	set pbutton1 to pbutton
					--	log description of pbutton & "=" & value of pbutton
					--end repeat
					tell (1st pop up button whose description is buttonName)
						click it
						delay 0.5
						pick menu item itemName of menu 1
					end tell
				end tell
			end tell
		end tell
	end tell
end choosePopUp

--
-- https://developer.apple.com/library/archive/documentation/
-- LanguagesUtilities/Conceptual/MacAutomationScriptingGuide
-- AutomatetheUserInterface.html#//apple_ref/doc/uid/TP40016239-CH69-SW17
--
on chooseMenuItem(theAppName, theMenuName, theMenuItemName)
	try
		-- Bring the target app to the front
		tell application theAppName
			activate
		end tell
		
		-- Target the app
		tell application "System Events"
			tell process theAppName
				
				-- Target the menu bar
				tell menu bar 1
					
					-- Target the menu by name
					tell menu bar item theMenuName
						tell menu theMenuName
							
							-- Click the menu item
							log "clicking " & theMenuItemName
							click menu item theMenuItemName
						end tell
					end tell
				end tell
			end tell
		end tell
		return true
	on error
		return false
	end try
end chooseMenuItem



on makeNewPath(f)
	set t to f as string
	if t ends with ".pptx" or t ends with ".pptm" then
		return (text 1 thru -5 of t) & "pdf"
	else
		return (text 1 thru -4 of t) & "pdf"
	end if
end makeNewPath

