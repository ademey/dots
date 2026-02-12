#!/bin/bash
SESSION="peak"

# Kill existing session if it exists
tmux kill-session -t $SESSION 2>/dev/null

# Create session with first window
tmux new-session -d -s $SESSION -c ~/Dev/peak/peakhealth-web -n 'web'

# Second window - Backend
tmux new-window -t $SESSION -n 'backend' -c ~/Dev/peak/Backend

# Third window - split vertically
tmux new-window -t $SESSION -n 'split' -c ~/Dev/peak/peakhealth-web
tmux split-window -h -t $SESSION:2 -c ~/Dev/peak/peakhealth-web

# Select first window
tmux select-window -t $SESSION:0

# Attach
tmux attach -t $SESSION
