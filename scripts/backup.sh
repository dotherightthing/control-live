#!/bin/bash

# File: ./scripts/backup.sh
# Description: Backup files that are created and managed externally
#
# Note:
# chmod a+x = Change access permissions of this file, to 'e[x]ecutable' for '[a]ll users'
#
# Example:
# ---
# chmod a+x scripts/*.sh
# ---

# e: exit the script if any statement returns a non-true return value
# v: print shell input lines as they are read (including all comments!)
# suppress both error message and exit code: 2>/dev/null || :
set -e

# if $GITHUB_ACTIONS does not exist 'then' script is being run locally
if [ -z "$GITHUB_ACTIONS" ]
then
  cd "$INIT_CWD" \
  && echo "Backing up ClyphX Pro support files" \
  && cp ~/"nativeKONTROL/ClyphX_Pro/X-Controls.txt"                                                            "./src/clyphx-pro" \
  && echo "Backing up Live support files" \
  && cp ~/"Music/Ableton/User Library/Presets/Audio Effects/Max Audio Effect/CL Presample Selected Track.amxd" "./src/live/Audio Effects/Max Audio Effect" 2>/dev/null || : \
  && cp ~/"Music/Ableton/User Library/Presets/Audio Effects/Max Audio Effect/CL Rename Selected Track.amxd"    "./src/live/Audio Effects/Max Audio Effect" 2>/dev/null || : \
  && cp ~/"Music/Ableton/User Library/Presets/Audio Effects/Max Audio Effect/*cl-*.js"                         "./src/live/Audio Effects/Max Audio Effect" 2>/dev/null || : \
  && cp ~/"Music/Ableton/User Library/Presets/Audio Effects/Audio Effect Rack/MAIN OUT.adg"                    "./src/live/Audio Effects/Audio Effect Rack" 2>/dev/null || : \
  && echo "Backing up Loopback support files" \
  && cp ~/"Library/Application Support/Loopback/"*.plist                                                       "./src/loopback" \
  && echo "Backup tasks complete"
else
  echo "CI, exiting"
fi
