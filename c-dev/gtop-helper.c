#include <glibtop/procwd.h>
#include <glibtop/proclist.h>


#typedef struct proclist_item {
  pid_t          pid;
  proclist_wd   *wd;
  proclist_proc *proc;

  char          **working_dirs;
} proclist_item;

proclist_item* get_all_processes (
  unsigned int wd,
  unsigned int pid,
  unsigned int mem,
) {
  glibtop_proclist  buf;
  pid_t            *pids;

  pids = glibtop_get_proclist(&buf, GLIBTOP_KERN_PROC_ALL, 0);

  int i;
  printf("Processes: %ld\n", buf.number);

  proclist_item *list = (proclist_item *)malloc(
    buf.number * sizeof(proclist_item)
  );

  for (i = 0; i < buf.number; i++) {
    pid_t          pid = pids[i];
    proclist_item item = (proclist_item *)malloc( sizeof(proclist_item) );

    item->pid = pid;

    if (wd) {
      glibtop_proc_wd  wd = (glibtop_proc_wd *)malloc( sizeof(proclist_wd) );
      item->working_dirs = glibtop_get_proc_wd(wd, pid);
      item->wd           = wd;
    }

    if (mem) {
      glibtop_proc_mem mem = (glibtop_proc_wd *)malloc(
        sizeof(glibtop_proc_wd)
      );

      glibtop_get_proc_mem(mem, pid);

      item->mem           = mem;
    }

    g_print("Process %u:\n"
      " - root: '%s'\n"
      " - exe: '%s'\n"
      " - working directories:\n",
      (unsigned)pid, wd->root, wd->exe);

    for (dir = item->working_dirs; *dir; ++dir)
      g_print("   - '%s'\n", *dir);

    g_strfreev(dirs);
    list[i] = item;
  }
  return list;
}
