---
name: scheme-dev
description: Guidelines for developing and testing Scheme solutions
for CS F301 Assignment 2 using Racket 8.x.
---

# Scheme Development Guidelines

## Language and Environment
- Use Racket 8.x.
- Every file must start with #lang racket/base.
- Use only the built-ins permitted by the assignment.

## Coding Conventions
- Use descriptive function names.
- Use hyphens in multiword function names.
- Prefer recursive and functional implementations.
- Avoid mutable state.
- Pass state through function arguments.
- Use helper functions to simplify complex logic.

## Development Guidelines
- Use recursion for list and tree processing.
- Use lambda for anonymous functions.
- Understand lexical scoping and closures.
- Use higher-order functions where appropriate.
- Do not use prohibited built-ins.
- Do not use set!, loops, vectors or hash tables.

## Testing
- Test every function independently.
- Test empty lists and boundary cases.
- Test deeply nested structures.
- Test all examples provided in the assignment.
- Ensure files contain definitions only.

## Common AI Mistakes
- Using prohibited built-in functions.
- Incorrect handling of empty lists.
- Incorrect recursion termination.
- Accidentally modifying input data.
- Incorrect handling of nested lists.
- Using mutation instead of functional programming.

## Self-Review Checklist
- Does the code use only permitted built-ins?
- Is recursion implemented correctly?
- Are empty lists handled?
- Is the solution free of mutation?
- Does it pass the provided examples?
- Does loading the file produce no output?