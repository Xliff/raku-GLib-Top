use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Subs;
use GLib::Top::Raw::Definitions;

use GLib::Array;
use GLib::HashTable;

unit package GLib::Top::Raw::Structs;

# class file is repr<CStruct> is export does StructSkipsTest['missing'] {
# 	has CArray[uint8] $!name;
# }

class glibtop_cpu is repr<CStruct> is export {
	has guint64	$.cpu-flags;
	has guint64 $.total;
	has guint64 $.user;
	has guint64 $.nice;
	has guint64 $.sys;
	has guint64 $.idle;
	has guint64 $.iowait;
	has guint64 $.irq;
	has guint64 $.softirq;
	has guint64 $.frequency;
	HAS guint64 @.xcpu_total[GLIBTOP_NCPU]   is CArray;
	HAS guint64 @.xcpu_user[GLIBTOP_NCPU]    is CArray;
	HAS guint64 @.xcpu_nice[GLIBTOP_NCPU]    is CArray;
	HAS guint64 @.xcpu_sys[GLIBTOP_NCPU]     is CArray;
	HAS guint64 @.xcpu_idle[GLIBTOP_NCPU]    is CArray;
	HAS guint64 @.xcpu_iowait[GLIBTOP_NCPU]  is CArray;
	HAS guint64 @.xcpu_irq[GLIBTOP_NCPU]     is CArray;
	HAS guint64 @.xcpu_softirq[GLIBTOP_NCPU] is CArray;
	has guint64 $.xcpu_flags;

	method flags { $!cpu-flags }

	method alloc {
		sub alloc_glibtop_cpu
			returns Pointer
			is      native(glibtop-helper)
			is      export
		{ * }

		nativecast(glibtop_cpu, alloc_glibtop_cpu);
	}
}

class glibtop_machine is repr<CStruct> is export {
	has uid_t $.uid;
	has uid_t $.euid;
	has gid_t $.gid;
	has gid_t $.egid;
}

class glibtop_sysdeps is repr<CStruct> is export {
	has guint64 $.sysdep-flags;
	has guint64 $.features;
	has guint64 $.cpu;
	has guint64 $.mem;
	has guint64 $.swap;
	has guint64 $.uptime;
	has guint64 $.loadavg;
	has guint64 $.shm_limits;
	has guint64 $.msg_limits;
	has guint64 $.sem_limits;
	has guint64 $.proclist;
	has guint64 $.proc_state;
	has guint64 $.proc_uid;
	has guint64 $.proc_mem;
	has guint64 $.proc_time;
	has guint64 $.proc_signal;
	has guint64 $.proc_kernel;
	has guint64 $.proc_segment;
	has guint64 $.proc_args;
	has guint64 $.proc_map;
	has guint64 $.proc_open_files;
	has guint64 $.mountlist;
	has guint64 $.fsusage;
	has guint64 $.netlist;
	has guint64 $.netload;
	has guint64 $.ppp;
	has guint64 $.proc_wd;
	has guint64 $.proc_affinity;
	has guint64 $.proc_io;
	has guint64 $.reserved0;
	has guint64 $.reserved1;
	has guint64 $.reserved2;
	has guint64 $.reserved3;
	has guint64 $.reserved4;
	has guint64 $.reserved5;
	has guint64 $.reserved6;
	has guint64 $.reserved7;

	method flags { $!sysdep-flags }
}

class glibtop is repr<CStruct> is export {
  has uint32          $.flags;
  has uint32          $.method;       #= Server Method
  has uint32          $.error_method;       #= Error Method
  HAS int32           @.input[2]        is CArray;   #= Pipe client <- server
  HAS int32           @.output[2]       is CArray;   #= Pipe client -> server
  has int32           $.socket;       #= Accepted connection of a socket
  has int32           $.ncpu;       #= Number of CPUs, zero if single-processor
  has int32           $.real_ncpu;       #= Real number of CPUs. Only ncpu are monitored
  has uint64          $.os_version_code;       #= Version code of the operating system
  HAS CArray[uint8]   $.name;                        #= Program name for error messages
  HAS CArray[uint8]   $.server_command;              #= Command used to invoke server
  HAS CArray[uint8]   $.server_host;                 #= Host the server should run on
  HAS CArray[uint8]   $.server_user;                 #= Name of the user on the target host
  HAS CArray[uint8]   $.server_rsh;                  #= Command used to connect to the target host
  has uint64          $.features;       #= Server is required for this features
  has uint64          $.server_port;       #= Port on which daemon is listening
  HAS glibtop_sysdeps $.sysdeps;                     #= Detailed feature list
  HAS glibtop_sysdeps $.required;                    #= Required feature list
  has pid_t           $.pid;       #= PID of the server
  has uid_t           $.uid;
  has uid_t           $.euid;
  has gid_t           $.gid;
  has gid_t           $.egid;
  has glibtop_machine $.machine;       #= Machine dependent data
};


class glibtop_fsusage is repr<CStruct> is export {
	has guint64 $.fsusage-flags;
	has guint64 $.blocks;
	has guint64 $.bfree;
	has guint64 $.bavail;
	has guint64 $.files;
	has guint64 $.ffree;
	has guint32 $.block_size;
	has guint64 $.read;
	has guint64 $.write;

	method flags { $!fsusage-flags }
}

class glibtop_mem is repr<CStruct> is export {
	has guint64 $.mem-flags;
	has guint64 $.total;
	has guint64 $.used;
	has guint64 $.free;
	has guint64 $.shared;
	has guint64 $.buffer;
	has guint64 $.cached;
	has guint64 $.user;
	has guint64 $.locked;

	method flags { $!mem-flags }
}

class glibtop_mountlist is repr<CStruct> is export {
	has guint64 $.mount-list-flags;
	has guint64 $.number;
	has guint64 $.total;
	has guint64 $.size;

	method flags { $!mount-list-flags }
}

class glibtop_mountentry is repr<CStruct> is export {
	constant mountentrylen = GLIBTOP_MOUNTENTRY_LEN + 1;

  has guint64 $.dev;
  HAS uint8   @!raw-devname[mountentrylen]  is CArray;
  HAS uint8   @!raw-mountdir[mountentrylen] is CArray;
  HAS uint8   @!raw-type[mountentrylen]     is CArray;

	method devname ( :$encoding = 'utf8' ) {
		Buf.new( @!raw-devname[^mountentrylen] ).decode($encoding)
	}

	method mountdir ( :$encoding = 'utf8' ) {
		Buf.new( @!raw-mountdir[^mountentrylen] ).decode($encoding)
	}

	method type ( :$encoding = 'utf8' ) {
		Buf.new( @!raw-type[^mountentrylen] ).decode($encoding)
	}

	sub alloc_glibtop_mountentry
		returns Pointer
		is      native(glibtop-helper)
		is      export
	{ * }

	method alloc {
		nativecast(glibtop_mountentry, alloc_glibtop_mountentry);
	}
}

class glibtop_msg_limits is repr<CStruct> is export {
	has guint64 $.msg-limit-flags;
	has guint64 $.msgpool;
	has guint64 $.msgmap;
	has guint64 $.msgmax;
	has guint64 $.msgmnb;
	has guint64 $.msgmni;
	has guint64 $.msgssz;
	has guint64 $.msgtql;

	method flags { $!msg-limit-flags }
}

class glibtop_netlist is repr<CStruct> is export {
	has guint64 $.netlist-flags;
	has guint32 $.number;

	method flags { $!netlist-flags }
}

class glibtop_netload is repr<CStruct> is export {
	has guint64 $.netload-flags;
	has guint64 $.if_flags;
	has guint32 $.mtu;
	has guint32 $.subnet;
	has guint32 $.address;
	has guint64 $.packets_in;
	has guint64 $.packets_out;
	has guint64 $.packets_total;
	has guint64 $.bytes_in;
	has guint64 $.bytes_out;
	has guint64 $.bytes_total;
	has guint64 $.errors_in;
	has guint64 $.errors_out;
	has guint64 $.errors_total;
	has guint64 $.collisions;
	HAS guint8  @.raw-address6[16]    is CArray;
	HAS guint8  @.raw-prefix6[16]     is CArray;
	has guint8  $.scope6;
	HAS guint8  @.raw-hwaddress[8]    is CArray;

	method flags { $!netload-flags }

	method address6 ( :$encoding = 'utf8' ) {
		Buf.new( @!raw-address6[^16] ).decode($encoding);
	}

	method prefix6 ( :$encoding = 'utf8' ) {
		Buf.new( @!raw-prefix6[^16] ).decode($encoding);
	}

	method hwaddress ( :$encoding = 'utf8' ) {
		Buf.new( @!raw-hwaddress[^8] ).decode($encoding);
	}

	# method gist {
	# 	my @v = do gather for self.^attributes {
	# 		my $n = .name.substr(2);
	# 		my $v = .get_value(self);
	#
	# 		take "{ $n } => { $v ~~ CArray ?? $v.^name !! $v }";
	# 		if $n.contains('raw-') {
	# 			$n .= subst('raw-', '');
	# 			take "{ $n } => { self."{ $n }"() }";
	# 		}
	# 	}
	# 	"{ self.^name }.new({ @v.join(', ') })";
	# }

	sub alloc_glibtop_netload
		returns Pointer
		is      native(glibtop-helper)
		is      export
	{ * }

	method alloc {
		nativecast(glibtop_netload, alloc_glibtop_netload);
	}
}

class glibtop_ppp is repr<CStruct> is export {
	has guint64 $.ppp-flags;
	has guint64 $.state;
	has guint64 $.bytes_in;
	has guint64 $.bytes_out;

	method flags { $!ppp-flags }
}

class glibtop_proc_affinity is repr<CStruct> is export {
	has guint64  $.affinity-flags;
	has guint32  $.number;
	has gboolean $!all;

	method flags { $!affinity-flags }
}

class glibtop_proc_args is repr<CStruct> is export {
	has guint64 $.arg-flags;
	has guint64 $.size;

	method flags { $!arg-flags }
}

class glibtop_proc_io is repr<CStruct> is export {
	has guint64 $.io-flags;
	has guint64 $.disk_rchar;
	has guint64 $.disk_wchar;
	has guint64 $.disk_rbytes;
	has guint64 $.disk_wbytes;
	HAS guint64 @.reserved[10] is CArray;

	method flags { $!io-flags }

	sub alloc_glibtop_proc_io
		returns Pointer
		is      native(glibtop-helper)
		is      export
	{ * }

	method alloc {
		nativecast(glibtop_proc_io, alloc_glibtop_proc_io);
	}
}

class glibtop_proc_map is repr<CStruct> is export {
	has guint64 $.map-flags;
	has guint64 $.number;
	has guint64 $.total;
	has guint64 $.size;

	method flags { $!map-flags }

	method get_type {
		state ($n, $t);

		sub glibtop_proc_map_get_type
			returns GType
			is      native(gtop)
			is      export
		{ * }

		unstable_get_type( self.^name, &glibtop_proc_map_get_type, $n, $t );
	}
}

class glibtop_map_entry is repr<CStruct> is export {
	constant filenamesize = GLIBTOP_MAP_FILENAME_LEN + 1;

  has guint64 $.map-entry-flags;
  has guint64 $.start;
  has guint64 $.end;
  has guint64 $.offset;
  has guint64 $.perm;
  has guint64 $.inode;
  has guint64 $.device;
  has guint64 $.size;
  has guint64 $.rss;
  has guint64 $.shared-clean;
  has guint64 $.shared-dirty;
  has guint64 $.private-clean;
  has guint64 $.private-dirty;
  has guint64 $.pss;
  has guint64 $.swap;
  HAS uint8   @.raw-filename[filenamesize] is CArray;

	method flags { $!map-entry-flags }

	method filename (Str() $encoding = 'utf8') {
		Buf.new( @!raw-filename ).decode($encoding);
	}

	method shared_clean  { $!shared-clean  }
	method shared_dirty  { $!shared-dirty  }
	method private_clean { $!private-clean }
	method private_dirty { $!private-dirty }

	method get_type {
		state ($n, $t);

		sub glibtop_map_entry_get_type
		  returns GType
		  is      native(gtop)
		  is      export
		{ * }

		unstable_get_type( self.^name, &glibtop_map_entry_get_type, $n, $t );
	}

}


class glibtop_proc_mem is repr<CStruct> is export {
	has guint64 $.proc-mem-flags;
	has guint64 $.size;
	has guint64 $.vsize;
	has guint64 $.resident;
	has guint64 $.share;
	has guint64 $.rss;
	has guint64 $.rss_rlim;

	method flags { $!proc-mem-flags }
}

class glibtop_open_file_entry_sock
	is   repr<CStruct>
	is   export
	does StructSkipsTest['internal']
{
	constant desthostsize = GLIBTOP_OPEN_DEST_HOST_LEN + 1;

	HAS uint8 @.raw_dest_host[desthostsize] is CArray;
	has int32 $.dest-port;

	method dest-host ( :$encoding = 'utf8' ) {
		Buf.new( @!raw_dest_host[^desthostsize] ).decode($encoding);
	}

	method name { $.dest-host }

}

class glibtop_open_file_entry_file
	is   repr<CStruct>
	is   export
	does StructSkipsTest['internal']
{
	constant openfilenamelen = GLIBTOP_OPEN_FILENAME_LEN + 1;

	HAS uint8 @.raw_name[openfilenamelen] is CArray;

	method name ( :$encoding = 'utf8' ) {
		Buf.new( @!raw_name[^openfilenamelen] ).decode($encoding);
	}
}

class glibtop_open_files_entry_info is repr<CUnion> is export {
	HAS glibtop_open_file_entry_sock $.sock;
	HAS glibtop_open_file_entry_file $.file;
	HAS glibtop_open_file_entry_file $.local-sock;
}

constant UNKNOWN_FILE_TYPE_NAME is export = '»Unknown file type«';

class glibtop_open_files_entry is repr<CStruct> is export {
	sub alloc_glibtop_open_files_entry
		returns Pointer
		is      native(glibtop-helper)
		is      export
	{ * }

	has int32                         $.fd;
	has guint16                       $.type;
	HAS glibtop_open_files_entry_info $!info;

	method info {
		do given $!type {
			when     GLIBTOP_FILE_TYPE_INETSOCKET |
			         GLIBTOP_FILE_TYPE_INET6SOCKET   { $!info.sock            }
		  when     GLIBTOP_FILE_TYPE_PIPE          { '|<pipe>'              }
	    when     GLIBTOP_FILE_TYPE_FILE          { $!info.file            }
			when     GLIBTOP_FILE_TYPE_LOCALSOCKET   { $!info.local-sock      }
			default                                  { UNKNOWN_FILE_TYPE_NAME }
    }
	}

	method name {
		my $i = $.info;

		$i ~~ Str ?? $i !! $i.name
	}

	method raw-info { $!info }

	method get_type {
		state ($n, $t);

		sub glibtop_open_files_entry_get_type
			returns GType
			is      native(gtop)
			is      export
		{ * }

		unstable_get_type(
			self.^name,
			&glibtop_open_files_entry_get_type,
			$n,
			$t
		);
	}

}

class glibtop_proc_open_files is repr<CStruct> is export {
	has guint64 $.of-flags;
	has guint64 $.number;
	has guint64 $.total;
	has guint64 $.size;

	method flags { $!of-flags }
}

class glibtop_proc_segment is repr<CStruct> is export {
	has guint64 $.seg-flags;
	has guint64 $.text_rss;
	has guint64 $.shlib_rss;
	has guint64 $.data_rss;
	has guint64 $.stack_rss;
	has guint64 $.dirty_size;
	has guint64 $.start_code;
	has guint64 $.end_code;
	has guint64 $.start_stack;

	method flags { $!seg-flags }
}

class glibtop_proclist is repr<CStruct> is export {
	has guint64 $.proc-flags;
	has guint64 $.number;
	has guint64 $.total;
	has guint64 $.size;

	method flags { $!proc-flags }
}

class glibtop_sem_limits is repr<CStruct> is export {
	has guint64 $.sem-flags;
	has guint64 $.semmap;
	has guint64 $.semmni;
	has guint64 $.semmns;
	has guint64 $.semmnu;
	has guint64 $.semmsl;
	has guint64 $.semopm;
	has guint64 $.semume;
	has guint64 $.semusz;
	has guint64 $.semvmx;
	has guint64 $.semaem;

	method flags { $!sem-flags }
}

class glibtop_shm_limits is repr<CStruct> is export {
	has guint64 $.shm-flags;
	has guint64 $.shmmax;
	has guint64 $.shmmin;
	has guint64 $.shmmni;
	has guint64 $.shmseg;
	has guint64 $.shmall;

	method flags { $!shm-flags }
}

class glibtop_swap is repr<CStruct> is export {
	has guint64 $.swap-flags;
	has guint64 $.total;
	has guint64 $.used;
	has guint64 $.free;
	has guint64 $.pagein;
	has guint64 $.pageout;

	method flags { $!swap-flags }
}

class glibtop_entry is repr<CStruct> is export {
	has GPtrArray  $.raw-labels;
	has GHashTable $.raw-values;
	has GHashTable $.raw-descriptions;

	method values {
		GLib::HashTable.new($!raw-values);
	}

	method labels {
		GLib::Array::String.new($!raw-labels).Array;
	}

}

class glibtop_sysinfo is repr<CStruct> is export {
	has guint64 $.sys-flags;
	has guint64 $.ncpu;
	HAS uint8   @.raw-cpuinfo[ GLIBTOP_NCPU * nativesizeof(glibtop_entry) ] is CArray; #= glibtop_entry cpuinfo [GLIBTOP_NCPU];

	method flags { $!sys-flags }

	method cpuinfo {
		state %cache;

		unless %cache{ +@!raw-cpuinfo.&p } {
			%cache{ +@!raw-cpuinfo.&p } =
				GLib::Roles::TypedBuffer[glibtop_entry].new-sized(
					cast(Pointer, @!raw-cpuinfo),
					$!ncpu
				).Array
		}

		%cache{ +@!raw-cpuinfo.&p }
	}
}

class glibtop_proc_uid is repr<CStruct> is export {
	sub alloc_glibtop_proc_uid
	  returns Pointer
	  is      native(glibtop-helper)
	  is      export
	{ * }

  has guint64 $.uid-flags;
	has gint32  $.uid;      #= user id */
  has gint32  $.euid;      #= effective user id */
  has gint32  $.gid;      #= group id */
  has gint32  $.egid;      #= effective group id */
  has gint32  $.suid;      #= set user id */
  has gint32  $.sgid;      #= set group id */
  has gint32  $.fsuid;      #= ??? user id */
  has gint32  $.fsgid;      #= ??? group id */
  has gint32  $.pid;      #= process id */
  has gint32  $.ppid;      #= pid of parent process */
  has gint32  $.pgrp;      #= process group id */
  has gint32  $.session;      #= session id */
  has gint32  $.tty;      #= full device number of controlling terminal */
  has gint32  $.tpgid;      #= terminal process group id */
  has gint32  $.priority;      #= kernel scheduling priority */
  has gint32  $.nice;      #= standard unix nice level of process */
  has gint32  $.ngroups;
	HAS gint32  @!groups[GLIBTOP_MAX_GROUPS]  is CArray;

	method flags { $!uid-flags }

	method alloc {
		nativecast(glibtop_proc_uid, alloc_glibtop_proc_uid);
	}

	method groups {
		@!groups[ ^$!ngroups ];
	}
}

class glibtop_proc_wd is repr<CStruct> is export {
	sub alloc_glibtop_proc_wd
	  returns Pointer
	  is      native(glibtop-helper)
	  is      export
	{ * }

	constant rootsize = GLIBTOP_PROC_WD_ROOT_LEN + 1;
	constant exesize  = GLIBTOP_PROC_WD_EXE_LEN  + 1;

	has guint64	      $.wd-flags;
	has guint32       $.number;
	HAS uint8         @!root[rootsize] is CArray;
	HAS uint8         @!exe[exesize] is CArray;

	method flags { $!wd-flags }

	submethod BUILD {
	 	# @!root[$_] = 0 for GLIBTOP_PROC_WD_ROOT_LEN.succ;
	 	#  @!exe[$_] = 0 for GLIBTOP_PROC_WD_EXE_LEN.succ;
	}

	method alloc {
		nativecast(glibtop_proc_wd, alloc_glibtop_proc_wd);
	}

	method root ($encoding = 'utf8') {
		Buf.new(@!root[^rootsize]).decode($encoding);
	}

	method exe ($encoding = 'utf8') {
		Buf.new(@!exe[^exesize]).decode($encoding);
	}

}

class glibtop_proc_time is repr<CStruct> is export {
	has guint64 $.proc-time-flags; #= Private
	has guint64 $.start_time;
	has guint64 $.rtime;
	has guint64 $.utime;
	has guint64 $.stime;
	has guint64 $.cutime;
	has guint64 $.cstime;
	has guint64 $.timeout;
	has guint64 $.it_real_value;
	has guint64 $.frequency;
	HAS guint64 @.xcpu_utime[GLIBTOP_NCPU] is CArray;
	HAS guint64 @.xcpu_stime[GLIBTOP_NCPU] is CArray;

	method flags { $!proc-time-flags }

	sub alloc_glibtop_proc_time
		returns Pointer
		is      native(glibtop-helper)
		is      export
	{ * }

	method alloc {
		nativecast(glibtop_proc_time, alloc_glibtop_proc_time);
	}

}

class glibtop_uptime is repr<CStruct> is export {
	has guint64 $.uptime-flags;
	has gdouble $.uptime;
	has gdouble $.idletime;
	has guint64 $.raw-boot-time;

	method flags { $!uptime-flags }

	method boot-time {
		DateTime.new($!raw-boot-time);
	}

	method boot_time     { $.boot-time }
	method raw_boot_time { $.raw-boot-time }
}

class glibtop_proc_signal is repr<CStruct> is export {
  has guint64 $.signal-flags;
  HAS guint64 @.signal[2]    is CArray;
  HAS guint64 @.blocked[2]   is CArray;
  HAS guint64 @.sigignore[2] is CArray;
  HAS guint64 @.sigcatch[2]  is CArray;

	method flags { $!signal-flags }

	sub alloc_glibtop_proc_signal
		returns Pointer
		is      native(glibtop-helper)
		is      export
	{ * }

	method alloc {
		cast(glibtop_proc_signal, alloc_glibtop_proc_signal);
	}
}

class glibtop_proc_kernel is repr<CStruct> is export {
  has guint64 $.pk-flags;
  has guint64 $.k_flags;
  has guint64 $.min_flt;
  has guint64 $.maj_flt;
  has guint64 $.cmin_flt;
  has guint64 $.cmaj_flt;
  has guint64 $.kstk_esp;
  has guint64 $.kstk_eip;
  has guint64 $.nwchan;
  HAS uint8   @!wchan[40] is CArray;

	method flags { $!pk-flags }

	method wchan ( :$encoding = 'utf8' ) {
		Buf.new( @!wchan ).decode($encoding);
	}

	sub alloc_glibtop_proc_kernel
		returns Pointer
		is      native(glibtop-helper)
		is      export
	{ * }

	method alloc {
		cast(glibtop_proc_kernel, alloc_glibtop_proc_kernel);
	}
}

class glibtop_loadavg is repr<CStruct> is export {
  has guint64 $.loadavg-flags;
  HAS gdouble @.loadavg[3] is CArray;
  has guint64 $.nr_running;
  has guint64 $.nr_tasks;
  has guint64 $.last_pid;

	method flags { $!loadavg-flags }

	sub alloc_glibtop_loadavg
		returns Pointer
		is      native(glibtop-helper)
		is      export
	{ * }

	method loadavg {
		CArrayToArray(@!loadavg, 3);
	}

	method alloc {
		cast(glibtop_loadavg, alloc_glibtop_loadavg);
	}
}

class glibtop_proc_state is repr<CStruct> is export {
  has guint64 $.state-flags;
  HAS uint8   @!cmd[40] is CArray;
  has guint   $.state;
  has gint    $.uid;
  has gint    $.gid;
  has gint    $.ruid;
  has gint    $.rgid;
  has gint    $.has_cpu;
  has gint    $.processor;
  has gint    $.last_processor;

	method flags { $!state-flags }

	method cmd ( :$encoding = 'utf8' ) {
		Buf.new( @!cmd[^40] ).decode($encoding);
	}

	sub alloc_glibtop_proc_state
		returns Pointer
		is      native(glibtop-helper)
		is      export
	{ * }

	method alloc {
		cast(glibtop_proc_state, alloc_glibtop_proc_state);
	}
}


# class glibtop_union is repr<CUnion> is export {
# 	HAS glibtop_cpu		          $.cpu;
# 	HAS glibtop_disk	          $.disk;
# 	HAS glibtop_mem		          $.mem;
# 	HAS glibtop_swap		        $.swap;
# 	HAS glibtop_uptime		      $.uptime;
# 	HAS glibtop_loadavg		      $.loadavg;
# 	HAS glibtop_shm_limits	    $.shm_limits;
# 	HAS glibtop_msg_limits	    $.msg_limits;
# 	HAS glibtop_sem_limits	    $.sem_limits;
# 	HAS glibtop_proclist	      $.proclist;
# 	HAS glibtop_proc_state	    $.proc_state;
# 	HAS glibtop_proc_uid	      $.proc_uid;
# 	HAS glibtop_proc_mem	      $.proc_mem;
# 	HAS glibtop_proc_time	      $.proc_time;
# 	HAS glibtop_proc_signal	    $.proc_signal;
# 	HAS glibtop_proc_kernel	    $.proc_kernel;
# 	HAS glibtop_proc_segment	  $.proc_segment;
# 	HAS glibtop_proc_args	      $.proc_args;
# 	HAS glibtop_proc_map	      $.proc_map;
# 	HAS glibtop_mountlist	      $.mountlist;
# 	HAS glibtop_fsusage		      $.fsusage;
# 	HAS glibtop_netlist		      $.netlist;
# 	HAS glibtop_netload		      $.netload;
# 	HAS glibtop_ppp		          $.ppp;
# 	HAS glibtop_proc_open_files $.proc_open_files;
# 	HAS glibtop_proc_wd		      $.proc_wd;
# 	HAS glibtop_proc_affinity	  $.proc_affinity;
# 	HAS glibtop_proc_io	        $.proc_io;
# }

# class glibtop_response is repr<CStruct> is export {
# 	has gint64                 $.offset;
# 	has guint64                $.size;
# 	has guint64                $.data_size;
# 	has gpointer               $!u; #= glibtop_response_union
# }

# class localsock is repr<CStruct> is export does StructSkipsTest['missing'] {
# 	has CArray[uint8] $!name;
# }
#
# class sock is repr<CStruct> is export does StructSkipsTest['missing'] {
# 	has CArray[uint8] $!dest_host;
# 	has int           $.dest_port;
# }
