Feature: Reusable Feature

  Scenario: print an statement
    * print "Hello Karate"

  @dynamic
  Scenario: print dynamic statement
    * print input
    
  @tagged
  Scenario: end of statement
    * print "---------------- Finished ----------------"
