# Principles of Programming Languages

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