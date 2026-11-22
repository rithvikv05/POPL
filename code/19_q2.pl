split_nonempty(List, Left, Right) :-
    Left = [_|_],
    Right = [_|_],
    append(Left, Right, List).

apply_op(+, V1, V2, Val) :-
    Val is V1 + V2.
apply_op(-, V1, V2, Val) :-
    Val is V1 - V2.
apply_op(*, V1, V2, Val) :-
    Val is V1 * V2.
apply_op(\/, V1, V2, Val) :-
    V2 =\= 0,
    0 =:= V1 rem V2,
    Val is V1 // V2.

build_expr([N], num(N), N).
build_expr(List, op(Op, LeftExpr, RightExpr), Val) :-
    split_nonempty(List, LeftList, RightList),
    build_expr(LeftList, LeftExpr, LeftVal),
    build_expr(RightList, RightExpr, RightVal),
    apply_op(Op, LeftVal, RightVal, Val).

op_prec(+, 1).
op_prec(-, 1).
op_prec(*, 2).
op_prec(\/, 2).

needs_parens(left, ParentOp, op(ChildOp, _, _)) :-
    op_prec(ParentOp, ParentPrec),
    op_prec(ChildOp, ChildPrec),
    ChildPrec < ParentPrec.
needs_parens(right, ParentOp, op(ChildOp, _, _)) :-
    op_prec(ParentOp, ParentPrec),
    op_prec(ChildOp, ChildPrec),
    ChildPrec =< ParentPrec.

expr_to_string(num(N), Str) :-
    number_string(N, Str).
expr_to_string(op(Op, Left, Right), Str) :-
    expr_to_string(Left, LeftStr),
    expr_to_string(Right, RightStr),
    (   needs_parens(left, Op, Left)
    ->  format(string(LeftWrapped), '(~s)', [LeftStr])
    ;   LeftWrapped = LeftStr
    ),
    (   needs_parens(right, Op, Right)
    ->  format(string(RightWrapped), '(~s)', [RightStr])
    ;   RightWrapped = RightStr
    ),
    format(string(Str), '~s~w~s', [LeftWrapped, Op, RightWrapped]).

generate_equation(List, Equation) :-
    split_nonempty(List, LeftList, RightList),
    build_expr(LeftList, LeftExpr, Val),
    build_expr(RightList, RightExpr, Val),
    expr_to_string(LeftExpr, LeftStr),
    expr_to_string(RightExpr, RightStr),
    format(string(Equation), '~s=~s', [LeftStr, RightStr]).

all_equations(List, Equations) :-
    findall(Eq, generate_equation(List, Eq), All),
    sort(All, Equations).

count_equations(List, N) :-
    all_equations(List, Equations),
    length(Equations, N).
