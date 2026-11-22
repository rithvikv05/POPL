# P1 Report: Department Assignment Puzzle

Using `count_solutions([1,2,3,4,5,6,7,8], N)`, the result is **N = 3**.

This means clues 1–8 do not determine a unique assignment: there are three complete assignments that satisfy all eight clues. The additional clue 9 in `19_q1.pl` “The friend working in testing prefers the AI project.” selects exactly one of those assignments, so `count_solutions([1,2,3,4,5,6,7,8,9], N)` returns **N = 1**.
