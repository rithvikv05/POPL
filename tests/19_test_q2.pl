:- ensure_loaded('id_q2.pl').

run_tests :-
    \+ generate_equation([], _),
    all_equations([], []),
    count_equations([], 0),
    \+ generate_equation([5], _),
    all_equations([5], []),
    count_equations([5], 0),

    generate_equation([1, 1], Eq),
    string(Eq),
    \+ atom(Eq),

    apply_op(\/, 8, 4, 2),
    \+ apply_op(\/, 5, 2, _),
    \+ apply_op(\/, 1, 0, _),
    all_equations([8, 4, 2], DivisionEquations),
    member("8/4=2", DivisionEquations),
    all_equations([1, 0, 1], ZeroEquations),
    member("1=0+1", ZeroEquations),
    \+ member("1/0=1", ZeroEquations),
    all_equations([5, 2, 2], []),

    all_equations([3, 5, 2, 4], NegativeEquations),
    member("3-5=2-4", NegativeEquations),
    sort(NegativeEquations, NegativeEquations),

    % Check precedence and both associativity cases against the specified strings.
    expr_to_string(op(*, op(+, num(4), num(2)), num(3)), "(4+2)*3"),
    expr_to_string(op(+, num(4), op(*, num(2), num(3))), "4+2*3"),
    expr_to_string(op(*, op(\/, num(8), num(4)), num(2)), "8/4*2"),
    expr_to_string(op(\/, num(8), op(*, num(4), num(2))), "8/(4*2)"),
    expr_to_string(op(-, op(-, num(1), num(2)), num(3)), "1-2-3"),
    expr_to_string(op(-, num(1), op(-, num(2), num(3))), "1-(2-3)"),
    expr_to_string(op(+, num(1), op(+, num(2), num(3))), Nested),
    Nested = "1+(2+3)",
    expr_to_string(op(+, op(+, num(1), num(2)), num(3)), Flat),
    Flat = "1+2+3",
    Nested \= Flat.
