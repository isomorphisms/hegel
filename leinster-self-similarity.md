# Leinster on general self-similarity

This note is deliberately exploratory. It records a possible mathematical connection to the Hegel project without treating Tom Leinster's theory of self-similarity as a formalization of Hegel.

## The papers

In 2004 Leinster posted three closely related preprints:

- [General self-similarity: an overview](https://arxiv.org/abs/math/0411343)
- [A general theory of self-similarity I](https://arxiv.org/abs/math/0411344)
- [A general theory of self-similarity II: recognition](https://arxiv.org/abs/math/0411345)

The two numbered papers were later superseded by the consolidated paper [A general theory of self-similarity](https://arxiv.org/abs/1010.4474).

## What is potentially relevant

Leinster studies systems in which several objects are specified simultaneously through equations describing how each is assembled from copies or pieces of the others. The important point for this project is not fractals as such. It is the possibility of giving a precise mathematical account of **mutual recursive constitution**: an object can be characterized through a whole system of relations rather than by attaching an independent list of predicates to it.

Schematically, one can have equations of the form

```text
X = construction involving X and Y
Y = construction involving X and Y
```

and then ask whether the entire system has a distinguished or universal solution.

That could become useful if the Hegel project eventually needs to represent structures whose parts are intelligible only through their relations to one another, or patterns in which a local relational organization reproduces some organization of a larger system.

## What is *not* supplied by Leinster

Self-similarity is not, by itself, dialectics.

Leinster's machinery does not intrinsically provide:

- negation;
- opposition;
- contradiction;
- determinate negation;
- preservation-through-cancellation;
- Aufhebung.

This is not a minor omission. Leinster's notion is broad enough that arbitrary compact metrizable spaces can occur as self-similar spaces in the theory. So the bare property of being self-similar cannot reasonably serve as a mathematical criterion for being Hegelian.

The tempting slogan

> self-similarity = Hegel

should therefore be rejected.

## Relation to Lawvere

Lawvere remains much more directly relevant to the present formalization effort because the proposed categorical structures explicitly concern unity or identity of opposites and Aufhebung. Leinster instead supplies possible auxiliary mathematics for recursive systems of mutually dependent objects.

A useful provisional ranking is therefore:

1. **Lawvere: directly relevant to the formalization target.**
2. **Leinster: potentially useful auxiliary machinery.**
3. **Generic self-similarity as a model of Hegel: not justified.**

The cleanest possible future use of Leinster would be to borrow the mathematics for the **recursive/system-of-equations** part of some model while obtaining any genuinely dialectical structure—negation, opposition, transformation—from somewhere else and making that extra structure explicit.

## Status

Keep this idea separate until an actual construction needs it. Its value would have to be demonstrated by a model or proof obligation that is awkward without Leinster-style machinery. Similarity of vocabulary is not enough.
