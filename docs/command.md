# Patch Command

To notify your players that a patch is being deployed soon you can use the `/patch` command in the Chat.

This command can only be used by the player who has been set as the `admin_user`.

If no parameter is passed, then a default of 5 minutes will be used.

The command has a second parameter where you can specify how much time to add (in seconds).  So for example, if you use the command `/patch 60` then all players currently playing your game will receive a notification, and any players that join your game before 60 seconds is up will also receive the notification.

So let's say you are ready to update your game, but want to give players about 15 minutes warning that a patch will be deployed.  You would join a server and issue the command `/patch 900`.  After 15 minutes you would then deploy your patch.  

Try not to deploy your patch before the notification time is up, otherwise players will still get a notification when they join your game after the patch is released.