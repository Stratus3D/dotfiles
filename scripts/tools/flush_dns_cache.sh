#! /bin/bash -

dscacheutil -flushcache; sudo killall -HUP mDNSResponder
