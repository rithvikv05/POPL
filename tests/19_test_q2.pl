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
    once(generate_equation([1, 1], Equation)),
    string(Equation),
    \+ atom(Equation),
    \+ is_list(Equation),
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
    memberchk("1=0+1", Equations),
    memberchk("1+0=1", Equations),
    memberchk("1-0=1", Equations),
    \+ memberchk("1/0=1", Equations).

test(no_solution_for_five_two_two) :-
    all_equations([5, 2, 2], []),
    count_equations([5, 2, 2], 0).

test(negative_intermediate_values_are_supported) :-
    all_equations([3, 5, 2, 4], Equations),
    memberchk("3-5=2-4", Equations).

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


% Exact document list examples (including the complete seven-equation set).
test(document_four_two_five_three) :-
    all_equations([4,2,5,3], Expected),
    Expected == ["4*2-5=3", "4*2=5+3", "4-2=5-3", "4/2=5-3",
                 "4=2*(5-3)", "4=2+(5-3)", "4=2+5-3"],
    count_equations([4,2,5,3], 7),
    once(generate_equation([4,2,5,3], One)),
    memberchk(One, Expected).
test(document_no_solution_two_three_four) :-
    \+ generate_equation([2,3,4], _),
    all_equations([2,3,4], []),
    count_equations([2,3,4], 0).
test(document_two_four_eight) :-
    once(generate_equation([2,4,8], "2*4=8")),
    all_equations([2,4,8], ["2*4=8"]),
    count_equations([2,4,8], 1).

% Custom: zero, repeated values, multi-digit inputs and arithmetic corner cases.
test(zero_pair) :- all_equations([0,0], ["0=0"]).
test(zero_triple_all_trees) :-
    all_equations([0,0,0], ["0*0=0","0+0=0","0-0=0",
                           "0=0*0","0=0+0","0=0-0"]),
    count_equations([0,0,0], 6).
test(multi_digit_numbers_are_not_split) :-
    all_equations([12,3,4], ["12/3=4","12=3*4"]).
test(numbers_are_not_concatenated) :- all_equations([1,2,12], []).
test(negative_exact_division) :-
    apply_op('/', -6, 3, -2),
    apply_op('/', 6, -3, -2),
    apply_op('/', -6, -3, 2).
test(negative_inexact_division, [fail]) :- apply_op('/', -5, 2, _).
test(zero_divided_by_nonzero) :- apply_op('/', 0, 3, 0).
test(zero_divided_by_zero, [fail]) :- apply_op('/', 0, 0, _).
test(fractional_inner_division_is_rejected, [fail]) :-
    build_expr([5,2,2], op('*',op('/',num(5),num(2)),num(2)), _).
test(computed_zero_divisor_is_rejected, [fail]) :-
    build_expr([4,2,2], op('/',num(4),op('-',num(2),num(2))), _).
test(negative_inner_value_can_be_divided_exactly) :-
    once(build_expr([1,5,2], op('/',op('-',num(1),num(5)),num(2)), -2)).
test(different_association_trees_are_retained) :-
    all_equations([1,2,3,6], Es),
    memberchk("1+(2+3)=6", Es),
    memberchk("1+2+3=6", Es),
    sort(Es, Es),
    length(Es, N), count_equations([1,2,3,6], N).
test(all_generated_values_are_strings) :-
    all_equations([0,1,1,2], Es),
    Es = [_|_],
    forall(member(E, Es), (string(E), \+ atom(E), \+ is_list(E))).

:- end_tests(q2).
