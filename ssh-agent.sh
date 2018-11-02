#!/usr/bin/env bash

SSH_ENV="$HOME/.ssh/agent-macbook-pro"
SSH_AGENT_PID="$HOME/.ssh/agent.pid"

function start_agent() {
     echo -n " [i] Initializing a new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo -n "$SSH_ENV "
     chmod 600 "${SSH_ENV}"
     source "${SSH_ENV}" > /dev/null
}

# Reconnect to the last ssh-agent that was loaded
if [[ -f $SSH_ENV ]]
then
  source $SSH_ENV
fi

# Check to see if there are any ssh-agents running on the PID
# that we loaded from the agent file.
AGENTALIVE=$(ps wwaux | grep -v grep |grep ssh-agent |grep -c $SSH_AGENT_PID)
if [[ $AGENTALIVE -ne 1 ]]
then
  # Check to see if this is an interactive session. If so then echo stuff. If not, don't.
  if [[ $- =~ "i" ]]
  then
    start_agent
    echo " [!] no loaded ssh keys"
  fi
fi

# If the agent is alive, check to see if there are any loaded keys
if [[ $AGENTALIVE -eq 1 ]]; then
  # Check to see if this is an interactive session. If so then echo stuff. If not, don't.
  if [[ $- =~ "i" ]]
  then
    no_key_loaded=$(ssh-add -l | grep -c "The agent has no identities.")
    if [[ $no_key_loaded -eq 1 ]]; then
      echo " [!] no loaded ssh keys"
      if [[ -e ~/.ssh/id_rsa ]]; then
        ssh-add
      fi
    else
    # If you suffix your keys with _rsa or _dsa and want that trimmed out, use this line
    # var=$(ssh-add -l | awk '{print $3}' | sed -e 's,.*/,,g' -e 's,_rsa,,g' -e 's,_dsa,,g' | xargs)
    # Otherwise use this line
      var=$(ssh-add -l | awk '{print $3}' | sed -e 's,.*/,,g' | xargs)
      echo " [x] loaded ssh keys: $var"
    fi
  fi
fi
