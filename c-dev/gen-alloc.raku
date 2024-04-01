use GLib::Top::Raw::Structs;

my @alloc;
sub MAIN {
  for GLib::Top::Raw::Structs.WHO {
    if .value.REPR eq "CStruct" {
      my $n = .value.^shortname;

      @alloc.push: qq:to/F/;
        { $n } *alloc_{ $n } (void) \{
          return ({ $n } *)malloc( sizeof({ $n }) );
        \}
        F
    }
  }

  say qq:to/C/;
    #include <glibtop.h>
    #include <glibtop_machine.h>
    #include <glibtop/procwd.h>
    #include <glibtop/proclist.h>
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

    { @alloc.join("\n") }
    C
}
