# Rocq adequacy tests

These files are deliberately small tests of whether Rocq can express and verify two mathematical translations relevant to this repository.

- `Lawvere.v` formalizes the core **Unity and Identity (UI)** structure from Lawvere's 1996 paper. A general UI whose two composites are isomorphisms is normalized to a cylinder: one map with two sections, hence a common retraction. It proves the induced idempotent equations and a finite product example.
- `Morava.v` formalizes the finite quaternion calculation from Jack Morava's 2003 *On the canonical formula of C. Levi-Strauss*. It proves the Q8 group laws, noncommutativity, bijectivity and multiplication reversal of Morava's anti-automorphism, and its required action on `x,a,y,b`.

Neither file promotes a philosophical or anthropological interpretation to a theorem. Rocq checks only the mathematical structures chosen as translations.

Run:

```sh
make -C rocq check
```

which invokes `rocq compile` on both files.
