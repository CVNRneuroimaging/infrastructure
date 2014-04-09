#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

/*
 * returns lsof's output of sockets whose process is 'sshd' whose user is 
 * the calling real user
 */
int 
main(int argc, char ** argv)
{
  uid_t euid;
  uid_t uid;
  char uid_str[10];

  euid = geteuid();
  uid = getuid();
  
  if (euid != 0) { 
    printf("%s: error: this program must be setuid root to function correctly\n", argv[0]);
    exit(1);
  }

  memset(uid_str, 0, sizeof(uid_str));
  snprintf(uid_str, 9, "%i", uid);


  // lsof -i -n |egrep \'\\<sshd\\>\'|grep `id -urn`
  // lsof -a -i -n -u $uid -c sshd
  execl("/usr/bin/lsof", 
	"/usr/bin/lsof", 
	"-a",
	"-i",
	"-n",
	"-u", uid_str,
	"-c", "sshd",
	(char *) NULL);
    

  return 0;
}

