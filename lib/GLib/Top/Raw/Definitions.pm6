use v6.c;

use NativeCall;

use GLib::Raw::Definitions;

unit package GLib::Top::Raw::Definitions;

constant gtop           is export = 'gtop-2.0',v11;
#constant glibtop-helper is export = 'glibtopnc';

constant glibtop-helper is export = %?RESOURCES<lib/linux/libglibtopnc.so>;


# constant pid_t is export := uint64;
# constant uid_t is export := int32;
# constant gid_t is export := int32;

constant GLIBTOP_CPU_TOTAL	        is export = 0;
constant GLIBTOP_CPU_USER	          is export = 1;
constant GLIBTOP_CPU_NICE	          is export = 2;
constant GLIBTOP_CPU_SYS		        is export = 3;
constant GLIBTOP_CPU_IDLE	          is export = 4;
constant GLIBTOP_CPU_FREQUENCY	    is export = 5;
constant GLIBTOP_XCPU_TOTAL	        is export = 6;
constant GLIBTOP_XCPU_USER	        is export = 7;
constant GLIBTOP_XCPU_NICE	        is export = 8;
constant GLIBTOP_XCPU_SYS	          is export = 9;
constant GLIBTOP_XCPU_IDLE	        is export = 10;
constant GLIBTOP_XCPU_FLAGS	        is export = 11;
constant GLIBTOP_CPU_IOWAIT	        is export = 12;
constant GLIBTOP_CPU_IRQ		        is export = 13;
constant GLIBTOP_CPU_SOFTIRQ	      is export = 14;
constant GLIBTOP_XCPU_IOWAIT	      is export = 15;
constant GLIBTOP_XCPU_IRQ	          is export = 16;
constant GLIBTOP_XCPU_SOFTIRQ	      is export = 17;
constant GLIBTOP_MAX_CPU		        is export = 18;
constant GLIBTOP_NCPU		            is export = 1024;

constant GLIBTOP_PROC_WD_NUMBER	    is export = 0;
constant GLIBTOP_PROC_WD_ROOT	      is export = 1;
constant GLIBTOP_PROC_WD_EXE	      is export = 2;
constant GLIBTOP_MAX_PROC_WD	      is export = 3;
constant GLIBTOP_PROC_WD_ROOT_LEN   is export = 215;
constant GLIBTOP_PROC_WD_EXE_LEN    is export = 215;

constant GLIBTOP_MAX_GROUPS         is export = 64;

constant GLIBTOP_PROCLIST_NUMBER    is export = 0;
constant GLIBTOP_PROCLIST_TOTAL     is export = 1;
constant GLIBTOP_PROCLIST_SIZE      is export = 2;
constant GLIBTOP_MAX_PROCLIST       is export = 3;
constant GLIBTOP_KERN_PROC_ALL      is export = 0;
constant GLIBTOP_KERN_PROC_PID      is export = 1;
constant GLIBTOP_KERN_PROC_PGRP     is export = 2;
constant GLIBTOP_KERN_PROC_SESSION  is export = 3;
constant GLIBTOP_KERN_PROC_TTY      is export = 4;
constant GLIBTOP_KERN_PROC_UID      is export = 5;
constant GLIBTOP_KERN_PROC_RUID     is export = 6;
constant GLIBTOP_KERN_PROC_MASK     is export = 15;
constant GLIBTOP_EXCLUDE_IDLE       is export = 0x1000;
constant GLIBTOP_EXCLUDE_SYSTEM     is export = 0x2000;
constant GLIBTOP_EXCLUDE_NOTTY      is export = 0x4000;

constant GLIBTOP_SUID_CPU                is export = 0;
constant GLIBTOP_SUID_MEM                is export = 0;
constant GLIBTOP_SUID_SWAP               is export = 0;
constant GLIBTOP_SUID_UPTIME             is export = 0;
constant GLIBTOP_SUID_LOADAVG            is export = 0;
constant GLIBTOP_SUID_SHM_LIMITS         is export = 0;
constant GLIBTOP_SUID_MSG_LIMITS         is export = 0;
constant GLIBTOP_SUID_SEM_LIMITS         is export = 0;
constant GLIBTOP_SUID_PROCLIST           is export = 0;
constant GLIBTOP_SUID_PROC_STATE         is export = 0;
constant GLIBTOP_SUID_PROC_UID           is export = 0;
constant GLIBTOP_SUID_PROC_MEM           is export = 0;
constant GLIBTOP_SUID_PROC_TIME          is export = 0;
constant GLIBTOP_SUID_PROC_SIGNAL        is export = 0;
constant GLIBTOP_SUID_PROC_KERNEL        is export = 0;
constant GLIBTOP_SUID_PROC_SEGMENT       is export = 0;
constant GLIBTOP_SUID_PROC_ARGS          is export = 0;
constant GLIBTOP_SUID_PROC_MAP           is export = 0;
constant GLIBTOP_SUID_NETLOAD            is export = 0;
constant GLIBTOP_SUID_NETLIST            is export = 0;
constant GLIBTOP_SUID_PROC_WD            is export = 0;
constant GLIBTOP_SUID_PROC_AFFINITY      is export = 0;
constant GLIBTOP_SUID_PPP                is export = 0;
constant GLIBTOP_SUID_PROC_OPEN_FILES    is export = 0;
constant GLIBTOP_SUID_PROC_IO            is export = 0;

constant GLIBTOP_PROC_OPEN_FILES_NUMBER         is export = 0;
constant GLIBTOP_PROC_OPEN_FILES_TOTAL          is export = 1;
constant GLIBTOP_PROC_OPEN_FILES_SIZE           is export = 2;
constant GLIBTOP_MAX_PROC_OPEN_FILES            is export = 3;
constant GLIBTOP_FILE_ENTRY_FD                  is export = 0;
constant GLIBTOP_FILE_ENTRY_NAME                is export = 1;
constant GLIBTOP_FILE_ENTRY_TYPE                is export = 2;
constant GLIBTOP_FILE_ENTRY_INETSOCKET_DST_HOST is export = 3;
constant GLIBTOP_FILE_ENTRY_INETSOCKET_DST_PORT is export = 4;
constant GLIBTOP_MAX_OPEN_FILE_ENTRY            is export = 5;
constant GLIBTOP_OPEN_FILENAME_LEN              is export = 215;
constant GLIBTOP_OPEN_DEST_HOST_LEN             is export = 46;

constant GLIBTOP_PROC_MAP_NUMBER         is export = 0;
constant GLIBTOP_PROC_MAP_TOTAL          is export = 1;
constant GLIBTOP_PROC_MAP_SIZE           is export = 2;
constant GLIBTOP_MAX_PROC_MAP            is export = 3;
constant GLIBTOP_MAP_ENTRY_START         is export = 0;
constant GLIBTOP_MAP_ENTRY_END           is export = 1;
constant GLIBTOP_MAP_ENTRY_OFFSET        is export = 2;
constant GLIBTOP_MAP_ENTRY_PERM          is export = 3;
constant GLIBTOP_MAP_ENTRY_INODE         is export = 4;
constant GLIBTOP_MAP_ENTRY_DEVICE        is export = 5;
constant GLIBTOP_MAP_ENTRY_FILENAME      is export = 6;
constant GLIBTOP_MAP_ENTRY_SIZE          is export = 7;
constant GLIBTOP_MAP_ENTRY_RSS           is export = 8;
constant GLIBTOP_MAP_ENTRY_SHARED_CLEAN  is export = 9;
constant GLIBTOP_MAP_ENTRY_SHARED_DIRTY  is export = 10;
constant GLIBTOP_MAP_ENTRY_PRIVATE_CLEAN is export = 11;
constant GLIBTOP_MAP_ENTRY_PRIVATE_DIRTY is export = 12;
constant GLIBTOP_MAP_ENTRY_PSS           is export = 13;
constant GLIBTOP_MAP_ENTRY_SWAP          is export = 14;
constant GLIBTOP_MAX_MAP_ENTRY           is export = 15;
constant GLIBTOP_MAP_FILENAME_LEN        is export = 215;
constant GLIBTOP_MAP_PERM_READ           is export = 1;
constant GLIBTOP_MAP_PERM_WRITE          is export = 2;
constant GLIBTOP_MAP_PERM_EXECUTE        is export = 4;
constant GLIBTOP_MAP_PERM_SHARED         is export = 8;
constant GLIBTOP_MAP_PERM_PRIVATE        is export = 16;


constant glibtop_file_type is export := guint16;
our enum glibtop_file_type_enum is export (
  GLIBTOP_FILE_TYPE_FILE        => 1,
  GLIBTOP_FILE_TYPE_PIPE        => 2,
  GLIBTOP_FILE_TYPE_INETSOCKET  => 4,
  GLIBTOP_FILE_TYPE_LOCALSOCKET => 8,
  GLIBTOP_FILE_TYPE_INET6SOCKET => 16
);
