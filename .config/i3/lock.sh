#!/usr/bin/env bash
 
#overlay="$HOME/pictures/lock_overlay.png"
#image="/tmp/screen.png"
 
#param="--textcolor=ffffff00 --insidecolor=e8dcd000 --ringcolor=e8dcd088 --linecolor=2d283e00 --keyhlcolor=e8dcd0ff --ringvercolor=E9A66Cff --separatorcolor=22222200 --insidevercolor=fadd5c00 --ringwrongcolor=CE325Bff --insidewrongcolor=f1345900 "

# Remove old temporary files
rm /tmp/screen.png
rm /tmp/screen_blur.png
rm /tmp/screen_final.png

# Takes screenshot of the display
ffmpeg -loglevel quiet -f x11grab -video_size 1920x1080 -y -i $DISPLAY -vframes 1 /tmp/screen.png

# Blurs the screenshot
ffmpeg -loglevel quiet -i /tmp/screen.png -filter_complex \
  "[0:v]boxblur=luma_radius=10:chroma_radius=10:luma_power=1[blurred]" \
  -map "[blurred]" /tmp/screen_blur.png

# Overlays an image of a lock
ffmpeg -loglevel quiet -i /tmp/screen_blur.png -i ~/.config/i3/assets/lock.png -filter_complex "[1]scale=iw/1:-1[b];[0:v][b] overlay" /tmp/screen_final.png

# Locks the screen with the image we created
i3lock -i /tmp/screen_final.png