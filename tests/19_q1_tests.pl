% Automated tests for the Department Assignment Puzzle (P1).
% Keep this file in the same directory as id_q1.pl.
%
% Run from PowerShell (from the POPL directory):
%   swipl -q -s .\code\id_q1_tests.pl -g run_tests -t halt

:- begin_tests(department_assignment).

% Load the implementation from the same directory as this test file.
:- prolog_load_context(directory, TestDir),
   directory_file_path(TestDir, '../code/19_q1.pl', ImplementationFile),
   ensure_loaded(ImplementationFile).

test(count_for_clues_1_to_8, [true(N =:= 3)]) :-
    count_solutions([1,2,3,4,5,6,7,8], N).

test(count_after_clue_9, [true(N =:= 1)]) :-
    count_solutions([1,2,3,4,5,6,7,8,9], N).

test(each_solution_has_four_friends) :-
    solve_active([1,2,3,4,5,6,7,8], Solution),
    length(Solution, 4),
    Solution = [p('Alex',_,_,_),
                p('Ben',_,_,_),
                p('Carla',_,_,_),
                p('Dana',_,_,_)].

test(attributes_are_used_exactly_once) :-
    solve_active([1,2,3,4,5,6,7,8], Solution),
    findall(Dept, member(p(_,Dept,_,_), Solution), Depts),
    findall(Lang, member(p(_,_,Lang,_), Solution), Langs),
    findall(Project, member(p(_,_,_,Project), Solution), Projects),
    sort(Depts, [design,development,research,testing]),
    sort(Langs, ['c++',java,javascript,python]),
    sort(Projects, ['AI',data,embedded,web]).

test(clue_9_places_ai_in_testing) :-
    solve_active([1,2,3,4,5,6,7,8,9], Solution),
    member(p(_,testing,_, 'AI'), Solution).

test(clue_9_result_is_unique) :-
    findall(Solution,
            solve_active([1,2,3,4,5,6,7,8,9], Solution),
            [OnlySolution]),
    OnlySolution = [
        p('Alex', design, java, embedded),
        p('Ben', development, javascript, web),
        p('Carla', testing, python, 'AI'),
        p('Dana', research, 'c++', data)
    ].

:- end_tests(department_assignment).
