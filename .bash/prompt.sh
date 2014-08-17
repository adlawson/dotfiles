# This file is managed by adlawson/dotfiles
#
# Copyright (c) 2014 Andrew Lawson <http://adlawson.com>
#
# For the full copyright and license information, please view the LICENSE
# file that was distributed with this source code.

function __name_and_server {
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        echo "\u@\h"
    else
        echo "\u"
    fi
}

PS1="$(__name_and_server) \w\$ "
