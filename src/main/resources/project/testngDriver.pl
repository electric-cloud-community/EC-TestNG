# TestNG
# Plugin version 1.0
# Date
#    04/01/2011
#
# Engineer
#    Brian Nelson
#
# Copyright (c) 2011 Electric Cloud, Inc.
# All rights reserved
# -------------------------------------------------------------------------


# -------------------------------------------------------------------------
# Includes
# -------------------------------------------------------------------------
use strict;
use warnings;
$|=1;
use ElectricCommander;


#------------------------------------------------------------------------
  # trim - deletes blank spaces before and after the entered value in 
  # the argument
  #
  # Arguments:
  #   -untrimmedString: string that will be trimmed
  #
  # Returns:
  #   trimmed string
  #
  #------------------------------------------------------------------------- 
  sub trim($) {
  
     my ($untrimmedString) = @_;
      
      my $string = $untrimmedString;
      
      #removes leading spaces
      $string =~ s/^\s+//;
      
      #removes trailing spaces
      $string =~ s/\s+$//;
      
      #returns trimmed string
      return $string;
 }


# -------------------------------------------------------------------------
# Variables
# -------------------------------------------------------------------------

my $ec = new ElectricCommander();
$ec->abortOnError(0);

$::testngFile = trim($ec->getProperty("/myCall/testngFile")-> findvalue("//value")->value());
$::options = trim($ec->getProperty("/myCall/options")-> findvalue("//value")->value());
$::reportDirectory = trim($ec->getProperty("/myCall/reportDirectory")-> findvalue("//value")->value());
$::testngClasspath = trim($ec->getProperty("/myCall/testngClasspath")-> findvalue("//value")->value());

# -------------------------------------------------------------------------
# main - contains the whole process to be done by the plugin, it builds 
#        the command line, sets the properties and the working directory
#
# Arguments:
#   -none
#
# Returns:
#   -nothing
#
# -------------------------------------------------------------------------
sub main() {
    
    # create args array
    my @args = ();
    my %props;	


# if options : add to command string

    if($::options && $::options ne "") {
        foreach my $options (split(' ', "$::options")) {
             push(@args, $options);
         }
    }

# if reportDirectory : add to command string

 if($::reportDirectory && $::reportDirectory ne "") {
        foreach my $reportDirectory (split(' ', "-d". ' "'. "$::reportDirectory" .'"')) {
             push(@args, $reportDirectory);
         }
    }

 # if testngFile: add to command string

    if($::testngFile && $::testngFile ne "") {
        foreach my $testngFile (split(' ', "$::testngFile")) {
             push(@args, $testngFile);
         }
    }


    $props{"testngCommandLine"} = createTestNGCommandLine(\@args);
    setProperties(\%props);
}

# -------------------------------------------------------------------------
# createTestNGCommandLine - creates the command line for the invocation
# of the program to be executed.
#
# Arguments:
#   -arr: array containing the command name and the arguments entered by 
#         the user in the UI
#
# Returns:
#   -the command line to be executed by the plugin
#
# -------------------------------------------------------------------------

sub createTestNGCommandLine($) {

    my ($arr) = @_;

    my $command = "java -ea -classpath ".'"'.".;$::testngClasspath".';'.'src/'.'" '.'com.beust.testng.TestNG';

    foreach my $elem (@$arr) {
        $command .= " $elem";
    }
    
    return $command;
}

# -------------------------------------------------------------------------
# setProperties - set a group of properties into the Electric Commander
#
# Arguments:
#   -propHash: hash containing the ID and the value of the properties 
#              to be written into the Electric Commander
#
# Returns:
#   -nothing
#
# -------------------------------------------------------------------------
sub setProperties($) {

    my ($propHash) = @_;

    # get an EC object
    my $ec = new ElectricCommander();
    $ec->abortOnError(0);

    foreach my $key (keys % $propHash) {
        my $val = $propHash->{$key};
        $ec->setProperty("/myCall/$key", $val);
    }
}

main();
