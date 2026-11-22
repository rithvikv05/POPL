# Principles of Programming Languages Assignment 2

## P1: Commands
#### P1.a
> swipl -q -f .\code\id_q1.pl -g main -t halt

#### P1.b
> swipl -q -f .\code\id_q1.pl -g run_tests -t halt

#### P1.c
> swipl -q -f .\code\id_q1.pl -g run_clue9_test -t halt

#### P1 Tests
> swipl -q -s .\test\id_q1_tests.pl -g run_tests -t halt

## P2: Commands

#### P2.a
> swipl -q -s .\code\id_q2.pl -g "generate_equation([1,1],E),writeln(E)" -t halt

#### P2.b
> swipl -q -s .\code\id_q2.pl -g "all_equations([8,4,2],Es),writeln(Es)" -t halt

#### P2.c
> swipl -q -s .\code\id_q2.pl -g "count_equations([3,5,2,4],N),writeln(N)" -t halt

#### P2 Tests
> swipl -q -s .\test\id_q2_tests.pl -g run_tests -t halt

## S1: Commands

> racket .\code\19_q3.rkt

> Get-Content .\code\19_q3.rkt | Set-Content .\tests\q3_run.rkt

> Get-Content .\tests\19_test_q3.rkt | Select-Object -Skip 1 | Add-Content .\tests\q3_run.rkt

> Add-Content .\tests\q3_run.rkt "`n(run-q3-tests)"

> racket .\tests\q3_run.rkt

## S2: Commands

> racket .\code\19_q4.rkt

> Get-Content .\code\19_q4.rkt | Set-Content .\tests\q4_run.rkt

> Get-Content .\tests\19_test_q4.rkt | Select-Object -Skip 1 | Add-Content .\tests\q4_run.rkt

> Add-Content .\tests\q4_run.rkt "`n(run-q4-tests)"

> racket .\tests\q4_run.rkt
