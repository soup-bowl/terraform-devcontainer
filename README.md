# Casey's Terraform Devcontainer
Prebaked with Terraform goodies, and the tools needed for authorising providers.

Currently comes with:
* Terraform
  * TFLint
  * TFSec
  * Terradocs
  * Sentinel
* AWS and Azure CLI tooling
* Oracle Cloud CLI
* GitHub CLI

And access to these repos:
* [soup-bowl/servers][tf-s]
* [soup-bowl/tf-practice][tf-p]

Wait a little while for the initalisation, then you'll get an open workspace notification. If not, once finished open `cloudops.code-workspace` to get the full access.

## Provider Logins

### Azure

`az login`

**lza/admin only** There is a SAS token stored in `ARM_SAS_TOKEN` that is managed from [**servers**][tf-s], that has access to the state files.

### Amazon web Services

`aws login --remote`

This is a bit janky. This gives you a huge URL, you can utilise `shorturl` or `qrencode` to help transmit to whatever device handles logging in. It replies with an equally huge code, I recommend using a secret Gist and `latestgist` to retrieve it (if logged in to GitHub as admin).

This expires frequently - use `awscreds` to renew the session token.

### Oracle Cloud

**lza/admin only** When it works, use `oci session authenticate`. token expires after 30-60 mins.

When it stops working, you can hijack the servers/infra approach. This isn't default though as... well, chicken-and-egg.

### GitHub

**lza/admin only** - In the terminal session, unset `GITHUB_TOKEN` and use `gh auth login`.

### Cloudflare

API tokens only. The instructional prompt will instruct you how to login and with what token scope, otherwise use should be auto-managed by the projects' LZ.

### Tailscale

API tokens only. The instructional prompt will instruct you how to login.

###

[tf-s]: https://github.com/soup-bowl/servers
[tf-p]: https://github.com/soup-bowl/tf-practice
