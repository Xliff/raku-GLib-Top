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

  proto method get_proclist (|)
  { * }

  multi method get_proclist (
    :$files   = False,
    :$pids    = False,
    :$uid     = True,
    :$map     = False,
    :$mem     = True,
    :$segment = False,
    :$signal  = False,
    :$time    = True,
    :$wd      = True
  ) {
    samewith(
      GLIBTOP_KERN_PROC_ALL,
      0,
      :$files,
      :$pids,
      :$uid,
      :$map,
      :$mem,
      :$segment,
      :$signal,
      :$time,
      :$wd
    );
  }
  multi method get_proclist (
     $which,
     $arg,
    :$files   = False,
    :$pids    = False,
    :$uid     = True,
    :$map     = False,
    :$mem     = True,
    :$segment = False,
    :$signal  = False,
    :$time    = True,
    :$wd      = True
  ) {
    samewith(
      glibtop_proclist.new,
      $which,
      $arg,
      :$files,
      :$pids
      :$uid,
      :$map,
      :$mem,
      :$segment,
      :$signal,
      :$time,
      :$wd
    );
  }
  multi method get_proclist (
    glibtop_proclist  $buf,
    Int()             $which,
    Int()             $arg,
                     :$raw     = False,
                     :$files   = False,
                     :$pids    = False,
                     :$uid     = True,
                     :$map     = False,
                     :$mem     = True,
                     :$segment = False,
                     :$signal  = False,
                     :$time    = True,
                     :$wd      = True,
                     :$class   = False
  ) {
    my gint64 ($w, $a) = ($which, $arg);

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
            $h{ $_ } = $v."{ $_ }"();
          }
        }

        cpa( self.get_proc_uid($_)     ) if $uid;
        cpa( self.get_proc_time($_)    ) if $time;
        cpa( self.get_proc_mem($_)     ) if $mem;
        cpa( self.get_proc_segment($_) ) if $segment;
        cpa( self.get_proc_signal($_)  ) if $signal;

        if $files {
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

        if $wd {
          my $wdb = self.get_proc_wd($_);

          cpa($wdb.tail);
          $h<working-dirs> = CArrayToArray($wdb.head);
        }

        if $map {
          my $me = self.get_proc_map($_);

          cpa($me.tail);
          $h<maps> = $me.head;
        }

        $h
      }),
      $buf
    );
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
