use v6.c;

grammar ProcNetTcpGrammar {
  regex TOP {
    \s*<header>\s*
    <line>+
  }

  rule header {
    'sl'
    'local_address'
    'rem_address'
    'st'
    'tx_queue'
    'rx_queue'
    'tr'
    'tm->when'
    'retrnsmt'
    'uid'
    'timeout'
    'inode'
  }

  token hex   { <[0..9A..Fa..f]> }
  token hex8  { <hex> ** 8 }
  token hex16 { <hex> ** 16 }
  token num   { '-'?\d+ }

  token sl          { (\d+)':' }
  token address     { <hex8> ':' $<port>=[ <hex> ** 4 ] }
  token st          { <hex> ** 2 }
  token txrxqueue   { <hex8> ':' <hex8> }
  token trtm        { <hex> ** 2 ':' <hex8> }
  token ret         { <hex8> }
  token uid         { \d+ }
  token timeout     { \d+ }
  rule  inode       { (\d+) \d+ <hex16> [ \d+ \d+ \d+ \d+ <num> ]? }

  rule line {
    <sl> <address> <address> <st> <txrxqueue> <trtm> <ret> <uid> <timeout> <inode>
  }

}

grammar ProcNetUdpGrammar is ProcNetTcpGrammar {

  rule header {
    'sl'
    'local_address'
    'rem_address'
    'st'
    'tx_queue'
    'rx_queue'
    'tr'
    'tm->when'
    'retrnsmt'
    'uid'
    'timeout'
    'inode'
    'ref'
    'pointer drops'
  }

  rule inode { (\d+) \d+ <hex16> \d+ }

}


class ProcNetTcpActions {

  method TOP ($/) {
    make $/<line>.map( *.made )
  }

  method address ($/) {
    make {
      ip   => $/<hex8>.Str.comb.rotor(2).map({ ('0x' ~ .join).Int }).reverse,
      port => ("0x" ~ $/<port>).Int
    }
  }

  method sl ($/) {
    make $/.head.Int;
  }

  method st ($/) {
    make ("0x" ~ $/).Int;
  }

  method uid ($/) {
    make $/.Int;
  }

  method inode ($/) {
    make $/.head.trim.Int
  }

  method line ($/)  {
    make {
      num    => $/<sl>.made,
      local  => $/<address>.head.made,
      state  => $/<st>.made,
      uid    => $/<uid>.made,
      remote => $/<address>.tail.made,
      inode  => $/<inode>.made
    }
  }

}

sub parse-proc-net-tcp ($data) is export {
  ProcNetTcpGrammar.parse($data, actions => ProcNetTcpActions ).made;
}

sub parse-proc-net-udp ($data) is export {
  ProcNetUdpGrammar.parse($data, actions => ProcNetTcpActions ).made;
}
