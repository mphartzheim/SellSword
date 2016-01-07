-- Coded by: Exzu / EU-Aszune
-- Modified by: Seintefie / US-Thrall

textDatabase = {
	ANT = { outLine = "OUTLINE", fontSize = "14", loc = "TOP", x = 0, y = 8, color = {1, 1, 1, 1}, text = "", },
	statusText = { outLine = "OUTLINE", fontSize = "16", loc = "LEFT", x = 5, y = 61, color = {0, 1, 0, 1}, text = "Current Status:", },
	scanText = { outLine = "OUTLINE", fontSize = "16", loc = "LEFT", x = 95, y = 61, color = {1, 0, 0, 1}, text = "Not Running", },
	tankText = { outLine = "OUTLINE", fontSize = "14", loc = "LEFT", x = 22, y = 45, color = {1, 1, 1, 1}, text = "Tank:", },
	tankScanningText = { outLine = "OUTLINE", fontSize = "14", loc = "LEFT", x = 52, y = 45, color = {1, 0, 0, 1}, text = "Not Scanning...", },
	tankdg1 = { outLine = "OUTLINE", fontSize = "14", loc = "LEFT", x = 6, y = 29, color = {0, 0.6, 0.8, 1}, text = "# ...", },
	healerText = { outLine = "OUTLINE", fontSize = "14", loc = "LEFT", x = 22, y = 13, color = {1, 1, 1, 1}, text = "Healer:", },
	healScanningText = { outLine = "OUTLINE", fontSize = "14", loc = "LEFT", x = 62, y = 13, color = {1, 0, 0, 1}, text = "Not Scanning...", },
	healdg1 = { outLine = "OUTLINE", fontSize = "14", loc = "LEFT", x = 6, y = -3, color = {0, 0.6, 0.8, 1}, text = "# ...", },
	dpsText = { outLine = "OUTLINE", fontSize = "14", loc = "LEFT", x = 22, y = -19, color = {1, 1, 1, 1}, text = "DPS:", },
	dpsScanningText = { outLine = "OUTLINE", fontSize = "14", loc = "LEFT", x = 47, y = -19, color = {1, 0, 0, 1}, text = "Not Scanning...", },
	dpsdg1 = { outLine = "OUTLINE", fontSize = "14", loc = "LEFT", x = 6, y = -35, color = {0, 0.6, 0.8, 1}, text = "# ...", },
	bagCounter = { outLine = "OUTLINE", fontSize = "14", loc = "TOP", x = 116, y = -23, color = {0, 0.6, 0.8, 1}, bag = true, text = "0", },
};

frameDatabase = {
	scanButton = { zscale = 0, zxscale = 0, yscale = 22/32, xscale = 80/128, texture = true, Type = "Button", width = "80", height = "25", loc = "BOTTOM", x = -80, y = 5, text = "Start", script = true, functionName = "startScanning()", normalTxt = "Interface\\Buttons\\UI-Panel-Button-Up.blp", pushedTxt = "Interface\\Buttons\\UI-Panel-Button-Down.blp", highLightTxt = "Interface\\Buttons\\UI-Panel-Button-Highlight.png", setAlpha=true, },
	stopButton = { zscale = 0, zxscale = 0, yscale = 22/32, xscale = 80/128, texture = true, Type = "Button", width = "80", height = "25", loc = "BOTTOM", x = 80, y = 5, text = "Stop", script = true, functionName = "stopScanning()", normalTxt = "Interface\\Buttons\\UI-Panel-Button-Up.blp", pushedTxt = "Interface\\Buttons\\UI-Panel-Button-Down.blp", highLightTxt = "Interface\\Buttons\\UI-Panel-Button-Highlight.png", setAlpha=true, },
	configButton = { zscale = 0, zxscale = 0, yscale = 1, xscale = 1, texture = true, Type = "Button", width = "16", height = "16", loc = "TOP", x = 97, y = -5, script = true, functionName = "InterfaceOptionsFrame_OpenToCategory(SatchelScanner.childpanel)", normalTxt = "Interface\\Addons\\SatchelScanner\\icons\\config.tga", pushedTxt = "Interface\\Addons\\SatchelScanner\\icons\\configpush.tga", highLightTxt = "Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp", setAlpha=true, },
	closeButton = { zscale = 0, zxscale = 0, yscale = 1, xscale = 1, texture = true, Type = "Button", width = "16", height = "16", loc = "TOP", x = 115, y = -5, script = true, functionName = "hideMainFrame()", normalTxt = "Interface\\Addons\\SatchelScanner\\icons\\close.tga", pushedTxt = "Interface\\Addons\\SatchelScanner\\icons\\closepush.tga", highLightTxt = "Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp", setAlpha=true, },
	bagIcon = { zscale = 0, zxscale = 0, yscale = 1, xscale = 1, Type = "Button", width = "16", height = "16", loc = "TOP", x = 97, y = -23, normalTxt = "Interface\\Addons\\SatchelScanner\\icons\\bagIcon.tga", setAlpha=false, },
	healIcon = { zscale = 0, zxscale = 0, yscale = 1, xscale = 1, Type = "Button", width = "15", height = "15", loc = "LEFT", x = 6, y = 13, normalTxt = "Interface\\Addons\\SatchelScanner\\icons\\healerIcon.tga", setAlpha=false, },
	tankIcon = { zscale = 0, zxscale = 0, yscale = 1, xscale = 1, Type = "Button", width = "15", height = "15", loc = "LEFT", x = 6, y = 45, normalTxt = "Interface\\Addons\\SatchelScanner\\icons\\tankIcon.tga", setAlpha=false, },
	dpsIcon = { zscale = 0, zxscale = 0, yscale = 1, xscale = 1, Type = "Button", width = "15", height = "15", loc = "LEFT", x = 6, y = -19, normalTxt = "Interface\\Addons\\SatchelScanner\\icons\\dpsIcon.tga", setAlpha=false, },
};

-- Variables
local playSound = true;
local raidWarnNotify = true;
local UpdateInterval = 3;
local running = false;
local scanForTank = true;
local scanForHeal = true;
local scanForDps = false;
local scanForWoD = true;
local scanForTW = true;
local scanForLFR = true;
local scanStopped = false;
local runVar = {"Not Running", "Running"};
local addonVersion = "2.3.1";
local satchelFound = false;
local satchelsReceived;
local showUI = true;
local queueText = "";
local bgAlpha = 0;

-- Dungeon Scan Var
--local heroicVar = {"# Warlords of Draenor Heroic!", "# Not used...!"};
local scanVar = {"# ...", "# Searching..."};
local queueVar = {" WoD Heroic ", " TW LK ", " TW BC ", " TW Cata ", " LFR "};
local classScan = {"Not Scanning...","Scanning...","Satchel Found!"};
local ctaVar = {"Call to Arms: Tank","Call to Arms: Healer","Call to Arms: Dps"};


-- Addon Colors
--local colors = { red = {1,0,0,1}, green = {0,1,0,1}, yellow = {1,1,0,1}, } -- To be used in an upcoming table
local redColor = {1,0,0,1};
local greenColor = {0,1,0,1};
local yellowColor = {1,1,0,1};

function stopScanning()
	if running then
		satchelFound = false;
		running = false;
		scanStopped = true;
		textDatabase.scanText.textFrame:SetTextColor(unpack(redColor));
		textDatabase.scanText.textFrame:SetText(runVar[1]);
		textDatabase.tankScanningText.textFrame:SetText(classScan[1]);
		textDatabase.tankScanningText.textFrame:SetTextColor(unpack(redColor));
		textDatabase.healScanningText.textFrame:SetText(classScan[1]);
		textDatabase.healScanningText.textFrame:SetTextColor(unpack(redColor));
		textDatabase.dpsScanningText.textFrame:SetText(classScan[1]);
		textDatabase.dpsScanningText.textFrame:SetTextColor(unpack(redColor));
		textDatabase.tankdg1.textFrame:SetText(scanVar[1]);
		textDatabase.healdg1.textFrame:SetText(scanVar[1]);
		textDatabase.dpsdg1.textFrame:SetText(scanVar[1]);
	end
end

function startScanning()
	if not running and (scanForTank or scanForHeal or scanForDps) and (scanForWoD or scanForTW or scanForLFR) then
		running = true
		textDatabase.scanText.textFrame:SetTextColor(unpack(greenColor));
		textDatabase.scanText.textFrame:SetText(runVar[2]);
		if scanForTank then
			textDatabase.tankdg1.textFrame:SetText(scanVar[2]);
		end
		if scanForHeal then
			textDatabase.healdg1.textFrame:SetText(scanVar[2]);
		end
		if scanForDps then
			textDatabase.dpsdg1.textFrame:SetText(scanVar[2]);
		end
		RequestLFDPlayerLockInfo();
	elseif not running and not (scanForTank or scanForHeal or scanForDps) then
		print("Must scan for atleast one class before starting the program!");
	elseif not running and not (scanForWoD or scanForTW or scanForLFR) then
		print("Must scan for atleast one dungeon type before starting the program!");
	end
end

function hideMainFrame()
	MainFrame:Hide();
	dbAdd("showMainFrame", false);
end

-- Database values
function dbUpdate()
	dbAdd("updateint", updateIntervalSlider:GetValue());
	dbAdd("version", addonVersion);
	dbAdd("raidwarning", raidWarningButton:GetChecked());
	dbAdd("sounds", playSoundButton:GetChecked());
	dbAdd("autostart", autoStartButton:GetChecked());
	dbAdd("scanTank", scanForTankButton:GetChecked());
	dbAdd("scanHeal", scanForHealButton:GetChecked());
	dbAdd("scanDps", scanForDpsButton:GetChecked());
	dbAdd("scanWoD", scanForWoDButton:GetChecked());
	dbAdd("scanTW", scanForTWButton:GetChecked());
	dbAdd("scanLFR", scanForLFRButton:GetChecked()); -- LFR not yet implemented
	dbAdd("satchels", satchelsReceived);
	dbAdd("showMainFrame", showUI);
	readConfig()
end

function readConfig() -- Reads values from DB
	if not SatchelScannerDB then
		SatchelScannerDB = {}
		dbUpdate();
	else
		playSound = SatchelScannerDB["sounds"];
		playSoundButton:SetChecked(playSound);
		raidWarnNotify = SatchelScannerDB["raidwarning"];
		raidWarningButton:SetChecked(raidWarnNotify);
		autoStart = SatchelScannerDB["autostart"];
		autoStartButton:SetChecked(autoStart);
		satchelsReceived = SatchelScannerDB["satchels"];
		UpdateInterval = SatchelScannerDB["updateint"];
		updateIntervalSlider:SetValue(UpdateInterval);
		dbVersion = SatchelScannerDB["version"];
		scanForTank = SatchelScannerDB["scanTank"];
		scanForHeal = SatchelScannerDB["scanHeal"];
		scanForDps = SatchelScannerDB["scanDps"];
		scanForWoD = SatchelScannerDB["scanWoD"];
		scanForTW = SatchelScannerDB["scanTW"];
		scanForLFR = SatchelScannerDB["scanLFR"]; -- LFR not yet implemented
		scanForDpsButton:SetChecked(scanForDps);
		scanForTankButton:SetChecked(scanForTank);
		scanForHealButton:SetChecked(scanForHeal);
		scanForWoDButton:SetChecked(scanForWoD);
		scanForTWButton:SetChecked(scanForTW);
		scanForLFRButton:SetChecked(scanForLFR); -- LFR not yet implemented
		showUI = SatchelScannerDB["showMainFrame"];
	end
	-- if SatchelScannerDB["version"] < "2.0.0" then (Stored for possible, later use)
	if not showUI then
		MainFrame:Hide();
	else
		MainFrame:Show();
	end
end

function dbAdd(var, arg) -- Updates values in db
	SatchelScannerDB[var] = arg;
end

-- Scanner - DO NOT MODIFY!
function satchelFinder(role, id)
		local eligible, forTank, forHealer, forDamage, itemCount, money, xp = GetLFGRoleShortageRewards(id, 1)
		if (itemCount ~= 0 or money ~= 0 or xp ~= 0) then
			if forTank and scanForTank and role == "tank" then
				return true;
			end
			if forHealer and scanForHeal and role == "heal" then
				return true;
			end
			if forDamage and scanForDps and role == "dps" then
				return true;
			end
		end
end

function SatchelScan(self, event, arg, arg2)
	if event == "ADDON_LOADED" and arg == "SatchelScanner" then
		readConfig();
		if SatchelScannerDB["satchels"] == null then
			dbAdd("satchels", 0);
			textDatabase.bagCounter.textFrame:SetText(satchelsReceived);
		else
			textDatabase.bagCounter.textFrame:SetText(satchelsReceived);
		end
	end
	if autoStart and not scanStopped and (scanForTank or scanForHeal or scanForDps) then
		startScanning();
	end
	if event == "CHAT_MSG_LOOT" and string.find(arg, "Savage Satchel of Cooperation") and not (MailFrame:IsShown() or TradeFrame:IsShown()) then
		satchelsReceived = satchelsReceived + 1;
		dbAdd("satchels", satchelsReceived);
		textDatabase.bagCounter.textFrame:SetText(satchelsReceived);
	end
	if running then		
		if event == "LFG_UPDATE_RANDOM_INFO" then
			-- Tank Scanner
			if scanForTank then
				queueText = ""; -- Reset Queue Text
				if scanForWoD then -- Scan Warlords of Draenor Heroics
					if satchelFinder("tank", 789) then
						foundSatchel("tank", 1);
					else
						noSatchel("tank", 1);
					end
				end -- End WoD Scan
				if scanForTW then -- Scan TimeWalking Instances
					if satchelFinder("tank", 995) then -- LK Timewalking
						foundSatchel("tank", 2);
					elseif satchelFinder("tank", 744) then -- BC Timewalking
						foundSatchel("tank", 3);
					elseif satchelFinder("tank", 1146) then -- Cata Timewalking
						foundSatchel("tank", 4);
					else
						if string.find(queueText, queueVar[2]) then
							queueText:gsub(queueVar[2],"");
							if queueText ~= "" then
								textDatabase.tankdg1.textFrame:SetText(queueText);
							else
								textDatabase.tankdg1.textFrame:SetText(scanVar[2]);
							end
						elseif string.find(queueText, queueVar[3]) then
							queueText:gsub(queueVar[3],"");
							if queueText ~= "" then
								textDatabase.tankdg1.textFrame:SetText(queueText);
							else
								textDatabase.tankdg1.textFrame:SetText(scanVar[2]);
							end
						elseif string.find(queueText, queueVar[4]) then
							queueText:gsub(queueVar[4],"");
							if queueText ~= "" then
								textDatabase.tankdg1.textFrame:SetText(queueText);
							else
								textDatabase.tankdg1.textFrame:SetText(scanVar[2]);
							end
						else
							textDatabase.tankdg1.textFrame:SetText(scanVar[2]);
						end
						textDatabase.tankScanningText.textFrame:SetText(classScan[2]);
						textDatabase.tankScanningText.textFrame:SetTextColor(unpack(yellowColor));
					end
				end -- End TW Scan
				if scanForLFR then -- Scan Looking for Raid
					if satchelFinder("tank", 849) or satchelFinder("tank", 850) or satchelFinder("tank", 851) or satchelFinder("tank", 846) or satchelFinder("tank", 847) or satchelFinder("tank", 848) or satchelFinder("tank", 823) or satchelFinder("tank", 982) or satchelFinder("tank", 983) or satchelFinder("tank", 984) or satchelFinder("tank", 985) or satchelFinder("tank", 986) then
						foundSatchel("tank", 5);
					else
						noSatchel("tank", 5);
					end
				end -- End LFR Scan
			end -- End Tank Scan
			-- Healer Scanner
			if scanForHeal then
				queueText = ""; -- Reset Queue Text
				if scanForWoD then -- Scan Warlords of Draenor Heroics
					if satchelFinder("heal", 789) then
						foundSatchel("heal", 1);
					else
						noSatchel("heal", 1);
					end
				end -- End WoD Scan
				if scanForTW then -- Scan TimeWalking Instances
					if satchelFinder("heal", 995) then -- LK Timewalking
						foundSatchel("heal", 2);
					elseif satchelFinder("heal", 744) then -- BC Timewalking
						foundSatchel("heal", 3);
					elseif satchelFinder("heal", 1146) then -- Cata Timewalking
						foundSatchel("heal", 4);
					else
						if string.find(queueText, queueVar[2]) then
							queueText:gsub(queueVar[2],"");
							if queueText ~= "" then
								textDatabase.healdg1.textFrame:SetText(queueText);
							else
								textDatabase.healdg1.textFrame:SetText(scanVar[2]);
							end
						elseif string.find(queueText, queueVar[3]) then
							queueText:gsub(queueVar[3],"");
							if queueText ~= "" then
								textDatabase.healdg1.textFrame:SetText(queueText);
							else
								textDatabase.healdg1.textFrame:SetText(scanVar[2]);
							end
						elseif string.find(queueText, queueVar[4]) then
							queueText:gsub(queueVar[4],"");
							if queueText ~= "" then
								textDatabase.healdg1.textFrame:SetText(queueText);
							else
								textDatabase.healdg1.textFrame:SetText(scanVar[2]);
							end
						else
							textDatabase.healdg1.textFrame:SetText(scanVar[2]);
						end
						textDatabase.healScanningText.textFrame:SetText(classScan[2]);
						textDatabase.healScanningText.textFrame:SetTextColor(unpack(yellowColor));
					end
				end -- End TW Scan
				if scanForLFR then -- Scan Looking for Raid
					if satchelFinder("heal", 849) or satchelFinder("heal", 850) or satchelFinder("heal", 851) or satchelFinder("heal", 846) or satchelFinder("heal", 847) or satchelFinder("heal", 848) or satchelFinder("heal", 823) or satchelFinder("heal", 982) or satchelFinder("heal", 983) or satchelFinder("heal", 984) or satchelFinder("heal", 985) or satchelFinder("heal", 986) then
						foundSatchel("heal", 5);
					else
						noSatchel("heal", 5);
					end
				end -- End LFR Scan
			end -- End Heal Scan
			-- Dps Scanner
			if scanForDps then
				queueText = ""; -- Reset Queue Text
				if scanForWoD then -- Scan Warlords of Draenor Heroics
					if satchelFinder("dps", 789) then
						foundSatchel("dps", 1);
					else
						noSatchel("dps", 1);
					end
				end -- End WoD Scan
				if scanForTW then -- Scan TimeWalking Instances
					if satchelFinder("dps", 995) then -- LK Timewalking
						foundSatchel("dps", 2);
					elseif satchelFinder("dps", 744) then -- BC Timewalking
						foundSatchel("dps", 3);
					elseif satchelFinder("dps", 1146) then -- Cata Timewalking
						foundSatchel("dps", 4);
					else
						if string.find(queueText, queueVar[2]) then
							queueText:gsub(queueVar[2],"");
							if queueText ~= "" then
								textDatabase.dpsdg1.textFrame:SetText(queueText);
							else
								textDatabase.dpsdg1.textFrame:SetText(scanVar[2]);
							end
						elseif string.find(queueText, queueVar[3]) then
							queueText:gsub(queueVar[3],"");
							if queueText ~= "" then
								textDatabase.dpsdg1.textFrame:SetText(queueText);
							else
								textDatabase.dpsdg1.textFrame:SetText(scanVar[2]);
							end
						elseif string.find(queueText, queueVar[4]) then
							queueText:gsub(queueVar[4],"");
							if queueText ~= "" then
								textDatabase.dpsdg1.textFrame:SetText(queueText);
							else
								textDatabase.dpsdg1.textFrame:SetText(scanVar[2]);
							end
						else
							textDatabase.dpsdg1.textFrame:SetText(scanVar[2]);
						end
						textDatabase.dpsScanningText.textFrame:SetText(classScan[2]);
						textDatabase.dpsScanningText.textFrame:SetTextColor(unpack(yellowColor));
					end
				end -- End TW Scan
				if scanForLFR then -- Scan Looking for Raid
					if satchelFinder("dps", 849) or satchelFinder("dps", 850) or satchelFinder("dps", 851) or satchelFinder("dps", 846) or satchelFinder("dps", 847) or satchelFinder("dps", 848) or satchelFinder("dps", 823) or satchelFinder("dps", 982) or satchelFinder("dps", 983) or satchelFinder("dps", 984) or satchelFinder("dps", 985) or satchelFinder("dps", 986) then
						foundSatchel("dps", 5);
					else
						noSatchel("dps", 5);
					end
				end -- End LFR Scan
			end -- End DPS Scan
			if scanForDps or scanForTank or scanForHeal then
				if not satchelFinder("tank", 789) and not satchelFinder("heal", 789) and not satchelFinder("dps", 789) then
					satchelFound = false;
				end
			end
		end
	end
end

function foundSatchel(role, var)
	satchelFound = true;
	if role == "tank" then
		textDatabase.tankScanningText.textFrame:SetText(classScan[3]);
		textDatabase.tankScanningText.textFrame:SetTextColor(unpack(greenColor));
		if not string.find(queueText, queueVar[var]) then
			queueText = queueText .. queueVar[var];
		end
		textDatabase.tankdg1.textFrame:SetText(queueText);
		if raidWarnNotify then
			RaidNotice_AddMessage(RaidWarningFrame, ctaVar[1], ChatTypeInfo["RAID_WARNING"])
		end
		if not MainFrame:IsShown() then
			MainFrame:Show();
		end
	elseif role == "heal" then
		textDatabase.healScanningText.textFrame:SetText(classScan[3]);
		textDatabase.healScanningText.textFrame:SetTextColor(unpack(greenColor));
		if not string.find(queueText, queueVar[var]) then
			queueText = queueText .. queueVar[var];
		end
		textDatabase.healdg1.textFrame:SetText(queueText);
		if raidWarnNotify then
			RaidNotice_AddMessage(RaidWarningFrame, ctaVar[1], ChatTypeInfo["RAID_WARNING"])
		end
		if not MainFrame:IsShown() then
			MainFrame:Show();
		end
	elseif role == "dps" then
		textDatabase.dpsScanningText.textFrame:SetText(classScan[3]);
		textDatabase.dpsScanningText.textFrame:SetTextColor(unpack(greenColor));
		if not string.find(queueText, queueVar[var]) then
			queueText = queueText .. queueVar[var];
		end
		textDatabase.dpsdg1.textFrame:SetText(queueText);
		if raidWarnNotify then
			RaidNotice_AddMessage(RaidWarningFrame, ctaVar[1], ChatTypeInfo["RAID_WARNING"])
		end
		if not MainFrame:IsShown() then
			MainFrame:Show();
		end
	end
end

function noSatchel(role, var)
	if role == "tank" then
		if string.find(queueText, queueVar[var]) then
			queueText:gsub(queueVar[var],"");
			if queueText ~= "" then
				textDatabase.tankdg1.textFrame:SetText(queueText);
			else
				textDatabase.tankdg1.textFrame:SetText(scanVar[2]);
			end
		else
			textDatabase.tankdg1.textFrame:SetText(scanVar[2]);
		end
		textDatabase.tankScanningText.textFrame:SetText(classScan[2]);
		textDatabase.tankScanningText.textFrame:SetTextColor(unpack(yellowColor));
	elseif role == "heal" then
		if string.find(queueText, queueVar[var]) then
			queueText:gsub(queueVar[var],"");
			if queueText ~= "" then
				textDatabase.healdg1.textFrame:SetText(queueText);
			else
				textDatabase.healdg1.textFrame:SetText(scanVar[2]);
			end
		else
			textDatabase.healdg1.textFrame:SetText(scanVar[2]);
		end
		textDatabase.healScanningText.textFrame:SetText(classScan[2]);
		textDatabase.healScanningText.textFrame:SetTextColor(unpack(yellowColor));
	elseif role == "dps" then
		if string.find(queueText, queueVar[var]) then
			queueText:gsub(queueVar[var],"");
			if queueText ~= "" then
				textDatabase.dpsdg1.textFrame:SetText(queueText);
			else
				textDatabase.dpsdg1.textFrame:SetText(scanVar[2]);
			end
		else
			textDatabase.dpsdg1.textFrame:SetText(scanVar[2]);
		end
		textDatabase.dpsScanningText.textFrame:SetText(classScan[2]);
		textDatabase.dpsScanningText.textFrame:SetTextColor(unpack(yellowColor));
	end
end

function uiConfig() -- Draws Config Panel --
	SatchelScanner = {};
	SatchelScanner.panel = CreateFrame("Frame", "SatchelScannerInfo", UIParent );
	SatchelScanner.panel.name = "Satchel Scanner";
	InterfaceOptions_AddCategory(SatchelScanner.panel);

	SatchelScanner.childpanel = CreateFrame("Frame", "SatchelScannerConfig", SatchelScanner.panel);
	SatchelScanner.childpanel.name = "Options";
	SatchelScanner.childpanel.parent = SatchelScanner.panel.name;
	InterfaceOptions_AddCategory(SatchelScanner.childpanel);
	SatchelScanner.panel.okay = function(self) dbUpdate(); end;
	
 	configurationText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	configurationText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 18, "OUTLINE");
	configurationText:SetPoint("TOP", 0, -7);
	configurationText:SetText("Satchel Scanner Configuration!");
	
	-- Scanner Options
	scanOptionText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	scanOptionText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 16, "OUTLINE");
	scanOptionText:SetPoint("TOPLEFT", 10, -16);
	scanOptionText:SetText("|cffff0000Scanning Options|r");
	scanOptionText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	scanOptionText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 14, "OUTLINE");
	scanOptionText:SetPoint("TOPLEFT", 12, -36);
	scanOptionText:SetText("|cff00ccffClass Types|r");
	scanOptionText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	scanOptionText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 14, "OUTLINE");
	scanOptionText:SetPoint("TOPLEFT", 170, -36);
	scanOptionText:SetText("|cff00ccffDungeon Types|r");
	-- Tank CheckBox
	scanForTankButton = CreateFrame("CheckButton", nil, SatchelScanner.childpanel, "ChatConfigCheckButtonTemplate");
	scanForTankButton:SetPoint("TOPLEFT", 8, -50);
 	scanForTankText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	scanForTankText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 14, "OUTLINE");
	scanForTankText:SetPoint("TOPLEFT", 30, -54);
	scanForTankText:SetText("Scan for Tank Satchels");
	-- Healer CheckBox
	scanForHealButton = CreateFrame("CheckButton", nil, SatchelScanner.childpanel, "ChatConfigCheckButtonTemplate");
	scanForHealButton:SetPoint("TOPLEFT", 8, -70);
 	scanForHealText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	scanForHealText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 14, "OUTLINE");
	scanForHealText:SetPoint("TOPLEFT", 30, -74);
	scanForHealText:SetText("Scan for Healer Satchels");
	-- DPS CheckBox
	scanForDpsButton = CreateFrame("CheckButton", nil, SatchelScanner.childpanel, "ChatConfigCheckButtonTemplate");
	scanForDpsButton:SetPoint("TOPLEFT", 8, -90);
 	scanForDpsText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	scanForDpsText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 14, "OUTLINE");
	scanForDpsText:SetPoint("TOPLEFT", 30, -94);
	scanForDpsText:SetText("Scan for DPS Satchels");
	--WOD CheckBox
	scanForWoDButton = CreateFrame("CheckButton", nil, SatchelScanner.childpanel, "ChatConfigCheckButtonTemplate");
	scanForWoDButton:SetPoint("TOPLEFT", 170, -50);
 	scanForWoDText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	scanForWoDText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 14, "OUTLINE");
	scanForWoDText:SetPoint("TOPLEFT", 192, -54);
	scanForWoDText:SetText("Scan for WoD Heroics");
	--TW CheckBox
	scanForTWButton = CreateFrame("CheckButton", nil, SatchelScanner.childpanel, "ChatConfigCheckButtonTemplate");
	scanForTWButton:SetPoint("TOPLEFT", 170, -70);
 	scanForTWText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	scanForTWText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 14, "OUTLINE");
	scanForTWText:SetPoint("TOPLEFT", 192, -74);
	scanForTWText:SetText("Scan for TimeWalking");
	--LFR CheckBox
	scanForLFRButton = CreateFrame("CheckButton", nil, SatchelScanner.childpanel, "ChatConfigCheckButtonTemplate");
	scanForLFRButton:SetPoint("TOPLEFT", 170, -90);
 	scanForLFRText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	scanForLFRText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 14, "OUTLINE");
	scanForLFRText:SetPoint("TOPLEFT", 192, -94);
	scanForLFRText:SetText("Scan for Looking for Raid");	
	
	-- Notification Options
	scanOptionText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	scanOptionText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 16, "OUTLINE");
	scanOptionText:SetPoint("TOPLEFT", 10, -122);
	scanOptionText:SetText("|cffff0000Notification Options|r");
	-- Sound CheckBox
	playSoundButton = CreateFrame("CheckButton", nil, SatchelScanner.childpanel, "ChatConfigCheckButtonTemplate");
	playSoundButton:SetPoint("TOPLEFT", 8, -138);
 	playSoundText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	playSoundText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 14, "OUTLINE");
	playSoundText:SetPoint("TOPLEFT", 30, -142);
	playSoundText:SetText("Play Soundwarning");
	-- Raidwarning CheckBox
	raidWarningButton = CreateFrame("CheckButton", nil, SatchelScanner.childpanel, "ChatConfigCheckButtonTemplate");
	raidWarningButton:SetPoint("TOPLEFT", 8, -154);
 	raidWarningText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	raidWarningText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 14, "OUTLINE");
	raidWarningText:SetPoint("TOPLEFT", 30, -158);
	raidWarningText:SetText("Show Raidwarning");
	-- Slider for Scanner Interval
	sliderText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	sliderText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 16, "OUTLINE");
	sliderText:SetPoint("TOPLEFT", 145, -195);
	sliderText2 = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	sliderText2:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 14, "OUTLINE");
	sliderText2:SetPoint("TOPLEFT", 10, -178);
	sliderText2:SetText("Update Interval in Seconds");
	updateIntervalSlider = CreateFrame("Slider", nil, SatchelScanner.childpanel, "OptionsSliderTemplate")
	updateIntervalSlider:SetScript("OnValueChanged", function(self) sliderText:SetText(updateIntervalSlider:GetValue()); end)
	updateIntervalSlider:SetPoint("TOPLEFT", 10, -193);
	updateIntervalSlider:SetWidth(130);
	updateIntervalSlider:SetHeight(20);
	updateIntervalSlider:SetOrientation('HORIZONTAL');
	updateIntervalSlider:SetMinMaxValues(1, 10);
	updateIntervalSlider:SetValueStep(1);
	updateIntervalSlider:Show();
	
	-- Miscellaneous Options
	scanOptionText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	scanOptionText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 16, "OUTLINE");
	scanOptionText:SetPoint("TOPLEFT", 10, -228);
	scanOptionText:SetText("|cffff0000Miscellaneous Options|r");
	-- Auto Start CheckBox
	autoStartButton = CreateFrame("CheckButton", nil, SatchelScanner.childpanel, "ChatConfigCheckButtonTemplate");
	autoStartButton:SetPoint("TOPLEFT", 8, -244);
 	autoStartText = SatchelScanner.childpanel:CreateFontString(nil, "OVERLAY")
	autoStartText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 14, "OUTLINE");
	autoStartText:SetPoint("TOPLEFT", 30, -248);
	autoStartText:SetText("Auto Start Scanning");
end

function drawFrames() -- Draws the MainFrame --
	uiConfig();
	MainFrame = CreateFrame("Frame", "DragFrame2", UIParent)
	MainFrame:SetMovable(true)
	MainFrame:EnableMouse(true)
	MainFrame:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" and not self.isMoving then
			self:StartMoving();
			self.isMoving = true;
		end
	end)
	MainFrame:SetScript("OnMouseUp", function(self, button)
		if button == "LeftButton" and self.isMoving then
			self:StopMovingOrSizing();
			self.isMoving = false;
		end
	end)
	MainFrame:SetScript("OnHide", function(self)
		if ( self.isMoving ) then
			self:StopMovingOrSizing();
			self.isMoving = false;
		end
	end)
	MainFrame:SetWidth(256);
	MainFrame:SetHeight(150);
	MainFrame:SetPoint("BOTTOMLEFT", 800, 400);
	MainFrame:SetFrameStrata("BACKGROUND")
	MainFrame:SetBackdrop({ 
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
		edgeFile = "Interface\\Addons\\SatchelScanner\\border\\border.tga", tile = false, tileSize = 0, edgeSize = 8, 
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	});
	bgAlpha = 0.5;
	MainFrame:SetBackdropColor(0,0,0,bgAlpha);
	MainFrame:SetBackdropBorderColor(0,0,0,bgAlpha);
	for i, frameData in pairs(frameDatabase) do -- This is for drawing each texture.
		frameData.frame = CreateFrame(frameData.Type,nil,MainFrame, UIPanelButtonTemplate);
		frameData.frame:SetWidth(frameData.width);
		frameData.frame:SetHeight(frameData.height);
		frameData.frame:SetPoint(frameData.loc, frameData.x, frameData.y);
		frameData.frame:SetNormalTexture(frameData.normalTxt);
		frameData.frame:SetPushedTexture(frameData.pushedTxt);
		frameData.frame:SetHighlightTexture(frameData.highLightTxt);
		frameData.frame:GetNormalTexture():SetTexCoord(frameData.zxscale,frameData.xscale,frameData.zscale,frameData.yscale);
		if frameData.texture then
			frameData.frame:GetPushedTexture():SetTexCoord(frameData.zxscale,frameData.xscale,frameData.zscale,frameData.yscale);
			frameData.frame:GetHighlightTexture():SetTexCoord(frameData.zxscale,frameData.xscale,frameData.zscale,frameData.yscale);
		end
		if frameData.text then
			local buttonText = frameData.frame:CreateFontString(nil, "OVERLAY")
			buttonText:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", 14, "");
			buttonText:SetPoint("CENTER", 0, 0);
			buttonText:SetTextColor(unpack(yellowColor));
			buttonText:SetText(frameData.text);
		end
		if frameData.script then
			frameData.frame:SetScript("OnClick", loadstring(frameData.functionName));
		end
		if frameData.setAlpha then
			frameData.frame:SetAlpha(bgAlpha);
		end
	end
end

function drawText() -- Draws the Text -- 
	for i, controlData in pairs(textDatabase) do
		controlData.textFrame = MainFrame:CreateFontString(nil, "OVERLAY")
		controlData.textFrame:SetFont("Interface\\Addons\\SatchelScanner\\fonts\\font.TTF", controlData.fontSize, controlData.outLine);
		controlData.textFrame:SetPoint(controlData.loc, controlData.x, controlData.y);
		controlData.textFrame:SetTextColor(unpack(controlData.color));
		controlData.textFrame:SetText(controlData.text);
	end
end

-- On Load
function SatchelScanner_OnLoad(self)
	printm("Satchel Scanner v" .. addonVersion .. " Loaded!");
	printm("->> Type /ss3 for commands!");
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("LFG_UPDATE_RANDOM_INFO");
	self:RegisterEvent("CHAT_MSG_LOOT");
	self:SetScript("OnEvent", SatchelScan)
	drawFrames();
	drawText();
	SLASH_SATCHELSCANNER1, SLASH_SATCHELSCANNER2 = "/satchelscan", "/ss3"
	SlashCmdList.SATCHELSCANNER = function(msg)
		if msg == "toggle" then
			if MainFrame:IsShown() then
				MainFrame:Hide();
				showUI = false;
			else
				MainFrame:Show();
				showUI = true;
			end
			dbUpdate();
		elseif msg == "reset" then
			printm("This function is not yet in use");
		elseif msg == "config" then
			InterfaceOptionsFrame_OpenToCategory(SatchelScanner.childpanel);
		else
			printm("====== Satchel Scanner ======");
			printm("->> Type '/ss3 toggle' to show/hide the frame");
			printm("->> Type '/ss3 reset' to reset the addon");
			printm("->> Type '/ss3 config' to configure the addon");
		end
		msg = ""
	end
end

function printm(msg)
	print("|cFFFF007F" .. msg  .. "|r");
end

function SatchelScanner_OnUpdate(self, elapsed)
	if running then
		self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
		while (self.TimeSinceLastUpdate > UpdateInterval) do
			RequestLFDPlayerLockInfo();
			if satchelFound and playSound and running then
				PlaySoundFile("Sound\\interface\\RaidWarning.ogg", "Master")
			end
			self.TimeSinceLastUpdate = self.TimeSinceLastUpdate - UpdateInterval;
		end
	end
end

