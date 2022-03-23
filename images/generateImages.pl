#!/usr/bin/perl
use strict;
use warnings;

sub printToStdout
{
  my @Data = @_;

  for ( my $i = 0; 1; ++$i )
  {
    my $Line;
    my $IsDefined;
    for my $Ref ( @Data )
    {
      my $Value = ${$Ref}[$i];
      if ( defined $Value )
      {
        $Line .= sprintf "%12g ", $Value;
        $IsDefined = 1;
      } else {
        $Line .= "0 ";
      }
    }

    last unless $IsDefined;
    print $Line, "\n";
  }
}

sub runawayForces
{
  my $e = 1.6e-19;
  my $ElField = 0.07;
  my $Te = 20e3 * 1.60218e-19;
  my $me = 9.10938356e-31;
  my $Eps0 = 8.85418e-12;
  my $Ve = sqrt( 2*$Te / $me );
  my $n = 1e20;
  my $L = 5;

  my ( @Velocity, @ElForce, @SlowForce );
  for ( my $i = 1; $i < 1000; $i++ ) 
  {
    my $v = 0.005*$i*$Ve;
    push @Velocity, $v;
    push @ElForce, $e * $ElField;
    push @SlowForce, $me * $v * ( 3 * ($e**4) * $n * $L )/( 4 * 3.14 * ($Eps0**2) * ($me**2) * (( $v**2 + $Ve**2)**(3.0/2.0)) );
  }

  return ( \@Velocity, \@ElForce, \@SlowForce );
}

printToStdout runawayForces;


