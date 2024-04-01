#/usr/bin/env raku
use v6;

use GLib::Top::Server;
use Physics::Unit;

sub output-pids {
}

sub output-uid {
}

sub output-mem {
}

sub output-map {
}

sub output-segment {
}

sub output-wd {
}

sub output-files {
}

sub output (
  $data,
  :$files                   = False,
  :$pids                    = False,
  :$uid                     = True,
  :$map                     = False,
  :$mem                     = True,
  :$wd                      = True,
) {
  [~](
    output-pids($data)    if $pids,
    output-uid($data)     if $uid,
    output-mem($data)     if $mem,
    output-map($data)     if $map,
    output-segment($data) if $segmen,
    output-wd($data)      if $wd
    output-files($data)   if $files,
  );
}

sub query-by-size ($field, $value, $tolerance) {
  do given $value {
    when * < 0   { $field <= $value }
    when * > 0   { $field >= $value }
    when .not.so { $field ~~ $value - $tolerance .. $value + $tolerance }
  }
}

sub MAIN (
  :$files                   = False,
  :$pids                    = False,
  :$uid                     = True,
  :$map                     = False,
  :$mem                     = True,
  :$segment                 = False,
  :$wd                      = True,
  :$tolerance               = 100k,
  :qm(:$query-mem)          = 5000M,
  :qf(:$query-file)         = '',
  :qu(:$query-user) is copy = False,
  :Qp(:$query-pid)  is copy = ''
) {
  my $mem-detail;

  if $query-mem.contains(':') {
    ($mem-detail, $query-mem) = $query-mem.split(':');
    $mem-detail .= split(',') if $mem-detail.contains(',');
  }

  $query-mem    = try $query-mem.Int;
  $query-mem    = EVAL { "{ $query-mem }" } if $query-mem ~~ Failure;

  $query-user ||= $*USER.Int;
  $query-pid    = $query-pid.split(',') if $query-pid.contains(',');

  my $procs = GLib::Top.get_proclist(
    :$files   = False,
    :$pids    = False,
    :$uid     = True,
    :$map     = False,
    :$mem     = True,
    :$wd      = True,
    :$segment = False
  ).head.grep({
    [&&](
      $query-user ?? $query-user     == .<euid> !! True,
      $query-pid  ?? $query-pid.any  == .<pid>  !! True,
      $query-mem && $mem
        ?? [||](
          query-by-size( .<resident>, $query-mem )
            if $mem-detail.not || $mem-detail.any eq 'resident',
          query-by-size( .<rss>,      $query-mem )
            if $mem-detail.not || $mem-detail.any eq 'rss',
          query-by-size( .<share>,    $query-mem )
            if $mem-detail.not  || $mem-detail.any eq 'share',
          query-by-size( .<size>,     $query-mem )
            if $mem-detail.not || $mem-detail.any eq 'size'
        )
        !! True,
      # cw: Add for $segment
      $query-file && $files
        ?? .<open-files>.grep({
             .info.contains($query-file) || $query-file.contains( .info )
           })
        !! True
    )
  });

  my $*MAX-PID = $procs.head.tail<pid>;

  # cw: Need something better than .gist! (ya lazy bum!)
  .gist.say for $procs;


  # PID EXE
  #   Root
  #   Size RSS Share
  #   Remaining blocks, each 24 chars and columnized by screen width

}
