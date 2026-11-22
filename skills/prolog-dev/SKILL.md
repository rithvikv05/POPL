---
name: prolog-dev
description: Guidelines for developing and testing Prolog solutions
for CS F301 Assignment 2 using SWI-Prolog 9.x.
---

# Prolog Development Guidelines

## Language and Environment
- Use SWI-Prolog 9.x.
- Follow standard Prolog syntax.
- Use only libraries permitted by the assignment.

## Coding Conventions
- Use descriptive predicate names.
- Use lowercase names for predicates and variables.
- Keep predicates modular.
- Implement each clue or logical constraint separately.
- Prefer declarative solutions over procedural workarounds.
- Add comments explaining important logic.

## Development Guidelines
- Break problems into smaller predicates.
- Use recursion and backtracking appropriately.
- Avoid hardcoding solutions.
- Avoid assert, retract and global variables.
- Do not print anything unless explicitly required.

## Testing
- Test individual predicates independently.
- Test all examples in the assignment.
- Test edge cases.
- Run files using the commands specified in the assignment.

## Common AI Mistakes
- Incorrect variable instantiation.
- Unintended infinite recursion.
- Incorrect use of unification and arithmetic evaluation.
- Duplicate solutions.
- Incorrect handling of backtracking.
- Hardcoding outputs instead of deriving solutions.

## Self-Review Checklist
- Does every predicate satisfy its specification?
- Are all assignment restrictions followed?
- Does the solution handle edge cases?
- Are there unintended choice points or duplicate results?
- Does the program produce exactly the required output?