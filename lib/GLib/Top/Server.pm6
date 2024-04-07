use v6.c;

use GLib::Raw::Definitions;
use GLib::Raw::Subs;
use GLib::Top::Raw::Definitions;
use GLib::Top::Raw::Structs;
#use GLib::Top::Raw::Types;
use GLib::Top::Raw::Server;

use GLib::Roles::TypedBuffer;

use GLib::Roles::Implementor;
use GLib::Roles::StaticClass;

role GLib::Top::Proc::Entry {

  method gist {
    self.pairs.sort( *.key ).gist
  }

}

sub is-opened ($list, $file is copy) is export {
  $file .= absolute if $file ~~ IO::Path;
  if $file !~~ Str {
    $file .= Str if $file.^can('Str');
    X::GLib::InvalidType.new( message => '<file> must be a Str!' ).throw
      unless $file ~~ Str;
  }

  for $list[] {
    my $fn = .info.name;
    return True if $fn.contains($file) || $file.contains($fn)
  }
  False;
}

class GLib::Top {
  also does GLib::Roles::StaticClass;

  method get_sysinfo {
    glibtop_get_sysinfo;
  }

  proto method get_cpu (|)
  { * }

  multi method get_cpu {
    samewith(glibtop_cpu.alloc);
  }
  multi method get_cpu (glibtop_cpu $buf) {
    glibtop_get_cpu($buf);
    $buf;
  }

  proto method get_uptime (|)
  { * }

  multi method get_uptime {
    samewith(glibtop_uptime.new);
  }
  multi method get_uptime (glibtop_uptime $buf) {
    glibtop_get_uptime($buf);
    $buf;
  }

  proto method get_fsusage (|)
  { * }

  multi method get_fsusage (Str() $mount-dir) {
    samewith(glibtop_fsusage.new, $mount-dir);
  }
  multi method get_fsusage (glibtop_fsusage $buf, Str() $mount-dir) {
    glibtop_get_fsusage($buf, $mount-dir);
    $buf;
  }

  proto method get_loadavg (|)
  { * }

  multi method get_loadavg {
    samewith(glibtop_loadavg.alloc);
  }
  multi method get_loadavg (glibtop_loadavg $buf) {
    glibtop_get_loadavg($buf);
    $buf;
  }

  multi method get_netload (Str() $i) {
    samewith(glibtop_netload.alloc, $i);
  }
  multi method get_netload (glibtop_netload $buf, Str() $i) {
    glibtop_get_netload($buf, $i);
    $buf;
  }

  multi method get_mem {
    samewith(glibtop_mem.new);
  }
  multi method get_mem (glibtop_mem $buf) {
    glibtop_get_mem($buf);
    $buf;
  }

  multi method get_swap {
    samewith(glibtop_swap.new);
  }
  multi method get_swap (glibtop_swap $buf) {
    glibtop_get_swap($buf);
    $buf;
  }

  proto method get_mountlist (|)
  { * }

  multi method get_mountlist ( :$raw = False, :$all = False ) {
    samewith(glibtop_mountlist.new, :$all, :$raw);
  }
  multi method get_mountlist (
    glibtop_mountlist  $buf,
                      :$all = False,
                      :$raw = False
  ) {
    my gint32 $a  = $all.so.Int;

    my $of = glibtop_get_mountlist($buf, $a);

    unless $raw {
      $of = GLib::Roles::TypedBuffer[glibtop_mountentry].new(
        $of,
        size => $buf.number
      ).Array;
    }

    ( $of, $buf );
  }

  proto method get_netlist (|)
  { * }

  multi method get_netlist ( :$raw = False, :$all = False ) {
    samewith(glibtop_netlist.new, :$all, :$raw);
  }
  multi method get_netlist (
    glibtop_netlist  $buf,
                    :$all = False,
                    :$raw = False
  ) {
    my gint32 $a  = $all.so.Int;

    my $of = glibtop_get_netlist($buf);

    unless $raw {
      $of = CStringArrayToArray($of);
    }

    ( $of, $buf );
  }


  proto method get_proclist (|)
  { * }

  multi method get_proclist (
    :$files,
    :$pids,
    :$args,
    :$uid,
    :$kernel,
    :$io,
    :$map,
    :$mem,
    :$segment,
    :$signal,
    :$state,
    :$time,
    :$wd,
    :$all,
    :$buf     = False
  ) {
    my $r = samewith(
      GLIBTOP_KERN_PROC_ALL,
      0,
      :$files,
      :$pids,
      :$args,
      :$uid,
      :$kernel,
      :$io,
      :$map,
      :$mem,
      :$segment,
      :$signal,
      :$state,
      :$time,
      :$wd,
      :$all
    );
    return $r.head unless $buf;
    $r;
  }
  multi method get_proclist (
     $which,
     $arg,
    :$files,
    :$pids,
    :$args,
    :$uid,
    :$kernel,
    :$io,
    :$map,
    :$mem,
    :$segment,
    :$signal,
    :$state,
    :$time,
    :$wd,
    :$all
  ) {
    samewith(
      glibtop_proclist.new,
      $which,
      $arg,
      :$files,
      :$args,
      :$pids,
      :$uid,
      :$kernel,
      :$io,
      :$map,
      :$mem,
      :$segment,
      :$signal,
      :$state,
      :$time,
      :$wd,
      :$all
    );
  }
  multi method get_proclist (
    glibtop_proclist  $buf,
    Int()             $which,
    Int()             $arg,
                     :$raw     is copy = False,
                     :$args    is copy,
                     :$files   is copy,
                     :$pids    is copy,
                     :$uid     is copy,
                     :$kernel  is copy,
                     :$io      is copy,
                     :$map     is copy,
                     :$mem     is copy,
                     :$segment is copy,
                     :$signal  is copy,
                     :$state   is copy,
                     :$time    is copy,
                     :$wd      is copy,
                     :$class,
                     :$all
  ) {
    my gint64 ($w, $a) = ($which, $arg);

    my @a := (
      $files,
      $args,
      $pids,
      $uid,
      $kernel,
      $io,
      $map,
      $mem,
      $segment,
      $signal,
      $state,
      $time,
      $wd
    );

    my @names = @a.map({ .VAR.name.substr(1) });

    my %u;
    %u{$_} = True for do if $all {
      @names
    } else {
      qw<uid mem time wd>;
    }

    for @a -> $_ is raw {
      %u{ .VAR.name.substr(1) } //= $_
    }

    my $pl = glibtop_get_proclist($buf, $w, $a);
    return ($pl, $buf) if $raw;
    $pl = CArrayToArray($pl);
    return ($pl, $buf) if $pids;

    (
      $pl.map({
        my $h = {} but GLib::Top::Proc::Entry;
        #say "PID: $_";

        sub cpa ($v) {
          return unless $v;

          state %a;

          %a{ $v.^name } = $v.^attributes.map({ .name.substr(2) }).Array
            without %a{ $v.^name };

          for %a{ $v.^name }[] {
            next if $_ eq 'reserved';

            $h{ $_ } = $v."{ $_ }"();
          }
        }

        cpa( self.get_proc_io($_)      ) if %u<io>;
        cpa( self.get_proc_kernel($_)  ) if %u<kernel>;
        cpa( self.get_proc_mem($_)     ) if %u<mem>;
        cpa( self.get_proc_segment($_) ) if %u<segment>;
        cpa( self.get_proc_signal($_)  ) if %u<signal>;
        cpa( self.get_proc_state($_)   ) if %u<state>;
        cpa( self.get_proc_time($_)    ) if %u<time>;
        cpa( self.get_proc_uid($_)     ) if %u<uid>;

        if %u<files> {
          my $of = self.get_proc_files($_);

          if $class {
            $h<open-files> = class :: {
              method sunmmary       { $of.tail              }
              method list           { $of.head[]            }
              method is-opened ($f) { is-opened($.list, $f) }
            }
          } else {
            $h<open-files> = %(
              summary   => $of.tail,
              list      => $of.head,
              is-opened => sub ($f) {
                is-opened($of.head, $f);
              }
            )
          }
        }

        if %u<args> {
          my $a = self.get_proc_argv($_);

          cpa($a.tail);
          $h<arguments> = $a.head;
        }

        if %u<wd> {
          my $wdb = self.get_proc_wd($_);

          cpa($wdb.tail);
          $h<working-dirs> = CArrayToArray($wdb.head);
        }

        if %u<map> {
          my $me = self.get_proc_map($_);

          cpa($me.tail);
          $h<maps> = $me.head;
        }

        $h
      }),
      $buf
    );
  }

  proto method get_proc_argv (|)
  { * }

  multi method get_proc_argv (Int() $pid, :$raw = False) {
    samewith(glibtop_proc_args.new, $pid, :$raw);
  }
  multi method get_proc_argv (
    glibtop_proc_args  $buf,
    Int()              $pid,
                      :$raw = False

  ) {
    my pid_t $p = $pid;

    my $ca = glibtop_get_proc_argv($buf, $p);
    return ($ca, $buf) if $raw;

    $ca = CStringArrayToArray($ca);
    ($ca, $buf)
  }

  proto method get_proc_uid (|)
  { * }

  multi method get_proc_uid ($pid) {
    samewith(glibtop_proc_uid.alloc, $pid);
  }
  multi method get_proc_uid (
    glibtop_proc_uid $buf,
    Int()            $pid
  ) {
    my pid_t $p = $pid;

    glibtop_get_proc_uid($buf, $p);
    $buf;
  }

  proto method get_proc_wd (|)
  { * }

  multi method get_proc_wd ($pid, :$encoding = 'utf8', :$raw = False) {
    samewith(glibtop_proc_wd.alloc, $pid, :$encoding, :$raw);
  }
  multi method get_proc_wd (
    glibtop_proc_wd  $buf,
    Int()            $pid,
                    :$encoding = 'utf8',
                    :$raw      = False
  ) {
    my pid_t $p = $pid;

    my $csa = glibtop_get_proc_wd($buf, $p);
    ( $csa, $buf );
  }

  proto method get_proc_files (|)
  { * }

  multi method get_proc_files ($pid, :$raw = False) {
    samewith(glibtop_proc_open_files.new, $pid, :$raw);
  }
  multi method get_proc_files (
    glibtop_proc_open_files  $buf,
    Int()                    $pid,
                            :$raw = False
  ) {
    my pid_t $p = $pid;

    my $of = glibtop_get_proc_open_files($buf, $p);
    unless $raw {
      $of = GLib::Roles::TypedBuffer[glibtop_open_files_entry].new(
        $of,
        size => $buf.number
      ).Array;
    }

    ( $of, $buf );
  }

  proto method get_proc_mem (|)
  { * }

  multi method get_proc_mem ($pid) {
    samewith(glibtop_proc_mem.new, $pid);
  }
  multi method get_proc_mem (
    glibtop_proc_mem $buf,
    Int()            $pid
  ) {
    my pid_t $p = $pid;

    glibtop_get_proc_mem($buf, $p);
    $buf
  }

  proto method get_proc_map (|)
  { * }

  multi method get_proc_map ($pid, :$raw = False) {
    samewith(glibtop_proc_map.new, $pid, :$raw);
  }
  multi method glibtop_get_proc_map (
    glibtop_proc_map   $buf,
    Int()              $pid,
                      :$raw = False
  ) {
    my pid_t $p = $pid;

    my $m = glibtop_get_proc_map($buf, $pid);
    unless $raw {
      $m = GLib::Roles::TypedBuffer[glibtop_map_entry].new(
        $m,
        size => $buf.number
      ).Array;
    }
    ($m, $buf);
  }

  proto method get_proc_segment (|)
  { * }

  multi method get_proc_segment ($pid) {
    samewith(glibtop_proc_segment.new, $pid);
  }
  multi method get_proc_segment(
    glibtop_proc_segment $buf,
    Int()                $pid
  ) {
    my pid_t $p = $pid;

    glibtop_get_proc_segment($buf, $p);
    $buf
  }

  proto method get_proc_signal (|)
  { * }

  multi method get_proc_signal ($pid) {
    samewith(glibtop_proc_signal.alloc, $pid);
  }
  multi method get_proc_signal(
    glibtop_proc_signal $buf,
    Int()               $pid
  ) {
    my pid_t $p = $pid;

    glibtop_get_proc_signal($buf, $p);
  }

  proto method get_proc_state (|)
  { * }

  multi method get_proc_state (Int() $pid) {
    samewith(glibtop_proc_state.alloc, $pid);
  }
  multi method get_proc_state (
    glibtop_proc_state $buf,
    Int()              $pid
  ) {
    my pid_t $p = $pid;

    glibtop_get_proc_state($buf, $p);
    $buf;
  }

  proto method get_proc_time (|)
  { * }

  multi method get_proc_time ($pid) {
    samewith(glibtop_proc_time.alloc, $pid);
  }
  multi method get_proc_time (
    glibtop_proc_time $buf,
    Int()             $pid
  ) {
    my pid_t $p = $pid;

    glibtop_get_proc_time($buf, $p);
    $buf
  }

  proto method get_proc_kernel (|)
  { * }

  multi method get_proc_kernel ($pid) {
    samewith(glibtop_proc_kernel.alloc, $pid);
  }
  multi method get_proc_kernel (
    glibtop_proc_kernel $buf,
    Int()               $pid
  ) {
    my pid_t $p = $pid;

    glibtop_get_proc_kernel($buf, $p);
    $buf;
  }

  proto method get_proc_io (|)
  { * }

  multi method get_proc_io ($pid) {
    samewith(glibtop_proc_io.alloc, $pid);
  }
  multi method get_proc_io (
    glibtop_proc_io $buf,
    Int()           $pid
  ) {
    my pid_t $p = $pid;

    glibtop_get_proc_io($buf, $p);
    $buf;
  }

}

class GLib::Top::Server {
  has glibtop $!server is implementor;

  submethod BUILD ( :$gtop-server ) {
    $!server = $gtop-server if $gtop-server;
  }

  method close {
    glibtop_close();
  }

  method init {
    my $gtop-server = glibtop_init();

    $gtop-server ?? self.bless( :$gtop-server ) !! Nil;
  }

  method init_r (glibtop() $server_ptr) {
    glibtop_init_r($server_ptr);
  }

  method init_s (glibtop() $server_ptr) {
    glibtop_init_s($server_ptr);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &glibtop_get_type, $n, $t );
  }

}

INIT {
  GLib::Top::Server.init;
}

END {
  GLib::Top::Server.close;
}
