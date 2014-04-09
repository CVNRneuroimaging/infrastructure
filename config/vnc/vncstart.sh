#!/bin/bash
PATH=$PATH:/opt/TurboVNC/bin


function kill_existing_tunnels ()
{
    # find the tcp port that should be open assuming there is a vnc server 
    # active on display n
    DISP=`get_display_list | cut -f 2 -d ":"`
    if [ x"$DISP" == x"" ]; then
	return
    fi
    port=`expr $DISP + 5900`
    
    # find the tunnels with that port, the tr -s is for cut's benefit
    possible_tunnels=`find-tunnels|grep ":$port"|tr -s " " | cut -f 2 -d " " `

    for i in $possible_tunnels; do
	kill $i
    done;
}


function get_display_list ()
{
    echo `vncserver -list |grep ":[[:digit:]]\+"|cut -f 1`;
}

function kill_all_display ()
{
    for i in `get_display_list`; do
	vncserver -kill $i
    done;
}




killswitch=`echo "$@" |grep "kill"`
if [ x"$killswitch" != x"" ]; then
    kill_all_display;
    exit 0;
fi


`kill_existing_tunnels`

DISPLIST=`get_display_list`


if [ -z "$DISPLIST" ]; then
    #echo "STARTING"
    vncserver -localhost -noauth -nohttpd  &> /dev/null
    DISPLIST=`get_display_list`
    if [ -z "$DISPLIST" ]; then
	echo "ERROR"
	exit 0;
    fi
fi


# XXX: assume 1 exists , check later, remove delimiter


DISP=`echo $DISPLIST | cut -f 2 -d ":"`
echo $DISP
