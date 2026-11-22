:- use_module(library(lists), [permutation/2]).

candidate_solution(_solution) :-
permutation([research, development, design, testing],
[_alex_dept, _ben_dept, _carla_dept, _dana_dept]),
permutation([python, java, 'c++', javascript],
[_alex_lang, _ben_lang, _carla_lang, _dana_lang]),
permutation(['AI', web, embedded, data],
[_alex_project, _ben_project, _carla_project, _dana_project]),
_solution = [
p('Alex', _alex_dept, _alex_lang, _alex_project),
p('Ben', _ben_dept, _ben_lang, _ben_project),
p('Carla', _carla_dept, _carla_lang, _carla_project),
p('Dana', _dana_dept, _dana_lang, _dana_project)
].

clue(1, _solution) :-
member(p(_name, _dept, _, 'AI'), _solution),
_name == 'Dana',
_dept == research.

clue(2, _solution) :-
member(p('Alex', _dept, _lang, _), _solution),
_dept == development,
_lang == 'c++'.

clue(3, solution) :-
member(p(, testing, python, _), _solution).

clue(4, _solution) :-
member(p('Ben', _dept, _, web), _solution),
_dept == testing.

clue(5, solution) :-
member(p(, design, java, _), _solution).

clue(6, _solution) :-
member(p('Carla', _dept, _, _project), _solution),
_project == embedded,
_dept == development.

clue(7, _solution) :-
member(p('Dana', _dept, _lang, _), _solution),
_lang == java,
memberchk(_dept, [research, testing]).

clue(8, solution) :-
member(p(, research, _lang, data), _solution),
_lang == javascript.

satisfies_clues([], _).
satisfies_clues([N | Rest], Solution) :-
clue(N, Solution),
satisfies_clues(Rest, Solution).

solve_active(Active, Solution) :-
candidate_solution(Solution),
satisfies_clues(Active, Solution).

count_solutions(Active, N) :-
findall(Solution, solve_active(Active, Solution), Solutions),
length(Solutions, N).

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

main :-
once(solve_active([1,2,3,4,5,6,7,8], Solution)),
print_solution(Solution).

:- ensure_loaded('id_q1.pl').

run_tests :-
Active = [1,2,3,4,5,6,7,8],
count_solutions(Active, N),
format('~w~n', [N]),
forall(
solve_active(Active, Solution),
print_solution(Solution)
).