%==============================================================================
%  Authors:  Arnold Gihzo and Joseph Menezes
%  Class: AUCSC 370
%  Date Created: December 2nd 2020
%  Date Last Modified: December 9th 2020
%
%
% Description:
% The program finds a solution to 7 simple rules.The following facts are known
% about the reindeer and the elves who rode them that day:
% 1. Rudolf hangs out two or more areas to the eastof Wunorse Openslae's reindeer.
% 2. The reindeer of the elf that made nine toys lives somewhere to the
% west of Alabaster Snowball's reindeer.
% 3. Three reindeer in consecutive areas, from west to east, are Dasher,
% Alabaster Snowball's reindeer, and the reindeer of the elf that made 12 toys.
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
%
%==============================================================================
% PROGRAM fORMAT
% Facts --> in here you will find all our given facts (including set-up solution)
% Rules --> in here you will find all the given rules (based on the top description)
%           you wil lalso find our distribution of our toys and areas. Please
%           note that the order in this section is not in logical form.
% Run --> in here you will find the function to start the execution of program
%         the priting format as the logical sequence of our rules (which is
%         explained bellow)
%
%==============================================================================
%                               FACTS
% in here you will find all our given facts (including set-up solution)
%==============================================================================
toys([15,14,12,10,9,7]).
elves([as, be, pm,su,sm,wo]).
areas([1, 2, 3, 4, 5 ,6]).

% Solution will contain items in the following order:
% FORMAT: [reindeer, elf, toys, area]
solutions([["Rudolf",_,_,_],
           ["Prancer",_,_,_],
           ["Vixen",_,_,_],
           ["Comet",_,_,_],
           ["Blitzen",_,_,_],
           ["Dasher",_,_,_]]).

% This fact is for rule 5 to check who Vixen rides.
checkElf("Shinny Upatree").
checkElf("Sugarplum Mary").
checkElf("Wunrose Openslae").

% These facts are for rule 8 to check if Peper Minstix is not in Area 6
checkArea(1).
checkArea(2).
checkArea(3).
checkArea(4).
checkArea(5).


%==============================================================================
%                                RULES
% In here you will find all the given rules (based on the top description)
% you wil lalso find our distribution of our toys and areas. Please
% note that the order in this section is not in logical form.
%==============================================================================
% distributionAreas :- it will put areas  into the Solutions
% FORMAT: [reindeer, elf, toys, area]
distributionAreas([]).
distributionAreas([[_,_,_,Area]|Rest]):-
  areas(PossibleAreas),
  member(Area, PossibleAreas),
  distributionAreas(Rest).

%------------------------------------------------------------------------------
% distributionToys :- will distribute all the toys in all possible spaces
% (in Solution)
% FORMAT: [reindeer, elf, toys, area]

distributionToys([]).
distributionToys([[_,_,Toys,_]|Rest]):-
    toys(PossibleToys),
    member(Toys, PossibleToys),
    distributionToys(Rest).

%------------------------------------------------------------------------------
% rule1(Solution) :- Returns true in all possible areas where Rudolf hangs out
% two more areas to the east of Wunrose Openslae's Reindeer
% FORMAT: [reindeer, elf, toys, area]

rule1(Solution):-
  member(["Rudolf",_,_,AreaRudolf], Solution),
  member([_,"Wunrose Openslae", _,AreaOpenslae], Solution),
  NewArea is AreaOpenslae + 1,
  AreaRudolf > NewArea.

%------------------------------------------------------------------------------
% rule2(Solution) :- Returns true if the elf who made 9 toys is to the
% West of Albaster Snow Ball
% FORMAT: [reindeer, elf, toys, area]

rule2(Solution):-
  member([_,_,9,Areaof9], Solution),
  member([_,"Alabaster Snowball",_,AreaAlabaster], Solution),
  Areaof9 < AreaAlabaster.

%------------------------------------------------------------------------------
%rule3(Solution):- Returns true for all possible values in which Dasher
% Albaster, Snowball's Reindeer, and the rein deer of the elf that
% made 12 toys.
% FORMAT: [reindeer, elf, toys, area]

rule3(Solution):-
  member(["Dasher",_,_,AreaDasher], Solution),
  member([_,"Alabaster Snowball",_,AreaSnowBall], Solution),
  member([_,_,12,Area12], Solution),
  AreaSnowBall is AreaDasher + 1,
  Area12 is AreaDasher + 2.

%------------------------------------------------------------------------------
% rule4(Solution) :- Returns true for every single possiblility of these facts
% The elf who rode Rudolf has made three toys more than the
% one who rode the reindeer in area 4, while Pepper Minstix made three
% toys more than Sugarplum Mary. All four elves mentioned here are
% unique.
% FORMAT: [reindeer, elf, toys, area]

rule4(Solution):-
  member(["Rudolf",_,ToysRudolf,_],Solution),
  member([_,_,NumberToys4,4], Solution),
  member([_,"Pepper Minstix",NumToyMin,_], Solution),
  member([_,"Sugarplum Mary",NumToyMary,_],Solution),
  ToysRudolf is NumberToys4 + 3,
  NumToyMin is NumToyMary + 3.

%-------------------------------------------------------------------------------
% rule5(Solution) :- Returns True if the following condtions are met:
%
% Comet's rider made three toys more than Shinny Upatree, who in
% turn made two toys more than the elf who rode Vixen. The elf who rode
% Vixen is Shinny Upatree, Sugarplum Mary or Wunorse Onenslae.
% FORMAT: [reindeer, elf, toys, area]

rule5(Solution) :-
    member(["Comet",_,CometToys,_], Solution),
    member([_,"Shinny Upatree", ShinnyToys,_], Solution),
    member(["Vixen",ElfVix ,VixenToys,_], Solution),
    CometToys is ShinnyToys + 3,
    ShinnyToys is VixenToys + 2,
    checkElf(ElfVix).

%------------------------------------------------------------------------------
%rule6(Solution) :- Returns true if Blitzen is before Bushy Evergreen
% FORMAT: [reindeer, elf, toys, area]

rule6(Solution):-
  member(["Blitzen",_,_,AreaBli], Solution),
  member([_,"Bushy Evergreen",_,AreaBushy], Solution),
  AreaBli < AreaBushy.

%------------------------------------------------------------------------------
% rule7(Solution):- Returns true if all possible values where Alabaster has made
% exactly one toy more than Wunorse Openslae
% FORMAT: [reindeer, elf, toys, area]

rule7(Solution):-
  member([_,"Alabaster Snowball",ToyAlabaster,_], Solution),
  member([_,"Wunrose Openslae", ToyWunorse,_], Solution),
  ToyAlabaster is ToyWunorse + 1.

%------------------------------------------------------------------------------
% rule8 :- Returns true for all possible values in which Peper Minstix did
% not ride the reindeer in area 6
% FORMAT: [reindeer, elf, toys, area]

rule8(Solution):-
  member([_,"Pepper Minstix",_,Area], Solution),
  checkArea(Area).


%------------------------------------------------------------------------------
%noDuplicates(Solution) - returns true if there are no similar values
% FORMAT: [reindeer, elf, toys, area]

noDuplicates([]).
noDuplicates([First | Rest]):-
    not(member(First, Rest)),
    noDuplicates(Rest).

%------------------------------------------------------------------------------
% uniqueToys(Solution) - returns true if the toys are uique. "T" is the toy
% followed by the index of the toy.
% FORMAT: [reindeer, elf, toys, area]

uniqueToys([[_,_,T1,_],[_,_,T2,_],[_,_,T3,_],[_,_,T4,_],
[_,_,T5,_],[_,_,T6,_]]):-
    noDuplicates([T1,T2,T3,T4,T5,T6]).

%------------------------------------------------------------------------------
% uniqueAreas(Solution) - returns true if the areas are uique.
% FORMAT: [reindeer, elf, toys, area]

uniqueAreas([[_,_,_,A1],[_,_,_,A2],[_,_,_,A3],[_,_,_,A4],[_,_,_,A5],
[_,_,_,A6]]):-
    noDuplicates([A1,A2,A3,A4,A5,A6]).

%------------------------------------------------------------------------------


%==============================================================================
%                              RUN
% in here you will find the function to start the execution of program
% the priting format as the logical sequence of our rules (which is
% explained bellow)
%==============================================================================

%------------------------------------------------------------------------------
%solve :- No inputs. intiates the run of our program by printing the begining
% of our table followed by calling run(Solution), which will give the
% output of Solutions based on the rules above.
%
solve:-
    write('Area     Reindeer   Elf                    Toys'),nl,
    write('-----    ---------  -------------     ---------'),nl,
    run(Solution),
    showResult(Solution, 1).

%------------------------------------------------------------------------------
%run(Solution) - returns the solutions based on all the constraints of the rules
run(Solution):-
  solutions(Solution),
  rule8(Solution),
  distributionToys(Solution),
  uniqueToys(Solution),
  rule7(Solution),
  rule4(Solution),
  rule5(Solution),
  distributionAreas(Solution),
  uniqueAreas(Solution),
  rule3(Solution),
  rule6(Solution),
  rule1(Solution),
  rule2(Solution).

%======================================================================
% showResult(Solution, Area)- formats the result gained.
% FORMAT: [reindeer, elf, toys, area]
showResult(Solution, Area):-
    member([Rein, Elf, NumToys, Area], Solution),
    writef('%8l %10l %20l %5r ', [Area, Rein, Elf, NumToys]),nl,
    NewArea is Area + 1,
    showResult(Solution, NewArea).
showResult(_,7).

% END OF PROGRAM
%==============================================================================
% Small notes:
% We are happy to announce that our prgram runs in less than 5 seconds!!
% The reason behind that is that we first distribute the areas and toys then
% call our unique elements to reduce the amount of possibilities the rules
% will be constraining. Furthemore, as you saw in our program we also tried
% to find patterns. For instance, we are doing more facts other than
% arithemetic operations.

% In our solution we also decided to use reindeers instead of areas because
% these are more referenced within the rules.

% Finally, the key to get a lower run time was our ordering. We started
% by having the rules that constrain the most being at the top. In other words,
% if you look at Toys, they are used pretty much in every single rule, so it
% logically makes sense to constraint them first to have a smoother transition
% as we go in the lower rules. You will also notice that the rules that do not
% need to be constraints are put before distribution of toys (because they are
% not using either toys or areas). So putting them there, actually increase our
% run time.
%

% Thank you Rosanna! This is really sad that it is the last course we are taking
% with you! :(( We have EXTREMLY enjoyed this course (although we have our
% reservation in Prolog). But we have taken a lot of information from this
% have became better programmers (at least we would like to think so!)

%  To Run on Mac
%  consult('/Users/arnoldgihozo/Documents/GitHub/SantasHelper/santahelper.pl').
