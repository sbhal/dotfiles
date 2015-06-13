#bin/sh

export CCACHE_DIR=.ccache 
export USE_CCACHE=1

prebuilts/misc/linux-x86/ccache/ccache -M 30G
