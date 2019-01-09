use ElectricCommander;

push (@::gMatchers,
  {
        id =>          "testsRun",
        pattern =>     q{Total tests run: (.+)},
        action =>           q{
                              
                              my $desc = ((defined $::gProperties{"summary"}) ? $::gProperties{"summary"} : '');

                              $desc .= "Total test Run : $1 ". "\n";
                                
                               setProperty("summary", $desc . "\n");
                              
                             },
  },
);

push (@::gMatchers,
  {
        id =>          "testsRun2",
        pattern =>     q{.+ Tests run: (.+)},
        action =>           q{
                              
                              my $desc = ((defined $::gProperties{"summary"}) ? $::gProperties{"summary"} : '');

                              $desc .= "Total test Run : $1 ". "\n";
                                
                               setProperty("summary", $desc . "\n");
                              
                             },
  },
);


push (@::gMatchers,
  {
        id =>          "failures",
        pattern =>     q{.+Failures: (.+)},
        action =>           q{
                              
                              my $desc = ((defined $::gProperties{"summary"}) ? $::gProperties{"summary"} : '');

                              $desc .= "Failures: $1 " . "\n";
                                
                               setProperty("summary", $desc . "\n");
                              
                             },
  },
);


push (@::gMatchers,
  {
        id =>          "skips",
        pattern =>     q{.+Skips: (.+)},
        action =>           q{
                              
                              my $desc = ((defined $::gProperties{"summary"}) ? $::gProperties{"summary"} : '');

                              $desc .= "Total test Run : $1 " . "\n";
                                
                               setProperty("summary", $desc . "\n");
                              
                             },
  },
);
