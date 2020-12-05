%===========================================
% This program is run in order to answer the following question they
% are unique,
% Which reindeer rides which elf?
% How many toys did each elf make?
% What area are the two located?
%
% The following facts are known about the reindeer and the elves who
% rode them that day:
% 1. Rudolf hangs out two or more areas to the eastof Wunorse Openslae�s reindeer.
% 2. The reindeer of the elf that made nine toys lives somewhere to the
% west of Alabaster Snowball�s reindeer.
% 3. Three reindeer in consecutive areas, from west to east, are Dasher,
% Alabaster Snowball�s reindeer, and the reindeer of the elf that made
% 12 toys.
% 4. The elf who rode Rudolf has made three toys more than the
% one who rode the reindeer in area 4, while Pepper Minstix made three
% toys more than Sugarplum Mary. All four elves mentioned here are
% unique.
% 5. Comet�s rider made three toys more than Shinny Upatree, who
% in turn made two toys more than the elf who rode Vixen. The elf who
% rode Vixen is Shinny Upatree, Sugarplum Mary or Wunorse Onenslae.
% 6. Blitzen lives somewhere to the west of Bushy Evergreen�s reindeer.
% 7. Alabaster Snowball made exactly one toy more than Wunorse Openslae.
% 8. Pepper Minstix didn�t ride the reindeer from area 6.
%
%Created By: Arnold Gihzo and Joseph Menezes
%Created on 2nd December 2020
%LastEdited on 02/12/2020 @ 8:45pm
%====================================================

%======================================================
%Facts
%======================================================
toys([15,14,12,10,9,7]).
%reindeer(["Dasher", "Prancer", "Vixen", "Comet", "Blitzen","Rudolf"]).
elves(["Alabaster Snowball", "Bushy Evergreen", "Pepper Minstrix","Shinny Upatree","Sugaplum Mary","Wunrose Openslae"]).
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

%=========================================================
% rule5(solutions) - I t will return true is conditions are met.
%
% This rule is broken down into two section as the data provided is
% unique.
%
% Comet�s rider made three toys more than Shinny Upatree, who in
% turn made two toys more than the elf who rode Vixen. The elf who rode
% Vixen is Shinny Upatree, Sugarplum Mary or Wunorse Onenslae.
%
% Solution - [[reindeer,Elves, Toys, areas],....]
%
rule5(Solution):-
    rule5A(Solution),
    rule5B(Solution).
%==========================================================
% rule5A(Solution) - Returns true if comet makes more toys
% VixenToys < ShinnyToys < CometToys
%
% Solution - [[reindeer, eleves, toys, areas],.....]
%
rule5A(Solution) :-
    member(["Comet",_,CometToys,_], Solution),
    member([_,"Shinny Upatree", ShinnyToys,_], Solution),
    member(["Vixen",_,VixenToys,_], Solution),
    CometToys is ShinnyToys + 3,
    ShinnyToys is VixenToys + 3.
%===========================================================
%rule5B(Solution) :- Returns true for possible elves for vixen.
%
% Two possibilities
%Solution -[[reindeer, elves, toys,areas],....]
%
rule5B([_,_,["Vixen", "Sugaplum Mary",_,_],_,_,_]).
rule5B([_,_,["Vixen", "Wunrose Oneslae",_,_],_,_,_]).
%===========================================================
% distributionAreasAndToys - it will put areas and toys into the Solutions

distributionAreasAndToys([]).
distributionAreasAndToys([[_,_,NumberToys,Area]|Rest]):-
  toys(PossibleToys),
  member(NumberToys, PossibleToys),
  areas(PossibleAreas),
  member(Area, PossibleAreas),
  distributionAreasAndToys(Rest).
%===========================================================
% rule8 :- Returns true for all possible values in which Peper Minstix did
% not ride the reindeer in area 6


rule8(Solution):-
  member([_,"Pepper Minstrix",_,Area], Solution),
  Area \= 6.
  % Area \= 5,
  % Area \= 4,
  % Area \= 3,
  % Area \= 1.

%===========================================================
%rule3 :- Returns true for all possible vakues in which Dasher
% Albaster, Snowball's Reindeer, and the rein deer of the elf that
% made 12 toys.

rule3(Solution):-
  member(["Dasher",_,_,AreaDasher], Solution),
  member([_,"Alabaster Snowball",_,AreaAlabaster], Solution),
  member([_,_,12,AreaToys], Solution),
  AreaDasher is AreaAlabaster - 1,
  AreaAlabaster is AreaToys - 1.

%===========================================================
% rule7: Returns true if all possible values where Alabaster has made
% exactly one toy more than Wunorse Openslae

rule7(Solution):-
  member([_,"Alabaster Snowball",ToyAlabaster,_], Solution),
  member([_,"Wunorse Openslae", ToyWunorse,_], Solution),
  ToyAlabaster is ToyWunorse + 1.

%===========================================================
%rule1 : Returns true in all possible areas where Rudolf hangs out
% two more areas to the east of Wunrose Openslae's Reindeer

rule1(Solution):-
  member(["Rudolf",_,_,AreaRudolf], Solution),
  member([_,"Wunrose Openslae", _,AreaOpenslae], Solution),
  NewArea is AreaOpenslae - 2,
  AreaRudolf < NewArea.

%===========================================================

rule2(Solution):-
  member([_,_,9,Areaof9], Solution),
  member([_,"Alabaster Snowball",_,AreaAlabaster], Solution),
  Areaof9 < AreaAlabaster.

% rule4(Solution):-
%   member(["Rudolf",ElfRudolf,ToysRudolf,AreaRudolf],Solution),
%   member([Reindeer4,Elef4,NumberToys4,4], Solution),
%   member([ReindeerMin,"Pepper Minstrix",NumToyMin,AreaMin], Solution),
%   member([ReindeerMary,"Sugaplum Mary",NumToyMary,AreaMary],Solution),
%   ToysRudolf is NumberToys + 3,
%   NumToyMin is NumToyMary + 3,
%   Reindeer4 \= ReindeerMin,
%   ReindeerMin \= ReindeerMary,
%   Reindeer4 \= ReindeerMary,

rule6(Solution):-
  member(["Blitzen",_,_,AreaBli], Solution),
  member([_,"Bushy Evergreen",_,AreaBushy], Solution),
  AreaBli < AreaBushy.

%============================================================
%solve - intiates the run of our program.
%
%retrieves solutions in the form of parameter X,
%then runs list through the rules.
%
solve(Solution):-
  solutions(Solution),
  distributionAreasAndToys(Solution),
  rule5(Solution),
  rule3(Solution),
  rule8(Solution),
  rule7(Solution),
  rule1(Solution),
  rule2(Solution).
  rule6(Solution).




% consult('/Users/arnoldgihozo/Documents/GitHub/SantasHelper/santahelper.pl').
