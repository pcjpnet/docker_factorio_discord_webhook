# docker_factorio_discord_webhook

Factorio Server with Discord Webhook Notification

based on this image

 - https://hub.docker.com/r/factoriotools/factorio
 - https://github.com/factoriotools/factorio-docker


# Usage

Set Discord Webhook URL to $WEBHOOK.

Set text to $TEXT_START, $TEXT_LOGIN, $TEXT_LOGOUT.


## Settings for LAN Play

/factorio/config/server-settings.json


"public": false,

"require_user_verification": false,

