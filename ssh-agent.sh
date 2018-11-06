#!/usr/bin/env bash

export SSH_ENV="$HOME/.ssh/agent-macbook-pro"
export AGENTALIVE=0

# Start an ssh-agent and write out the details to $SSH_ENV
function agent_start() {
  echo -n " [i] Initializing a new SSH agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo -n "$SSH_ENV "
  chmod 600 "${SSH_ENV}"
  source "${SSH_ENV}" > /dev/null
  echo
}

# Reconnect to the last ssh-agent that was loaded
function agent_restore_or_start() {
  if [[ -f $SSH_ENV ]]
  then
    source $SSH_ENV
    agent_check_alive
  else
    agent_start
    agent_check_alive
  fi
}

function agent_check_alive() {
  # Check to see if there are any ssh-agents running on the PID
  # that we loaded from the agent file.
  if [[ $SSH_AGENT_PID ]]; then
    AGENTALIVE=$(ps wwaux | grep [s]sh-agent |grep -c $SSH_AGENT_PID)
    if [[ $AGENTALIVE -ne 1 ]]
    then
      # Check to see if this is an interactive session. If so then echo stuff. If not, don't.
      if [[ $- =~ "i" ]]
      then
        start_agent
        AGENTALIVE=$(ps wwaux | grep [s]sh-agent |grep -c $SSH_AGENT_PID)
      fi
    fi
  else
    AGENTALIVE=0
  fi

  # If the agent is alive, check to see if there are any loaded keys
  if [[ $AGENTALIVE -eq 1 ]]; then
    # Check to see if this is an interactive session. If so then echo stuff. If not, don't.
    if [[ $- =~ "i" ]]
    then
      no_key_loaded=$(ssh-add -l | grep -c "The agent has no identities.")
      if [[ $no_key_loaded -eq 1 ]]; then
        echo " [!] no loaded ssh keys"
        if [[ -e ~/.ssh/id_rsa ]] || [[ -e ~/.ssh/id_ed25519 ]]; then
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
}

agent_restore_or_start
