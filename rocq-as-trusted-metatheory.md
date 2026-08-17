# Rocq as a trusted metatheory

The useful role for Rocq in this project is not to make Rocq "understand Hegel." It is to make the inferential layer explicit enough that we can tell exactly what follows from what.

A practical architecture is:

```text
conversation / text
        ↓
learned or vector model
        ↓
uncertain observations
        ↓
typed claims and relations
        ↓
Rocq inference + verification
        ↓
derived claims with inspectable premises
```

The learned model handles the part that theorem provers are bad at: recognizing that a person is talking about one thing because another thing is absent, wanted, feared, presupposed, or being avoided. Those outputs should remain observations or hypotheses, not magically become theorems.

Rocq begins once those hypotheses have been translated into a deliberately small vocabulary. For example, a first toy language might distinguish claims such as:

```text
Observed person fact
Seeks    person object
Lacks    person object
Avoids   person object
Implies  claim claim
```

The exact vocabulary should stay provisional. The important point is that the transition from one claim to another is no longer hidden inside an embedding or an LLM response.

## The central Rocq object

The core relation should be something like:

```text
derives : list Claim -> Claim -> Prop
```

Then an executable inference procedure can be written:

```text
infer : list Claim -> list Claim
```

and the first serious theorem is not a theorem about Hegel or psychology. It is a theorem about our own program:

```text
infer_sound :
  forall premises conclusion,
    In conclusion (infer premises) ->
    derives premises conclusion.
```

That gives the project a trusted boundary. A vector model may suggest premises. A human may add or reject premises. The executable engine may search for consequences. Rocq checks that every reported consequence is licensed by the rules we actually wrote down.

This is much more useful than asking a language model for an opaque psychological conclusion. The interesting question becomes inspectable: **which observations and which inference rules were required to reach this conclusion?**

## Relation to the finite Lawvere model

The finite categorical model in this repository is a good first formal object because it is small enough to enumerate and verify. Rocq can state the objects, morphisms, identities, composition, and whatever additional structure is being proposed as a model of identity or opposition, then prove only the claims that actually follow from those definitions.

That work and the inference engine should share a methodological rule: translation first, verification second.

## Morava as a methodological model

Morava's treatment of Lévi-Strauss suggests the right attitude toward formalization. Translate an unfamiliar or cross-disciplinary argument into a precise structure, then determine what is coherent, what is forced, what is optional, and what remains interpretive. Formalization should neither canonize the source nor debunk it by changing the subject.

For Hegel this matters especially. A Rocq development can prove that a formal system has a property. It cannot by itself prove that the formal system is the uniquely correct reading of Hegel, or that an empirical claim about human beings is true.

## Bowman and the philosophical side

Bowman's account of absolute negativity can supply questions and constraints for candidate formal models: does the model merely represent two opposed fixed terms, or can its notion of determination depend on a relation that transforms the terms themselves? Those are useful tests for a formalization. They should not be smuggled in as axioms and then announced as discoveries.

## Why Rocq rather than only a dependent programming language

A dependent language can represent many of the same structures, but Rocq makes the proof obligation the center of the project. For this repository that is an advantage. The goal is not merely to construct values with sophisticated types. It is to separate:

1. observations supplied by humans or learned models;
2. explicit formal assumptions;
3. executable inference;
4. proofs that the executable inference respects the formal rules;
5. philosophical or empirical interpretation of the result.

Eventually the executable part could be extracted and used by another program. Rocq would remain the place where the rules and the soundness of the inference engine are checked.

The modest claim is therefore strong enough: **Rocq can serve as the trusted metatheory for a system whose uncertain front end proposes claims about human situations and whose formal back end records exactly how conclusions follow from those claims.**
