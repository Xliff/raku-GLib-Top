#include <glibtop.h>
#include <glibtop_machine.h>
#include <glibtop/proclist.h>
#include <glibtop/close.h>
#include <glibtop/command.h>
#include <glibtop/cpu.h>
#include <glibtop/fsusage.h>
#include <glibtop/global.h>
#include <glibtop/gnuserv.h>
#include <glibtop/loadavg.h>
#include <glibtop/mem.h>
#include <glibtop/mountlist.h>
#include <glibtop/msg_limits.h>
#include <glibtop/netlist.h>
#include <glibtop/netload.h>
#include <glibtop/open.h>
#include <glibtop/parameter.h>
#include <glibtop/ppp.h>
#include <glibtop/procaffinity.h>
#include <glibtop/procargs.h>
#include <glibtop/procio.h>
#include <glibtop/prockernel.h>
#include <glibtop/proclist.h>
#include <glibtop/procmap.h>
#include <glibtop/procmem.h>
#include <glibtop/procopenfiles.h>
#include <glibtop/procsegment.h>
#include <glibtop/procsignal.h>
#include <glibtop/procstate.h>
#include <glibtop/proctime.h>
#include <glibtop/procuid.h>
#include <glibtop/procwd.h>
#include <glibtop/sem_limits.h>
#include <glibtop/shm_limits.h>
#include <glibtop/signal.h>
#include <glibtop/swap.h>
#include <glibtop/sysdeps.h>
#include <glibtop/sysinfo.h>
#include <glibtop/union.h>
#include <glibtop/uptime.h>

glibtop_cpu *alloc_glibtop_cpu (void) {
  return (glibtop_cpu *)malloc( sizeof(glibtop_cpu) );
}

glibtop_shm_limits *alloc_glibtop_shm_limits (void) {
  return (glibtop_shm_limits *)malloc( sizeof(glibtop_shm_limits) );
}

glibtop_response *alloc_glibtop_response (void) {
  return (glibtop_response *)malloc( sizeof(glibtop_response) );
}

glibtop_entry *alloc_glibtop_entry (void) {
  return (glibtop_entry *)malloc( sizeof(glibtop_entry) );
}

glibtop_msg_limits *alloc_glibtop_msg_limits (void) {
  return (glibtop_msg_limits *)malloc( sizeof(glibtop_msg_limits) );
}

glibtop_ppp *alloc_glibtop_ppp (void) {
  return (glibtop_ppp *)malloc( sizeof(glibtop_ppp) );
}

glibtop_proc_mem *alloc_glibtop_proc_mem (void) {
  return (glibtop_proc_mem *)malloc( sizeof(glibtop_proc_mem) );
}

glibtop_proclist *alloc_glibtop_proclist (void) {
  return (glibtop_proclist *)malloc( sizeof(glibtop_proclist) );
}

glibtop_sem_limits *alloc_glibtop_sem_limits (void) {
  return (glibtop_sem_limits *)malloc( sizeof(glibtop_sem_limits) );
}

glibtop_proc_io *alloc_glibtop_proc_io (void) {
  return (glibtop_proc_io *)malloc( sizeof(glibtop_proc_io) );
}

glibtop_proc_wd *alloc_glibtop_proc_wd (void) {
  return (glibtop_proc_wd *)malloc( sizeof(glibtop_proc_wd) );
}

glibtop_proc_uid *alloc_glibtop_proc_uid (void) {
  return (glibtop_proc_uid *)malloc( sizeof(glibtop_proc_uid) );
}

glibtop_uptime *alloc_glibtop_uptime (void) {
  return (glibtop_uptime *)malloc( sizeof(glibtop_uptime) );
}

glibtop_proc_time *alloc_glibtop_proc_time (void) {
  return (glibtop_proc_time *)malloc( sizeof(glibtop_proc_time) );
}

glibtop_fsusage *alloc_glibtop_fsusage (void) {
  return (glibtop_fsusage *)malloc( sizeof(glibtop_fsusage) );
}

glibtop_proc_map *alloc_glibtop_proc_map (void) {
  return (glibtop_proc_map *)malloc( sizeof(glibtop_proc_map) );
}

glibtop_netload *alloc_glibtop_netload (void) {
  return (glibtop_netload *)malloc( sizeof(glibtop_netload) );
}

glibtop_swap *alloc_glibtop_swap (void) {
  return (glibtop_swap *)malloc( sizeof(glibtop_swap) );
}

glibtop_machine *alloc_glibtop_machine (void) {
  return (glibtop_machine *)malloc( sizeof(glibtop_machine) );
}

glibtop_proc_affinity *alloc_glibtop_proc_affinity (void) {
  return (glibtop_proc_affinity *)malloc( sizeof(glibtop_proc_affinity) );
}

glibtop_proc_segment *alloc_glibtop_proc_segment (void) {
  return (glibtop_proc_segment *)malloc( sizeof(glibtop_proc_segment) );
}

glibtop_sysdeps *alloc_glibtop_sysdeps (void) {
  return (glibtop_sysdeps *)malloc( sizeof(glibtop_sysdeps) );
}

glibtop_mem *alloc_glibtop_mem (void) {
  return (glibtop_mem *)malloc( sizeof(glibtop_mem) );
}

glibtop *alloc_glibtop (void) {
  return (glibtop *)malloc( sizeof(glibtop) );
}

glibtop_mountlist *alloc_glibtop_mountlist (void) {
  return (glibtop_mountlist *)malloc( sizeof(glibtop_mountlist) );
}

glibtop_proc_args *alloc_glibtop_proc_args (void) {
  return (glibtop_proc_args *)malloc( sizeof(glibtop_proc_args) );
}

glibtop_proc_open_files *alloc_glibtop_proc_open_files (void) {
  return (glibtop_proc_open_files *)malloc( sizeof(glibtop_proc_open_files) );
}

glibtop_netlist *alloc_glibtop_netlist (void) {
  return (glibtop_netlist *)malloc( sizeof(glibtop_netlist) );
}

glibtop_proc_kernel *alloc_glibtop_proc_kernel (void) {
  return (glibtop_proc_kernel *)malloc( sizeof(glibtop_proc_kernel) );
}
<<<<<<< HEAD

glibtop_mountentry *alloc_glibtop_mountentry (void) {
  return (glibtop_mountentry *)malloc( sizeof(glibtop_mountentry) );
}

glibtop_loadavg *alloc_glibtop_loadavg (void) {
  return (glibtop_loadavg *)malloc( sizeof(glibtop_loadavg) );
}
=======
>>>>>>> 68f8f703cca15c2fcfb771ea13c978a21dd05cd5
