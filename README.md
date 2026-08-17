# Hegel

This project formalizes and verifies a finite categorical model of Lawvere’s proposed identity and unity of opposites. It does not claim to formalize Hegel’s philosophy as a whole or establish a unique interpretation of Hegel.

## What this is

This project explores a finite category in which:

- objects represent coarse states or positions;
- morphisms represent admissible transitions;
- composition records how transitions combine;
- identities represent persistence of a state through a transition.

The model is intentionally small and explicit. Its purpose is to make one categorical proposal precise enough that its definitions and consequences can be checked rather than left at the level of analogy.

The question is narrow:

> What, if anything, can a categorical structure make visible about the relation between identity and difference?

## A finite model

Start with finite objects, for example

```text
A = {0, 1}
B = {0, 1}
```

and consider functions between them as morphisms. Because the model is finite, the relevant structure can be enumerated and its laws checked exhaustively.

The point of using a finite model is not that Hegelian concepts are finite. It is that a finite model gives us a place where every object, morphism, composition, identity, and claimed relation can be displayed and verified.

## What is being verified

The project aims to separate three things that are easy to blur together:

1. the ordinary category laws;
2. the additional finite structure chosen to represent identity and opposition;
3. the specific claim that this structure realizes the proposed identity and unity of opposites.

A successful formalization should make those assumptions visible and make counterexamples visible too.

## Scope

This is a mathematical formalization of one proposed categorical model. It is not a proof that category theory is the correct language for Hegel, not a reconstruction of Hegel’s system, and not a claim that the interpretation implemented here is uniquely determined by Hegel’s texts.

The intended standard is therefore modest but strict: define the model precisely, verify the properties actually claimed for it, and distinguish the mathematics from the philosophical interpretation placed on that mathematics.
