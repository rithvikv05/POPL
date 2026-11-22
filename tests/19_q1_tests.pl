% P1: specification behavior plus custom edge cases.
% Run from repository root:
% swipl -q -s tests/19_q1_tests.pl -g run_tests -t halt
:- use_module(library(plunit)).
:- begin_tests(department_assignment).
:- prolog_load_context(directory, TestDir),
   directory_file_path(TestDir, '../code/19_q1.pl', ImplementationFile),
   ensure_loaded(ImplementationFile).

% The PDF's assignment is FORMAT ONLY, not a valid puzzle answer.
test(document_format_example) :-
    with_output_to(string(Text), print_solution([
        p('Alex',research,python,'AI'),
        p('Ben',development,java,web),
        p('Carla',design,'c++',embedded),
        p('Dana',testing,javascript,data)])),
    Text == "Alex = [research, python, AI]\nBen = [development, java, web]\nCarla = [design, c++, embedded]\nDana = [testing, javascript, data]\n".

test(count_for_clues_1_to_8, [true(N =:= 3)]) :-
    count_solutions([1,2,3,4,5,6,7,8], N).
test(count_after_clue_9, [true(N =:= 1)]) :-
    count_solutions([1,2,3,4,5,6,7,8,9], N).

% Custom: no active clues, an isolated clue, reordered and repeated clues.
test(no_active_clues, [true(N =:= 13824)]) :- count_solutions([], N).
test(only_clue_3, [true(N =:= 3456)]) :- count_solutions([3], N).
test(reordered_active_clues, [true(N =:= 3)]) :-
    count_solutions([8,7,6,5,4,3,2,1], N).
test(repeated_clue_does_not_duplicate_solutions, [true(N =:= 3)]) :-
    count_solutions([1,2,3,4,5,6,7,8,3], N).

test(every_solution_has_four_ordered_friends) :-
    forall(solve_active([1,2,3,4,5,6,7,8], S),
        S = [p('Alex',_,_,_),p('Ben',_,_,_),
             p('Carla',_,_,_),p('Dana',_,_,_)]).
test(every_solution_uses_each_attribute_once) :-
    forall(solve_active([1,2,3,4,5,6,7,8], S),
        (findall(D, member(p(_,D,_,_), S), Ds),
         findall(L, member(p(_,_,L,_), S), Ls),
         findall(P, member(p(_,_,_,P), S), Ps),
         msort(Ds, [design,development,research,testing]),
         msort(Ls, ['c++',java,javascript,python]),
         msort(Ps, ['AI',data,embedded,web]))).

% Independent ground checks of the English clues on every generated solution.
test(every_solution_satisfies_all_eight_english_clues) :-
    forall(solve_active([1,2,3,4,5,6,7,8], S),
        (memberchk(p(AIName,AIDept,_,'AI'), S),
         AIName \== 'Dana', AIDept \== research,
         memberchk(p('Alex',AD,AL,_), S), AD \== development, AL \== 'c++',
         memberchk(p(_,testing,python,_), S),
         memberchk(p('Ben',BD,_,web), S), BD \== testing,
         memberchk(p(_,design,java,_), S),
         memberchk(p('Carla',CD,_,CP), S), CD \== development, CP \== embedded,
         memberchk(p('Dana',DD,DL,_), S), DL \== java,
         memberchk(DD,[research,testing]),
         memberchk(p(_,research,DataLang,data), S), DataLang \== javascript)).

test(clue_9_filters_original_solutions_to_exactly_one) :-
    findall(S, (solve_active([1,2,3,4,5,6,7,8], S), clue(9,S)), Kept),
    Kept = [Only],
    memberchk(p(_,testing,_,'AI'), Only).
test(clue_9_result_is_unique) :-
    findall(S, solve_active([1,2,3,4,5,6,7,8,9],S),
        [[p('Alex',design,java,embedded),
          p('Ben',development,javascript,web),
          p('Carla',testing,python,'AI'),
          p('Dana',research,'c++',data)]]).
test(main_prints_exactly_one_valid_solution) :-
    with_output_to(string(Actual), main),
    findall(Expected,
        (solve_active([1,2,3,4,5,6,7,8], S),
         with_output_to(string(Expected), print_solution(S))), ValidOutputs),
    memberchk(Actual, ValidOutputs).
:- end_tests(department_assignment).
