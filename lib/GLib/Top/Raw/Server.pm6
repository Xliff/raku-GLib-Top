use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Top::Raw::Definitions;
use GLib::Top::Raw::Structs;

unit package GLib::Top::Raw::Server;

### /usr/include/libgtop-2.0/glibtop.h

sub glibtop_get_type
  returns GType
  is      native(gtop)
  is      export
{ * }

sub glibtop_init
  returns glibtop
  is      native(gtop)
  is      export
{ * }

sub glibtop_init_r (CArray[glibtop] $server_ptr)
  returns glibtop
  is      native(gtop)
  is      export
{ * }

sub glibtop_init_s (CArray[glibtop] $server_ptr)
  returns glibtop
  is      native(gtop)
  is      export
{ * }

sub glibtop_close
  is      native(gtop)
  is      export
{ * }


### /usr/include/libgtop-2.0/glibtop/proclist.h

sub glibtop_get_proclist (
  glibtop_proclist $buf,
  gint64           $which,
  gint64           $arg
)
  returns CArray[pid_t]
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proclist_l (
  glibtop          $server,
  glibtop_proclist $buf,
  gint64           $which,
  gint64           $arg
)
  returns pid_t
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proclist_p (
  glibtop          $server,
  glibtop_proclist $buf,
  gint64           $which,
  gint64           $arg
)
  returns pid_t
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proclist_s (
  glibtop          $server,
  glibtop_proclist $buf,
  gint64           $which,
  gint64           $arg
)
  returns pid_t
  is      native(gtop)
  is      export
{ * }

### /usr/include/libgtop-2.0/glibtop/procuid.h

sub glibtop_get_proc_uid (
  glibtop_proc_uid $buf,
  pid_t            $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_uid_l (
  glibtop          $server,
  glibtop_proc_uid $buf,
  pid_t            $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_uid_p (
  glibtop          $server,
  glibtop_proc_uid $buf,
  pid_t            $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_uid_s (
  glibtop          $server,
  glibtop_proc_uid $buf,
  pid_t            $pid
)
  is      native(gtop)
  is      export
{ * }

### /usr/include/libgtop-2.0/glibtop/procwd.h

sub glibtop_get_proc_wd (glibtop_proc_wd $buf, pid_t $pid)
  returns CArray[ CArray[uint8] ]
  is      native(gtop)
  is      export
{ * }


sub glibtop_get_proc_wd_l (
  glibtop         $server,
  glibtop_proc_wd $buf,
  pid_t           $pid
)
  returns Str
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_wd_p (
  glibtop         $server,
  glibtop_proc_wd $buf,
  pid_t           $pid
)
  returns Str
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_wd_s (
  glibtop         $server,
  glibtop_proc_wd $buf,
  pid_t           $pid
)
  returns Str
  is      native(gtop)
  is      export
{ * }

### /usr/include/libgtop-2.0/glibtop/procmem.h

sub glibtop_get_proc_mem (
  glibtop_proc_mem $buf,
  pid_t            $pid
)
  is      native(gtop)
  is      export
{ * }

### /usr/include/libgtop-2.0/glibtop/procopenfiles.h

sub _glibtop_init_proc_open_files_p (glibtop $server)
  is      native(gtop)
  is      export
{ * }

sub _glibtop_init_proc_open_files_s (glibtop $server)
  is      native(gtop)
  is      export
{ * }

sub glibtop_proc_open_files_get_type
  returns GType
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_open_files (
  glibtop_proc_open_files $buf,
  pid_t                   $pid
)
  returns Pointer # Array of glibtop_open_files_entry
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_open_files_l (
  glibtop                 $server,
  glibtop_proc_open_files $buf,
  pid_t                   $pid
)
  returns Pointer
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_open_files_p (
  glibtop                 $server,
  glibtop_proc_open_files $buf,
  pid_t                   $pid
)
  returns Pointer
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_open_files_s (
  glibtop                 $server,
  glibtop_proc_open_files $buf,
  pid_t                   $pid
)
  returns Pointer
  is      native(gtop)
  is      export
{ * }


### /usr/include/libgtop-2.0/glibtop/procmap.h

sub glibtop_get_proc_map (
  glibtop_proc_map $buf,
  pid_t            $pid
)
  returns glibtop_map_entry
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_map_l (
  glibtop          $server,
  glibtop_proc_map $buf,
  pid_t            $pid
)
  returns glibtop_map_entry
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_map_p (
  glibtop          $server,
  glibtop_proc_map $buf,
  pid_t            $pid
)
  returns glibtop_map_entry
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_map_s (
  glibtop          $server,
  glibtop_proc_map $buf,
  pid_t            $pid
)
  returns glibtop_map_entry
  is      native(gtop)
  is      export
{ * }


### /usr/include/libgtop-2.0/glibtop/procsegment.h

sub glibtop_get_proc_segment (
  glibtop_proc_segment $buf,
  pid_t                $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_segment_l (
  glibtop              $server,
  glibtop_proc_segment $buf,
  pid_t                $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_segment_p (
  glibtop              $server,
  glibtop_proc_segment $buf,
  pid_t                $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_segment_s (
  glibtop              $server,
  glibtop_proc_segment $buf,
  pid_t                $pid
)
  is      native(gtop)
  is      export
{ * }

### /usr/include/libgtop-2.0/glibtop/cpu.h

sub glibtop_get_cpu (glibtop_cpu $buf)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_cpu_l (
  glibtop     $server,
  glibtop_cpu $buf
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_cpu_p (
  glibtop     $server,
  glibtop_cpu $buf
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_cpu_s (
  glibtop     $server,
  glibtop_cpu $buf
)
  is      native(gtop)
  is      export
{ * }

### /usr/include/libgtop-2.0/glibtop/uptime.h

sub glibtop_get_uptime (glibtop_uptime $buf)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_uptime_l (
  glibtop        $server,
  glibtop_uptime $buf
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_uptime_p (
  glibtop        $server,
  glibtop_uptime $buf
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_uptime_s (
  glibtop        $server,
  glibtop_uptime $buf
)
  is      native(gtop)
  is      export
{ * }

### /usr/include/libgtop-2.0/glibtop/proctime.h

sub glibtop_get_proc_time (
  glibtop_proc_time $buf,
  pid_t             $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_time_l (
  glibtop           $server,
  glibtop_proc_time $buf,
  pid_t             $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_time_p (
  glibtop           $server,
  glibtop_proc_time $buf,
  pid_t             $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_time_s (
  glibtop           $server,
  glibtop_proc_time $buf,
  pid_t             $pid
)
  is      native(gtop)
  is      export
{ * }

### /usr/include/libgtop-2.0/glibtop/procsignal.h

sub glibtop_get_proc_signal (
  glibtop_proc_signal $buf,
  pid_t               $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_signal_l (
  glibtop             $server,
  glibtop_proc_signal $buf,
  pid_t               $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_signal_p (
  glibtop             $server,
  glibtop_proc_signal $buf,
  pid_t               $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_signal_s (
  glibtop             $server,
  glibtop_proc_signal $buf,
  pid_t               $pid
)
  is      native(gtop)
  is      export
{ * }


### /usr/include/libgtop-2.0/glibtop/prockernel.h

sub glibtop_get_proc_kernel (
  glibtop_proc_kernel $buf,
  pid_t               $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_kernel_l (
  glibtop             $server,
  glibtop_proc_kernel $buf,
  pid_t               $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_kernel_p (
  glibtop             $server,
  glibtop_proc_kernel $buf,
  pid_t               $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_kernel_s (
  glibtop             $server,
  glibtop_proc_kernel $buf,
  pid_t               $pid
)
  is      native(gtop)
  is      export
{ * }

### /usr/include/libgtop-2.0/glibtop/procio.h

sub glibtop_get_proc_io (
  glibtop_proc_io $buf,
  pid_t           $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_io_l (
  glibtop         $server,
  glibtop_proc_io $buf,
  pid_t           $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_io_p (
  glibtop         $server,
  glibtop_proc_io $buf,
  pid_t           $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_io_s (
  glibtop         $server,
  glibtop_proc_io $buf,
  pid_t           $pid
)
  is      native(gtop)
  is      export
{ * }


### /usr/include/libgtop-2.0/glibtop/fsusage.h

sub glibtop_get_fsusage (
  glibtop_fsusage $buf,
  Str             $mount_dir
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_fsusage_l (
  glibtop         $server,
  glibtop_fsusage $buf,
  Str             $mount_dir
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_fsusage_s (
  glibtop         $server,
  glibtop_fsusage $buf,
  Str             $mount_dir
)
  is      native(gtop)
  is      export
{ * }

### /usr/include/libgtop-2.0/glibtop/mountlist.h

#| Returns: Pointer [Array of glibtop_mountentry]
sub glibtop_get_mountlist (
  glibtop_mountlist $buf,
  gint              $all_fs
)
  returns Pointer
  is      native(gtop)
  is      export
{ * }

#| Returns: Pointer [Array of glibtop_mountentry]
sub glibtop_get_mountlist_l (
  glibtop           $server,
  glibtop_mountlist $buf,
  gint              $all_fs
)
  returns Pointer
  is      native(gtop)
  is      export
{ * }

#| Returns: Pointer [Array of glibtop_mountentry]
sub glibtop_get_mountlist_s (
  glibtop           $server,
  glibtop_mountlist $buf,
  gint              $all_fs
)
  returns Pointer
  is      native(gtop)
  is      export
{ * }

sub glibtop_mountentry_get_type
  returns GType
  is      native(gtop)
  is      export
{ * }

sub glibtop_mountlist_get_type
  returns GType
  is      native(gtop)
  is      export
{ * }

### /usr/include/libgtop-2.0/glibtop/sysinfo.h

sub glibtop_get_sysinfo
  returns glibtop_sysinfo
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_sysinfo_s (glibtop $server)
  returns glibtop_sysinfo
  is      native(gtop)
  is      export
{ * }


### /usr/include/libgtop-2.0/glibtop/netlist.h

sub glibtop_get_netlist (glibtop_netlist $buf)
  returns CArray[Str]
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_netlist_l (
  glibtop         $server,
  glibtop_netlist $buf
)
  returns CArray[Str]
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_netlist_p (
  glibtop         $server,
  glibtop_netlist $buf
)
  returns CArray[Str]
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_netlist_s (
  glibtop         $server,
  glibtop_netlist $buf
)
  returns CArray[Str]
  is      native(gtop)
  is      export
{ * }


### /usr/include/libgtop-2.0/glibtop/netload.h

sub glibtop_get_netload (
  glibtop_netload $buf,
  Str             $interface
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_netload_l (
  glibtop         $server,
  glibtop_netload $buf,
  Str             $interface
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_netload_p (
  glibtop         $server,
  glibtop_netload $buf,
  Str             $interface
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_netload_s (
  glibtop         $server,
  glibtop_netload $buf,
  Str             $interface
)
  is      native(gtop)
  is      export
{ * }

### /usr/include/libgtop-2.0/glibtop/loadavg.h

sub glibtop_get_loadavg (glibtop_loadavg $buf)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_loadavg_l (
  glibtop         $server,
  glibtop_loadavg $buf
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_loadavg_p (
  glibtop         $server,
  glibtop_loadavg $buf
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_loadavg_s (
  glibtop         $server,
  glibtop_loadavg $buf
)
  is      native(gtop)
  is      export
{ * }

### /usr/include/libgtop-2.0/glibtop/mem.h

sub glibtop_get_mem (glibtop_mem $buf)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_mem_l (
  glibtop     $server,
  glibtop_mem $buf
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_mem_p (
  glibtop     $server,
  glibtop_mem $buf
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_mem_s (
  glibtop     $server,
  glibtop_mem $buf
)
  is      native(gtop)
  is      export
{ * }


### /usr/include/libgtop-2.0/glibtop/swap.h

sub glibtop_get_swap (glibtop_swap $buf)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_swap_l (
  glibtop      $server,
  glibtop_swap $buf
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_swap_p (
  glibtop      $server,
  glibtop_swap $buf
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_swap_s (
  glibtop      $server,
  glibtop_swap $buf
)
  is      native(gtop)
  is      export
{ * }


### /usr/include/libgtop-2.0/glibtop/procargs.h

sub glibtop_get_proc_args (
  glibtop_proc_args $buf,
  pid_t             $pid
)
  returns CArray[uint8]
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_args_l (
  glibtop           $server,
  glibtop_proc_args $buf,
  pid_t             $pid
)
  returns CArray[uint8]
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_args_p (
  glibtop           $server,
  glibtop_proc_args $buf,
  pid_t             $pid
)
  returns CArray[uint8]
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_args_s (
  glibtop           $server,
  glibtop_proc_args $buf,
  pid_t             $pid
)
  returns CArray[uint8]
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_argv (
  glibtop_proc_args $buf,
  pid_t             $pid
)
  returns CArray[Str]
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_argv_l (
  glibtop           $server,
  glibtop_proc_args $buf,
  pid_t             $pid
)
  returns CArray[Str]
  is      native(gtop)
  is      export
{ * }


### /usr/include/libgtop-2.0/glibtop/procstate.h

sub glibtop_get_proc_state (
  glibtop_proc_state $buf,
  pid_t              $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_state_l (
  glibtop            $server,
  glibtop_proc_state $buf,
  pid_t              $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_state_p (
  glibtop            $server,
  glibtop_proc_state $buf,
  pid_t              $pid
)
  is      native(gtop)
  is      export
{ * }

sub glibtop_get_proc_state_s (
  glibtop            $server,
  glibtop_proc_state $buf,
  pid_t              $pid
)
  is      native(gtop)
  is      export
{ * }
