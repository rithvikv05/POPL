/*
 * P2: Form a Valid Arithmetic Equation
 *
 * generate_equation(+List, -Equation)
 *   Nondeterministically generates one valid equation as a Prolog string.
 *
 * all_equations(+List, -Equations)
 *   Returns every distinct valid equation, sorted using sort/2.
 *
 * count_equations(+List, -N)
 *   Returns the number of distinct valid equations.
 */

:- use_module(library(lists), [append/3]).

% Split a list into two non-empty contiguous parts, preserving order.
split_nonempty(List, Left, Right) :-
    Left = [_|_],
    Right = [_|_],
    append(Left, Right, List).

% Apply one permitted binary operator.
apply_op('+', V1, V2, Val) :-
    Val is V1 + V2.
apply_op('-', V1, V2, Val) :-
    Val is V1 - V2.
apply_op('*', V1, V2, Val) :-
    Val is V1 * V2.
apply_op('/', V1, V2, Val) :-
    V2 =\= 0,
    0 =:= V1 rem V2,
    Val is V1 // V2.

% A one-number expression is a leaf. Otherwise, recursively combine
% two non-empty contiguous subexpressions with one binary operator.
build_expr([N], num(N), N).
build_expr(List, op(Op, LeftExpr, RightExpr), Val) :-
    split_nonempty(List, LeftList, RightList),
    build_expr(LeftList, LeftExpr, LeftVal),
    build_expr(RightList, RightExpr, RightVal),
    apply_op(Op, LeftVal, RightVal, Val).

% Operator precedence specified in the assignment.
op_prec('+', 1).
op_prec('-', 1).
op_prec('*', 2).
op_prec('/', 2).

% Canonical parentheses rules:
% - A left child needs parentheses only when it has lower precedence.
% - A right child needs parentheses when it has equal or lower precedence.
needs_parens(left, ParentOp, op(ChildOp, _, _)) :-
    op_prec(ParentOp, ParentPrec),
    op_prec(ChildOp, ChildPrec),
    ChildPrec < ParentPrec.
needs_parens(right, ParentOp, op(ChildOp, _, _)) :-
    op_prec(ParentOp, ParentPrec),
    op_prec(ChildOp, ChildPrec),
    ChildPrec =< ParentPrec.

% Convert an expression tree to its canonical string representation.
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
    format(string(Str), '~s~a~s', [LeftWrapped, Op, RightWrapped]).

% Choose the position of the single '=', build both sides, and require
% their evaluated integer values to be identical.
generate_equation(List, Equation) :-
    split_nonempty(List, LeftList, RightList),
    build_expr(LeftList, LeftExpr, Value),
    build_expr(RightList, RightExpr, Value),
    expr_to_string(LeftExpr, LeftStr),
    expr_to_string(RightExpr, RightStr),
    format(string(Equation), '~s=~s', [LeftStr, RightStr]).

% Collect all results, remove duplicate strings, and sort them.
all_equations(List, Equations) :-
    findall(Equation, generate_equation(List, Equation), All),
    sort(All, Equations).

% Count the distinct valid equations.
count_equations(List, N) :-
    all_equations(List, Equations),
    length(Equations, N).
