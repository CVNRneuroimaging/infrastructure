#!/usr/bin/python3

# python3.3 in particular

from multiprocessing import Process, Pipe, freeze_support

import sys
from subprocess import *
import time

import tkinter
from tkinter import ttk
from tkinter.constants import *

plink = "./plink.exe "
vnc='"c:/Program Files/TurboVNC/vncviewer.exe " '
vncstartpath="/usr/bin/vncstart.sh"

#vnc='"c:/Program Files/TightVNC/tvnviewer.exe " '


def process_run(conn):
    while 1:
        o = conn.recv()
        if o[0] == "quit":
            return
        elif o[0] == "vncstart":
            user = o[1]
            passwd = o[2]
            result = run_vncstart(user, passwd)
            conn.send(result)
        elif o[0] == "tunnel":
            user = o[1]
            passwd = o[2]
            port = o[3]
            localport = o[4]
            result = setup_tunnel(user, passwd, port, localport)
            conn.send(result)
        elif o[0] == "vncviewer":
            result = run_vnc(localport)
            conn.send(result)
        # end if
    # end while
#end def

def run_vncstart_paramiko(userhost, passwd):
    import paramiko
    try:
        (user,host)=userhost.split("@")
    except:
        return ("vncstart", "error", "couldn't parse username")
    # end except

    try:
        ssh = paramiko.SSHClient()
        # ignore the host key
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(host, username=user, password=passwd)
        stdin, stdout, stderr = ssh.exec_command(vncstartpath)
        disp = int(stdout.read().strip())
        return ("vncstart", "ok", disp)
    except paramiko.ssh_exception.AuthenticationException:
        return ("vncstart", "error", "couldn't authenticate")
    except:
        return ("vncstart", "error", "couldn't connect to host to get display")
    # end except

# end def

def run_vncstart_plink(userhost, passwd):
    (user,host)=userhost.split("@")
    userpass = " %s -pw %s "%(userhost, passwd)
    cmd = plink+" -t "+userpass+vncstartpath
    p = Popen(cmd, stdout = PIPE)
    stdout, stderr = p.communicate()
    #print(p.returncode, stdout)
    # we expect a single line with an intenger or ERROR
    if (stdout == "ERROR" or p.returncode != 0):
        return ("vncstart", "error")
    # end if
    disp = int(stdout.strip())
    return ("vncstart", "ok", disp)

# end def



def run_vncstart(userhost, passwd):
    return run_vncstart_paramiko(userhost, passwd)
# end def

def setup_tunnel(userhost, passwd, port, localport):
    (user,host)=userhost.split("@")
    tunnel = (plink+
              "-batch -pw %s -l %s -x -T -L %i:localhost:%i %s sleep 50"%(passwd, 
                                                        user, 
                                                        localport, 
                                                        port, host))
    # print(tunnel)
    p = Popen(tunnel).pid
    # give it time to startup
    time.sleep(10)
    return ("tunnel", "ok", port, localport)
# end def

def run_vnc(localport):
    cmd = vnc+" localhost:%i"%localport
    p = Popen(cmd, stdout = PIPE).pid
    #stdout, stderr = p.communicate()
    return ("vncviewer", "ok", localport)
# end def


def save_recent_hosts(hosts, host):
    if (host not in hosts):
        hosts.append(host)
    # end if

    if (len(hosts) > 10):
        hosts = hosts[1:]
    # end if

    f = open("recent_hosts", "w+")
    for host in hosts:
        f.write(host+"\n")
    # end for
    f.close()
# end def

def open_recent_hosts():
    hosts = []
    try: 
        f = open("recent_hosts")
    except IOError:
        f = open("recent_hosts", "w+")
    # end try

    for line in f.readlines():
        hosts.append(line.strip())
    # end for
    f.close()

    return hosts
# end def

if __name__== "__main__":
    try:
        freeze_support()
    except:
        sys.exit()
    # end try

    hosts = open_recent_hosts()


    parent_conn, child_conn = Pipe()
    p = Process(target=process_run, args=(child_conn,))
    p.start()
    
    root = tkinter.Tk()
    root.title("VNCConnect")

    user_var = tkinter.StringVar()
    passwd_var = tkinter.StringVar()
    status_var = tkinter.StringVar()    



    def handle_pipe():
        while (parent_conn.poll(0)):
            o = parent_conn.recv()
            #print (o)
            if o[0] == "vncstart":
                if o[1] == "ok":
                    disp = o[2]
                    status_var.set("found session: %i, creating tunnel..."%disp)
                    port = 5900+disp
                    localport = 2000+port
                    parent_conn.send(("tunnel",user_var.get(), passwd_var.get(),
                                      port, localport))
                else:
                    status_var.set("error: "+o[2])
                # end if
            elif o[0] == "tunnel":
                if o[1] == "ok":
                    status_var.set("tunnel started, starting vncviewer %i"%o[2])
                    parent_conn.send(("vncviewer",o[3]))

                else:
                    status_var.set("error starting tunnel"%disp)
                # end if    
            elif o[0] == "vncviewer":
                if o[1] == "ok":
                    root.withdraw()
                    root.quit()
                else:
                    status_var.set("error starting vncviewer")
                # end if
            # end if
        # end while
        root.after(200, handle_pipe)
    # end def
    


    def gui_vncstart():            
        status_var.set("checking for session");
        save_recent_hosts(hosts, user_var.get())
        parent_conn.send(("vncstart",user_var.get(), passwd_var.get()))
    # end def


    def esc_keypress(e):
        if (len(e.char) == 0):
            return False
        # end if
        if (ord(e.char) == 27):
            root.quit()
        # end if
        return True
    # end def

    def enter_keypress(e):
        if (len(e.char) == 0):
            return False
        # end if
        if (e.char == '\r' or e.char == '\n'):
            gui_vncstart()
        # end if

    # end def


    # keypress for cancel button ... enter should still quit
    def cw_enter_keypress(e):
        if (e.char == '\r' or e.char == '\n'):
            root.quit()
            return False
        # end if
        return True
    # end def

    root.after(200, handle_pipe)        


    frame = ttk.Frame(root, relief=FLAT, borderwidth=20, padding=(5, 5, 5, 5))
    frame.grid(column = 0, row=0)
    l = ttk.Label(frame, text="login (user@host):", font=("sans", 10))
    l.grid(column=0, row=0)
    e = ttk.Combobox(frame, textvariable=user_var, values=hosts)

    e.grid(column=1, row=0, ipadx=40)


    
    pl = ttk.Label(frame, text="password:", font=("sans", 10))
    pl.grid(column=0, row=1, ipady=10, ipadx=10, sticky=(W))
    pe = ttk.Entry(frame, show="*", textvariable=passwd_var)
    pe.grid(column=1, row=1, ipadx=50, sticky=(E))


    b = ttk.Button(frame, text="Cancel", command=lambda: root.quit())
    b.grid(column=0, row=2)
    b.bind('<KeyPress>', cw_enter_keypress)


    def connect_cb():
        gui_vncstart()
    # end def

    b = ttk.Button(frame, text="Connect", command=connect_cb)
    b.grid(column=1, row=2)

    b.bind('<KeyPress>', enter_keypress)
    e.bind('<KeyPress>', enter_keypress)
    pe.bind('<KeyPress>', enter_keypress)
    root.bind('<KeyPress>', esc_keypress)    

    l = ttk.Label(frame, textvariable=status_var, font=("sans", 10, "bold"))
    status_var.set("Idle")
    l.grid(column=0, row=3, columnspan=2, ipady=10)

    root.mainloop()

    if p:
        parent_conn.send(("quit",))
        p.join()
    # end if

# end if __main__

