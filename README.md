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

These convenience scripts:
* `qrencode` - Run like `qrencode -t ANSIUTF8 "Something"` and it makes a scannable URL for auth purposes.
* `shorturl` - Plops the provided URL into a tinyurl.
* `awscreds` - Puts the authenticated AWS user credentials into envs used by Terraform.
  * Can be tempermental, just check the code and run it manually if so.
* `latestgist` - Get the latest gist contents, if using it to pass along the AWS login token. **Needs logging in to GitHub CLI explicitly, else it'll return the last public gist**.

And access to these repos:
* [soup-bowl/servers][tf-s]
* [soup-bowl/tf-practice][tf-p]

Wait a little while for the initalisation, then you'll get an open workspace notification. If not, once finished open `cloudops.code-workspace` to get the full access.

> [!NOTE]  
> Any aspects managed by Terraform will come from the [**Servers' lza** repository][tf-s].

## Provider Logins

### Azure

`az login`

> [!NOTE]  
> Required for lza actions - non-lza runs should have an automatic authorisation.

There is a SAS token stored in `ARM_SAS_TOKEN` that is managed from [**servers**][tf-s], that has access to the state files.

### Amazon web Services

`aws login --remote`

This is a bit janky. This gives you a huge URL, you can utilise `shorturl` or `qrencode` to help transmit to whatever device handles logging in. It replies with an equally huge code, I recommend using a secret Gist and `latestgist` to retrieve it (if logged in to GitHub as admin).

This expires frequently - use `awscreds` to renew the session token.

### Oracle Cloud

 `oci session authenticate`

> [!NOTE]  
> Required for lza actions - non-lza runs should have an automatic authorisation.

When it works. token expires after 30-60 mins.

When it stops working, you can hijack the servers/infra approach. This isn't default though as... well, chicken-and-egg.

### GitHub

`unset GITHUB_TOKEN && gh auth login`

> [!NOTE]  
> Required for lza actions - non-lza runs should have an automatic authorisation.

Works for the active TTY but is unset for others. Say no to using it for Git auth.

### Cloudflare

API tokens only. The instructional prompt will instruct you how to login and with what token scope, otherwise use should be auto-managed by the projects' LZ.

### Tailscale

API tokens only. The instructional prompt will instruct you how to login.

###

[tf-s]: https://github.com/soup-bowl/servers
[tf-p]: https://github.com/soup-bowl/tf-practice
