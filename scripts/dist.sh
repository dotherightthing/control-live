#!/bin/bash

# File: ./scripts/dist.sh
# Description: Copy relevant files to the dist folder
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
set -e



# if $GITHUB_ACTIONS does not exist 'then' script is being run locally
# TODO compile/copy to dist
# then copy to ~/Library/Application\ Support/control-traktor/live
# then copy to Live User Library etc if not CI
if [ -z "$GITHUB_ACTIONS" ]
then
  cd "$INIT_CWD" \
  && echo "Compiling JavaScript" \
  && babel "./src/live/Audio Effects/Max Audio Effect/*.js" -d                       ~/"Music/Ableton/User Library/Presets/Audio Effects/Max Audio Effect" \
  && echo "Installing configuration files for ClyphX Pro" \
  && cp -r "./src/clyphx-pro/"*                                                      ~/"nativeKONTROL/ClyphX_Pro" \
  && echo "Installing Ableton Live patches and presets" \
  && cp "./src/live/Audio Effects/Audio Effect Rack/SD Master.adj"                   ~/"Music/Ableton/User Library/Presets/Audio Effects/Audio Effect Rack" \
  && cp "./src/live/Audio Effects/Max Audio Effect/CL Presample Selected Track.amxd" ~/"Music/Ableton/User Library/Presets/Audio Effects/Max Audio Effect" \
  && cp "./src/live/Audio Effects/Max Audio Effect/CL Rename Selected Track.amxd"    ~/"Music/Ableton/User Library/Presets/Audio Effects/Max Audio Effect" \
  && echo "Copying files from ./src to ./dist" \
  && cp "./src/bome-midi-translator-pro/"*.bmtp                                      "./dist" \
  && cp -r "./src/live/"*                                                            "./dist" \
  && cp "./README.md"                                                                "./dist" \
  && cp "./submodules/streamdeck-xl/profiles/live/Live.streamDeckProfile"            "./dist" \
  && echo "Dist tasks complete"
else
  cd "$INIT_CWD" \
  && echo "Compiling JavaScript" \
  && babel "./src/live/Audio Effects/Max Audio Effect/*.js" -d                       "~/Music/Ableton/User Library/Presets/Audio Effects/Max Audio Effect" \
  && echo "Copying files from ./src to ./dist" \
  && cp "./src/bome-midi-translator-pro/"*.bmtp                                      "./dist" \
  && cp -r "./src/live/"*                                                            "./dist" \
  && cp "./README.md"                                                                "./dist" \
  && cp "./submodules/streamdeck-xl/profiles/live/Live.streamDeckProfile"            "./dist" \
  && cp "./src/traktor/"*.png                                                        "./dist" \
  && cp "./src/traktor/"*.tsi                                                        "./dist" \
  && echo "Dist tasks complete"
fi
