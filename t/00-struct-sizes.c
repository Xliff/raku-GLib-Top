/*
  List created from the output of:
    ( find . -name \*.h -exec grep -Hn 'typedef struct'} \; 1>&2 ) 2>&1 | \
       cut -d\  -f 4 | grep -v \{
*/

/* Strategy provided by p6-XML-LibXML:author<FROGGS> */
#ifdef _WIN32
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT extern
#endif

#include <libgtopconfig.h>
#include <glibtop.h>
#include <glibtop_server.h>
#include <glibtop/close.h>
#include <glibtop/fsusage.h>
#include <glibtop/signal.h>
#include <glibtop/ppp.h>
#include <glibtop/cpu.h>
#include <glibtop/procargs.h>
#include <glibtop/command.h>
#include <glibtop/shm_limits.h>
#include <glibtop/msg_limits.h>
#include <glibtop/gnuserv.h>
#include <glibtop/netlist.h>
#include <glibtop/procsegment.h>
#include <glibtop/procaffinity.h>
#include <glibtop/procwd.h>
#include <glibtop/sysdeps.h>
#include <glibtop/parameter.h>
#include <glibtop/procstate.h>
#include <glibtop/procio.h>
#include <glibtop/union.h>
#include <glibtop/proclist.h>
#include <glibtop/procsignal.h>
#include <glibtop/prockernel.h>
#include <glibtop/procmem.h>
#include <glibtop/procuid.h>
#include <glibtop/mem.h>
#include <glibtop/mountlist.h>
#include <glibtop/swap.h>
#include <glibtop/sem_limits.h>
#include <glibtop/netload.h>
#include <glibtop/open.h>
#include <glibtop/loadavg.h>
#include <glibtop/procmap.h>
#include <glibtop/uptime.h>
#include <glibtop/global.h>
#include <glibtop/procopenfiles.h>
#include <glibtop/proctime.h>
#include <glibtop/sysinfo.h>
#include <glibtop_machine.h>

#define s(name)     DLLEXPORT int sizeof_ ## name () { return sizeof(name); }

//s(file)
s(glibtop_cpu)
s(glibtop_entry)
s(glibtop_fsusage)
s(glibtop_loadavg)
s(glibtop_machine)
s(glibtop_map_entry)
s(glibtop_mem)
s(glibtop_mountentry)
s(glibtop_mountlist)
s(glibtop_msg_limits)
s(glibtop_netlist)
s(glibtop_netload)
s(glibtop_open_files_entry)
s(glibtop_ppp)
s(glibtop_proc_affinity)
s(glibtop_proc_args)
s(glibtop_proc_io)
s(glibtop_proc_kernel)
s(glibtop_proc_map)
s(glibtop_proc_mem)
s(glibtop_proc_open_files)
s(glibtop_proc_segment)
s(glibtop_proc_signal)
s(glibtop_proc_state)
s(glibtop_proc_time)
s(glibtop_proc_uid)
s(glibtop_proc_wd)
s(glibtop_proclist)
s(glibtop_response)
s(glibtop_sem_limits)
s(glibtop_shm_limits)
s(glibtop_swap)
s(glibtop_sysdeps)
s(glibtop_sysinfo)
s(glibtop_union)
s(glibtop_uptime)
s(glibtop)

//s(localsock)
//s(sock)
