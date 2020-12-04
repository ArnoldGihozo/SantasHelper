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
areas([1, 2, 3, 4, 5 , 6]).

%[reindeer, elver, No.Of Toys,areas]
solutions([["Dasher",_,_,_],
           ["Prancer",_,_,_],
           ["Vixen",_,_,_],
           ["Comet",_,_,_],
           ["Blitzen",_,_,_],
           ["Rudlof",_,_,_]]).

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
%============================================================
%solve - intiates the run of our program.
%
%retrieves solutions in the form of parameter X,
%then runs list through the rules.
%
solve:-
    solutions(Solution),
    distributionAreasAndToys(Solution),
    rule5(Solution).
