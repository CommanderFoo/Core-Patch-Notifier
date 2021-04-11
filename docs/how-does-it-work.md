# How Does It Work?

It's actually a very simple system that makes use of `Leaderboards`.

When you issue the `/patch` command, a new timestamp (in the future) is submitted to the leaderboard.  The leaderboard is then polled to see if there is a score that is greater than the current time.  If there is, then we issue a notification to all players on the server.

To prevent players constantly getting the notification, we store the current patch timestamp as a resource.  The reason for this is so that the component doesn't mess with any player storage.  It keeps things simple.  The only downside is if he player leaves the server and rejoins, they will get the notification again.  This I think is a fair tradeoff.