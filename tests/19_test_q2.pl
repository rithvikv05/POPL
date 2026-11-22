:- use_module(library(plunit)).
:- use_module(library(lists), [member/2]).

% Load the implementation from ../code regardless of the current directory.
:- prolog_load_context(directory, TestDir),
   directory_file_path(TestDir, '../code/19_q2.pl', ImplFile),
   absolute_file_name(ImplFile, ImplPath),
   ensure_loaded(ImplPath).

:- begin_tests(q2).

test(empty_list_has_no_equation) :-
    \+ generate_equation([], _),
    all_equations([], []),
    count_equations([], 0).

test(single_number_has_no_equation) :-
    \+ generate_equation([7], _),
    all_equations([7], []),
    count_equations([7], 0).

test(generate_equation_returns_a_string) :-
    generate_equation([1, 1], Equation),
    string(Equation),
    Equation == "1=1".

test(all_equations_for_equal_pair) :-
    all_equations([1, 1], ["1=1"]).

test(unequal_pair_has_no_equation, [fail]) :-
    generate_equation([1, 2], _).

test(exact_division_is_allowed) :-
    apply_op('/', 8, 4, 2).

test(non_exact_division_is_rejected, [fail]) :-
    apply_op('/', 5, 2, _).

test(division_by_zero_is_rejected, [fail]) :-
    apply_op('/', 1, 0, _).

test(all_equations_with_division) :-
    all_equations([8, 4, 2], ["8/4=2", "8=4*2"]).

test(division_by_zero_never_appears) :-
    all_equations([1, 0, 1], Equations),
    member("1=0+1", Equations),
    member("1+0=1", Equations),
    member("1-0=1", Equations),
    \+ member("1/0=1", Equations).

test(no_solution_for_five_two_two) :-
    all_equations([5, 2, 2], []),
    count_equations([5, 2, 2], 0).

test(negative_intermediate_values_are_supported) :-
    all_equations([3, 5, 2, 4], Equations),
    member("3-5=2-4", Equations).

test(all_equations_are_sorted_and_unique) :-
    all_equations([3, 5, 2, 4], Equations),
    sort(Equations, Equations),
    length(Equations, 5).

test(count_matches_list_length) :-
    all_equations([3, 5, 2, 4], Equations),
    count_equations([3, 5, 2, 4], N),
    length(Equations, N).

test(canonical_precedence_and_associativity) :-
    expr_to_string(op('*', op('+', num(4), num(2)), num(3)), "(4+2)*3"),
    expr_to_string(op('+', num(4), op('*', num(2), num(3))), "4+2*3"),
    expr_to_string(op('*', op('/', num(8), num(4)), num(2)), "8/4*2"),
    expr_to_string(op('/', num(8), op('*', num(4), num(2))), "8/(4*2)"),
    expr_to_string(op('-', op('-', num(1), num(2)), num(3)), "1-2-3"),
    expr_to_string(op('-', num(1), op('-', num(2), num(3))), "1-(2-3)").

test(equal_precedence_right_child_gets_parentheses) :-
    expr_to_string(op('+', num(1), op('+', num(2), num(3))), "1+(2+3)"),
    expr_to_string(op('+', op('+', num(1), num(2)), num(3)), "1+2+3").

:- end_tests(q2).
