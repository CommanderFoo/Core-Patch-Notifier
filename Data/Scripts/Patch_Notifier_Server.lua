local root = script.parent.parent

local leaderboard = root:GetCustomProperty("leaderboard")
local admin_user = root:GetCustomProperty("admin_user")
local poll_time = root:GetCustomProperty("poll_time")

Chat.receiveMessageHook:Connect(function(speaker, params)
	if(speaker.name == admin_user) then
		local command, duration = CoreString.Split(params.message, " ")

		if(command and command == "/patch") then
			local t = 300

			if(duration) then
				t = math.floor(tonumber(duration))
			end

			Leaderboards.SubmitPlayerScore(leaderboard, speaker, os.time() + t)
			params.message = ""
		end
	end
end)

local checker_task = Task.Spawn(function()
	if(not leaderboard.isAssigned) then
		return
	end

	if(Leaderboards.HasLeaderboards()) then
		local patch_leaderboard = Leaderboards.GetLeaderboard(leaderboard, LeaderboardType.GLOBAL)

		if(patch_leaderboard and #patch_leaderboard > 0) then
			local now = os.time()
			local when = math.floor(patch_leaderboard[1].score)

			if(when > now) then
				Events.BroadcastToAllPlayers("display_patch_notification")
			end

			--print(now, when)

			if(when > 0) then
				for i, p in ipairs(Game.GetPlayers()) do
					if(p:GetResource("patch_notification_seen") ~= when and p:GetResource("patch_notification_seen") > 0) then
						p:SetResource("patch_notification_seen", 0)
					else
						p:SetResource("patch_notification_seen", when)
					end
				end
			end
		end
	end
end, 5)

if(not leaderboard.isAssigned) then
	warn("Patch Notifier: You have not setup the \"leaderboard\" property.")
else
	checker_task.repeatCount = -1
	checker_task.repeatInterval = poll_time
end

if(not admin_user or string.len(admin_user) == 0) then
	warn("Patch Notifier: You have not setup an admin user for permission to use the /patch command.")
end

script.destroyEvent:Connect(function()
	checker_task:Cancel()
end)