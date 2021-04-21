local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local root = script.parent.parent

local notification_stay_time = root:GetCustomProperty("notification_stay_time")
local show_chat_message = root:GetCustomProperty("show_chat_message")
local show_notification = root:GetCustomProperty("show_notification")

local notification = script:GetCustomProperty("notification"):WaitForObject()

local tween = nil
local local_player = Game.GetLocalPlayer()

function Tick(dt)
	if(tween ~= nil) then
		tween:tween(dt)
	end
end

function change(c)
	notification.x = c.x
end

function show_notification()
	if(local_player:GetResource("patch_notification_seen") ~= 0) then
		return
	end

	if(show_chat_message) then
		Chat.LocalMessage(notification:FindChildByName("Message").text)
	end

	if(not show_notification) then
		return
	end

	tween = YOOTIL.Tween:new(.6, { x = -400 }, { x = 50 })

	tween:on_start(function()
		notification.visibility = Visibility.FORCE_ON
	end)

	tween:set_easing("outBack")
	tween:on_change(change)
	
	tween:on_complete(function()
		tween = nil
		tween = YOOTIL.Tween:new(.6, { x = 50 }, { x = -400 })

		tween:set_easing("inBack")
		tween:on_change(change)
		tween:set_delay(notification_stay_time)
		tween:on_complete(function()
			tween = nil
			notification.visibility = Visibility.FORCE_OFF
		end)
	end)
end

Events.Connect("display_patch_notification", show_notification)
