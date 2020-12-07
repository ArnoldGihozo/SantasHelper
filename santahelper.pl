%===========================================
% This program is run in order to answer the following question they
% are unique,
% Which reindeer rides which elf?
% How many toys did each elf make?
% What area are the two located?
%
% The following facts are known about the reindeer and the elves who
% rode them that day:
% 1. Rudolf hangs out two or more areas to the eastof Wunorse Openslae's reindeer.
% 2. The reindeer of the elf that made nine toys lives somewhere to the
% west of Alabaster Snowball's reindeer.
% 3. Three reindeer in consecutive areas, from west to east, are Dasher,
% Alabaster Snowball's reindeer, and the reindeer of the elf that made
% 12 toys.
% 4. The elf who rode Rudolf has made three toys more than the
% one who rode the reindeer in area 4, while Pepper Minstix made three
% toys more than Sugarplum Mary. All four elves mentioned here are
% unique.
% 5. Comet's rider made three toys more than Shinny Upatree, who
% in turn made two toys more than the elf who rode Vixen. The elf who
% rode Vixen is Shinny Upatree, Sugarplum Mary or Wunorse Onenslae.
% 6. Blitzen lives somewhere to the west of Bushy Evergreen's reindeer.
% 7. Alabaster Snowball made exactly one toy more than Wunorse Openslae.
% 8. Pepper Minstix didn't ride the reindeer from area 6.
%
%Created By: Arnold Gihzo and Joseph Menezes
%Created on 2nd December 2020
%LastEdited on 06/12/2020 @ 9:37pm
%====================================================

%======================================================
%Facts
%======================================================
toys([15,14,12,10,9,7]).
%reindeer(["Dasher", "Prancer", "Vixen", "Comet", "Blitzen","Rudolf"]).
%elves([as, be, pm,su,sm,wo]).
areas([1, 2, 3, 4, 5 ,6]).

%[reindeer, elver, No.Of Toys,areas]
solutions([["Rudolf",_,_,_],
           ["Prancer",_,_,_],
           ["Vixen",_,_,_],
           ["Comet",_,_,_],
           ["Blitzen",_,_,_],
           ["Dasher",_,_,_]]).


%=======================================================
% Rules

%===========================================================
%checkElf(PossibleElf) :- Returns true for possible elves for "Vixen".
%
% Two possibilities
% Solution -[[reindeer, elves, toys,areas],....]
%
checkElf("Sugarplum Mary").
checkElf("Wunrose Openslae").

%=========================================================
% rule5(solutions) - I t will return true is conditions are met.
%
% This rule is broken down into two section as the data provided is
% unique.
%
% Comet's rider made three toys more than Shinny Upatree, who in
% turn made two toys more than the elf who rode Vixen. The elf who rode
% Vixen is Shinny Upatree, Sugarplum Mary or Wunorse Onenslae.
%
% Solution - [[reindeer,Elves, Toys, areas],....]
%
%
rule5(Solution) :-
    member(["Comet",_,CometToys,_], Solution),
    member([_,"Shinny Upatree", ShinnyToys,_], Solution),
    member(["Vixen",ElfVix ,VixenToys,_], Solution),
    CometToys is ShinnyToys + 3,
    ShinnyToys is VixenToys + 2,
    checkElf(ElfVix).
%===========================================================
% distributionAreas - it will put areas into the Solutions
%
distributionAreas([]).
distributionAreas([[_,_,_,Area]|Rest]):-
  areas(PossibleAreas),
  member(Area, PossibleAreas),
  distributionAreas(Rest).
%=====================================================================
%diatributionToys - It will put toys into the solutions.
%
distributionToys([]).
distributionToys([[_,_,Toys,_]|Rest]):-
    toys(PossibleToys),
    member(Toys, PossibleToys),
    distributionToys(Rest).

%===========================================================
% rule8(Solution):- Returns true for all possible values in which Peper
% Minstix did not ride the reindeer in area 6
%
% Solution - [[reindeer,elf,toys,area],........]
%
rule8(Solution):-
  member([_,"Pepper Minstix",_,Area], Solution),
  checkArea(Area).

%=======================================================================
%checkArea(Possible Area) - assigns areas that are not 6
%
checkArea(1).
checkArea(2).
checkArea(3).
checkArea(4).
checkArea(5).
%checkArea(5).

%===========================================================
% rule3(Solution) :- Returns true for all possible vakues in which
% Dasher Albaster, Snowball's Reindeer, and the rein deer of the elf
% that made 12 toys.
%
% Solution - [[reindeer,elf,toys,area],.....]
%
rule3(Solution):-
  member(["Dasher",_,_,AreaDasher], Solution),
  member([_,"Alabaster Snowball",_,AreaAlabaster], Solution),
  member([_,_,12,AreaToys], Solution),
  AreaAlabaster is AreaDasher + 1,
  AreaToys is AreaDasher + 2.

%===========================================================
% rule7(Solution): Returns true if all possible values where Alabaster
% has made exactly one toy more than Wunorse Openslae
%
% Solution - [[reindeer, elf, toys,area],.......]
%
rule7(Solution):-
  member([_,"Alabaster Snowball",ToyAlabaster,_], Solution),
  member([_,"Wunrose Openslae", ToyWunorse,_], Solution),
  ToyAlabaster is ToyWunorse + 1.

%===========================================================
% rule1(Solution): Returns true in all possible areas where Rudolf hangs
% out two more areas to the east of Wunrose Openslae's Reindeer
%
% Solution - [[reindeer,elf,toys,area],.....]
rule1(Solution):-
  member(["Rudolf",_,_,AreaRudolf], Solution),
  member([_,"Wunrose Openslae", _,AreaOpenslae], Solution),
  NewArea is AreaOpenslae + 1,
  AreaRudolf > NewArea.


%===========================================================
% rule2(Solution) - returns true where the area of the elf that made 9
% toys is less than the area of alabaster.
%
% Solution - [[reindeer, elf, toys, area],.....]
rule2(Solution):-
  member([_,_,9,Areaof9], Solution),
  member([_,"Alabaster Snowball",_,AreaAlabaster], Solution),
  Areaof9 < AreaAlabaster. % this could be Dasher
%===============================================================
%rule4(Solution) - returns true for the following rule:
%
% The elf who rode Rudolf has made three toys more than the
% one who rode the reindeer in area 4, while Pepper Minstix made three
% toys more than Sugarplum Mary. All four elves mentioned here are
% unique.
% Solution - [[reindeer, elf, toys, area],.....]

rule4(Solution):-
   member(["Rudolf",_,ToysRudolf,_],Solution),
   member([_,_,NumberToys4,4], Solution),
   member([_,"Pepper Minstix",NumToyMin,_], Solution),
   member([_,"Sugarplum Mary",NumToyMary,_],Solution),
   ToysRudolf is NumberToys4 + 3,
   NumToyMin is NumToyMary + 3.
%=======================================================================
%rule6(Solution) - returns true if blitzen is less than bushyEvergreen
%
%
% Solution - [[reindeer, elf, toys, area],.....]

rule6(Solution):-
  member(["Blitzen",_,_,AreaBli], Solution),
  member([_,"Bushy Evergreen",_,AreaBushy], Solution),
  AreaBli < AreaBushy.

%============================================================
%noDuplicates(dupList) - returns true if there are no duplicates.
%
%dupList - a list of all areas or toys.
noDuplicates([]).
noDuplicates([First | Rest]):-
    not(member(First, Rest)),
    noDuplicates(Rest).

%=======================================================================
%uniqueToys(Solution) - checks to see if all toys in Solution are unique
%
% Solution - [[reindeer, elf, toys, area],.....]
uniqueToys([[_,_,T1,_],[_,_,T2,_],[_,_,T3,_],[_,_,T4,_],[_,_,T5,_],[_,_,T6,_]]):-
    noDuplicates([T1,T2,T3,T4,T5,T6]).

%=======================================================================
% uniqueAreas(Solution) - checks to see if all areas in Solution are
% unique
%
% Solution - [[reindeer, elf, toys, area],.....]
uniqueAreas([[_,_,_,A1],[_,_,_,A2],[_,_,_,A3],[_,_,_,A4],[_,_,_,A5],[_,_,_,A6]]):-
    noDuplicates([A1,A2,A3,A4,A5,A6]).


%============================================================
%solve - intiates the run of our program.
% and outputs the solution
solve:-
    write('Area     Reindeer   Elf                    Toys'),nl,
    write('-----    ---------  -------------     ---------'),nl,
    run(Solution),
    showResult(Solution, 1).

%===============================================================
%run(Solution) - returns true if all rules are true
%
% To figure out the understanding of the concept of backtracking we had
% a discussion with Harshil, who helped in clarifying why each step
% requires an order.
%
%
%Solution - [[reindeer, elf, toys, area],.........]
%
run(Solution):-
  solutions(Solution),
  rule8(Solution),
  distributionToys(Solution),
  rule7(Solution),
  rule4(Solution),
  rule5(Solution),
  uniqueToys(Solution),
  distributionAreas(Solution),
  rule6(Solution),
  rule2(Solution),
  rule1(Solution),
  rule3(Solution),
  uniqueAreas(Solution).
%========================================================
%showResult(Solution, Area) - returns formatted output of our results.
%
%baseCase is when area is 7 we return the rest of our list.
%
%Solution - [[reindeer, elf, toys, area],.........]
%Area - The intial start to retrieve our area. (1 - 6)
%
showResult(Solution, Area):-
    member([Rein, Elf, NumToys, Area], Solution),
    writef('%8l %10l %20l %5r ', [Area, Rein, Elf, NumToys]),nl,
    NewArea is Area + 1,
    showResult(Solution, NewArea).
showResult(_,7).





% consult('/Users/arnoldgihozo/Documents/GitHub/SantasHelper/santahelper.pl').
