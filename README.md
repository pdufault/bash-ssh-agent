# bash-ssh-agent

## Purpose

This is a series of functions to be included in your ~/.bash_profile, which:
* checks if you have an existing ssh-agent session
* confirms ssh-agent still alive, and if not launches a new ssh-agent
* writes a few ssh-agent-related environment variables to a file
* loads your SSH keys if your ssh-agent is empty of keys

## Show me

```
 [i] Initializing a new SSH agent.../Users/pdufault/.ssh/agent-macbook-pro
 [!] no loaded ssh keys
Identity added: /Users/pdufault/.ssh/id_rsa (/Users/pdufault/.ssh/id_rsa)
Enter passphrase for /Users/pdufault/.ssh/id_ed25519:
Identity added: /Users/pdufault/.ssh/id_ed25519 (Phil Dufault (phil@dufault.info))
$
```
