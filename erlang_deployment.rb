# encoding: utf-8

center <<-EOS
  Erlang Deployment Options:
  How To Ship New Code Without Taking Your System Down



  Martin Rehfeld, Wooga
  @klickmich

  Erlang Factory Berlin 2014
EOS

block <<-EOS
Software deployment is all of the activities
that make a software system available for use.

The *update process* replaces an earlier
version of all or part of a software system
with a newer release.




http://en.wikipedia.org/wiki/Software_deployment
EOS

section "Prelude: Update by Restart" do
  block <<-EOS
    Update by Restart    // what everybody does

      + Simple

      + Common

      + Works with all languages

      + Good tool support


      - Program will lose (in-memory) state

      - Update interrupts availability
        (which needs to be prevented by adding
         additional infrastructure like
         load balancers)
  EOS
end

section "Fugue: Hot Code Loading" do
  block <<-EOS
    !                                              !
    !                                              !
    !             /-\\                              !
    !    process (   )                             !
    !             \\_/                              !
    !                                              !
    !              |                               !
    !              | runs in                       !
    !              v                               !
    !                                              !
    !    old version m'      current version m     !
    !    +----------------+  +----------------+    !
    !    | a() -> b().    |  | -export([d/0]).|    !
    !    |                |  |                |    !
    !    | b() ->         |  | ...            |    !
    !    |   ...          |  |                |    !
    !    |                |  | d() ->         |    !
    !    | c() -> m:d().  |  |   ...          |    !
    !    +----------------+  +----------------+    !
    !                                              !
    !                                              !
  EOS

  block <<-EOS
    Hot Code Loading     // Erlang speciality

      + Still relatively simple

      + Preserves in-memory state

      + Application remains available
        during update


      - Erlang specific

      - Limited, beware of common pitfalls

      - Not much out of the box tooling,
        but good support for rolling your own
  EOS
end

section "Finale: Release Upgrades" do
  block <<-EOS
    Appup Features:

      * Change internal state

      * Handle module dependencies

      * Change a supervisor

      * Run arbitrary code during updates

      * Add, remove or restart an application

      * Change an application specification/
        configuration
  EOS

  block <<-EOS
    Release Upgrades:       // Ghetto ;-)

      + All advantages of plain hot code loading

      + Covers much more edge cases


      - A lot of work to prepare AND TEST upgrades

      - You are using OTP behaviours, right?
  EOS
end

center <<-EOS
  Examples and Slides

  https://github.com/martinrehfeld/tkn-efl2014





  Martin Rehfeld, Wooga
  @klickmich
EOS
