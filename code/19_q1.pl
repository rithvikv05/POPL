:- use_module(library(lists), [permutation/2, member/2, memberchk/2]).

% Generate a complete assignment.  Each attribute value is used exactly once.
candidate_solution(Solution) :-
    permutation([research, development, design, testing],
                [AlexDept, BenDept, CarlaDept, DanaDept]),
    permutation([python, java, 'c++', javascript],
                [AlexLang, BenLang, CarlaLang, DanaLang]),
    permutation(['AI', web, embedded, data],
                [AlexProject, BenProject, CarlaProject, DanaProject]),
    Solution = [
        p('Alex', AlexDept, AlexLang, AlexProject),
        p('Ben', BenDept, BenLang, BenProject),
        p('Carla', CarlaDept, CarlaLang, CarlaProject),
        p('Dana', DanaDept, DanaLang, DanaProject)
    ].

% Clue 1: The AI-project friend is not in research and is not Dana.
clue(1, Solution) :-
    member(p(Name, Dept, _, 'AI'), Solution),
    Name \== 'Dana',
    Dept \== research.

% Clue 2: Alex is not in development and does not prefer C++.
clue(2, Solution) :-
    member(p('Alex', Dept, Lang, _), Solution),
    Dept \== development,
    Lang \== 'c++'.

% Clue 3: The friend in testing likes Python.
clue(3, Solution) :-
    member(p(_, testing, python, _), Solution).

% Clue 4: Ben prefers web projects and is not in testing.
clue(4, Solution) :-
    member(p('Ben', Dept, _, web), Solution),
    Dept \== testing.

% Clue 5: The friend who likes Java works in design.
clue(5, Solution) :-
    member(p(_, design, java, _), Solution).

% Clue 6: Carla does not prefer embedded and is not in development.
clue(6, Solution) :-
    member(p('Carla', Dept, _, Project), Solution),
    Project \== embedded,
    Dept \== development.

% Clue 7: Dana does not like Java and works in research or testing.
clue(7, Solution) :-
    member(p('Dana', Dept, Lang, _), Solution),
    Lang \== java,
    memberchk(Dept, [research, testing]).

% Clue 8: The data-project friend works in research and does not use JavaScript.
clue(8, Solution) :-
    member(p(_, research, Lang, data), Solution),
    Lang \== javascript.

% CLUE 9: The friend working in testing prefers the AI project.
clue(9, Solution) :-
    member(p(_, testing, _, 'AI'), Solution).

% Check every clue number in Active against the same complete assignment.
satisfies_clues([], _Solution).
satisfies_clues([N | Rest], Solution) :-
    clue(N, Solution),
    satisfies_clues(Rest, Solution).

solve_active(Active, Solution) :-
    candidate_solution(Solution),
    satisfies_clues(Active, Solution).

% Count assignments satisfying exactly the requested active clues.
count_solutions(Active, N) :-
    findall(Solution, solve_active(Active, Solution), Solutions),
    length(Solutions, N).

% Print the four friends in the required order and format.
print_solution([
    p('Alex', D1, L1, P1),
    p('Ben', D2, L2, P2),
    p('Carla', D3, L3, P3),
    p('Dana', D4, L4, P4)
]) :-
    format('Alex = [~w, ~w, ~w]~n', [D1, L1, P1]),
    format('Ben = [~w, ~w, ~w]~n', [D2, L2, P2]),
    format('Carla = [~w, ~w, ~w]~n', [D3, L3, P3]),
    format('Dana = [~w, ~w, ~w]~n', [D4, L4, P4]).

% P1.a: print one assignment satisfying clues 1 through 8.
main :-
    once(solve_active([1,2,3,4,5,6,7,8], Solution)),
    print_solution(Solution).

% P1.b: count and display the assignments satisfying clues 1 through 8.
run_tests :-
    Active = [1,2,3,4,5,6,7,8],
    count_solutions(Active, N),
    format('Number of solutions for clues 1-8: ~w~n', [N]),
    forall(solve_active(Active, Solution), print_solution(Solution)).

% P1.c: check that clue 9 reduces the count to one.
run_clue9_test :-
    count_solutions([1,2,3,4,5,6,7,8,9], N),
    format('Number of solutions for clues 1-9: ~w~n', [N]).
