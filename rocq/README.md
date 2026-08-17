# Rocq adequacy tests

These files are deliberately small tests of whether Rocq can express and verify mathematical translations relevant to this repository.

- `Lawvere.v` formalizes the core **Unity and Identity (UI)** structure from Lawvere's 1996 paper. A general UI whose two composites are isomorphisms is normalized to a cylinder: one map with two sections, hence a common retraction. It proves the induced idempotent equations and a finite product example.
- `Morava.v` formalizes the finite quaternion calculation from Jack Morava's 2003 *On the canonical formula of C. Levi-Strauss*. It proves the Q8 group laws, noncommutativity, bijectivity and multiplication reversal of Morava's anti-automorphism, and its required action on `x,a,y,b`.
- `LeviStraussCases.v` adds regression fixtures from myths Levi-Strauss actually analyzed:
  - the Oedipus mytheme table from *The Structural Study of Myth*, including negative tests that prevent all killings from being collapsed into one class;
  - the Boas-1912 version of Asdiwal used by Levi-Strauss, with the explicit downstream/upstream, earth/heaven, mountain-hunting/sea-hunting, killer/healer, westward/eastward and mobility/petrification reversals;
  - the Jivaro/goatsucker-nightjar/woman/potter case from *The Jealous Potter*, where the concrete labels are checked against Morava's quaternion anti-automorphism.

The source boundary matters. Story events are treated as fixtures; Levi-Strauss's grouping of those events is an explicit analytic input; the Q8 encoding is Morava's proposed mathematical interpretation. Rocq checks consequences and compatibility of those inputs. It does **not** prove that the grouping is uniquely forced by the stories or anthropologically correct.

Useful primary/near-primary references for the fixtures are Claude Levi-Strauss, *The Structural Study of Myth* (1955), *The Story of Asdiwal* (English version in Edmund Leach, ed., *The Structural Study of Myth and Totemism*, 1967), and *The Jealous Potter* (1988), plus Jack Morava, *On the canonical formula of C. Levi-Strauss* (2003).

Run:

```sh
make -C rocq check
```

which invokes `rocq compile` on all three Rocq developments.
