# bash-ssh-agent

## Purpose

This is a series of functions to be included in your ~/.bash_profile, which:
* Checks if you have an existing ssh-agent session
* Confirms ssh-agent still alive, and if not launches a new ssh-agent
* Writes a few ssh-agent-related environment variables to a file
* Loads your SSH keys if your ssh-agent is empty of keys

## Show me

```
 [i] Initializing a new SSH agent.../Users/pdufault/.ssh/agent-macbook-pro
 [!] No loaded ssh keys
Identity added: /Users/pdufault/.ssh/id_rsa (/Users/pdufault/.ssh/id_rsa)
Enter passphrase for /Users/pdufault/.ssh/id_ed25519:
Identity added: /Users/pdufault/.ssh/id_ed25519 (Phil Dufault (phil@dufault.info))
$
```
