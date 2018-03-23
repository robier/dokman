#!/usr/bin/env bash


###
 # Checks if rich text is supported in current stdout or stderr
 #
 # @return bool
###
function isRichTextSupported()
{
    if ! isTty ; then
        false
        return
    fi

    local colors
    colors=$(tput colors)

    if [ -n "${colors}" ] && [ "${colors}" -ge 8 ]; then
        return
    fi

    false
}
