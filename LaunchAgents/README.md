# LaunchAgents

This directory holds LaunchAgent files to be read by `launchd`, macOS's
successor to `cron`. I use it over `cron` specifically because it supports
running scheduled tasks even when the machine (e.g. a MacBook) is asleep during
the scheduled time.

Symlinks to these files are created in `~/Library/LaunchAgents` by
`./run_onchange_configure_system.sh`.

See more at the [LaunchAgent docs][launchagent].

[launchagent]: https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/ScheduledJobs.html#//apple_ref/doc/uid/10000172i-CH1-SW2).
