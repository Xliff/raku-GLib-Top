#include <glibtop.h>
#include <glibtop/procwd.h>
#include <glibtop/proclist.h>

#include <stdio.h>

#include <unistd.h>
#include <sys/types.h>

#include <glib.h>
#include <unistd.h>

int main(int argc, char **argv)
{
  glibtop_proclist buf;
	glibtop_proc_wd buf2;
	char **dirs, **dir;
	pid_t *pids;

  glibtop_init();

	pids = glibtop_get_proclist(&buf, GLIBTOP_KERN_PROC_ALL, 0);

  int i;
  printf("Processes: %ld\n", buf.number);
	for (i = 0; i < buf.number; i++) {
    pid_t pid = pids[i];

  	dirs = glibtop_get_proc_wd(&buf2, pid);

  	g_print("Process %u:\n"
  		" - root: '%s'\n"
  		" - exe: '%s'\n"
      " - working directories:\n",
  		(unsigned)pid, buf2.root, buf2.exe);

  	for (dir = dirs; *dir; ++dir)
  		g_print("   - '%s'\n", *dir);

  	g_strfreev(dirs);
  }

	glibtop_close();

	return 0;
}
