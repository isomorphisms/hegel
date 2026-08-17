(*
  Jack Morava, "On the canonical formula of C. Levi-Strauss" (2003).

  Formal synopsis of the finite algebraic part of Morava's argument.

  Morava reads Levi-Strauss's canonical formula as containing a directed
  transformation rather than a plain symmetric equivalence.  He observes
  that a version of the transformation can be modeled inside the quaternion
  group Q8 by an anti-automorphism.

  The narrow claim formalized here is:

      there exists a noncommutative finite group Q8 and an
      anti-automorphism realizing

          x |-> x
          a |-> b
          y |-> a^-1
          b |-> y

  under Morava's assignment

          x = 1, a = i, y = j, b = k.

  This does not formalize the anthropological semantics of myth, and it does
  not prove Levi-Strauss's theory.  It checks one mathematical model Morava
  proposes for the structure of the canonical transformation.
*)

Inductive QSign : Type :=
| Pos
| Neg.

Inductive QBasis : Type :=
| E
| I
| J
| K.

Record Q8 : Type := mkQ {
  sign_of  : QSign;
  basis_of : QBasis
}.

Definition sxor (a b : QSign) : QSign :=
  match a, b with
  | Pos, Pos => Pos
  | Pos, Neg => Neg
  | Neg, Pos => Neg
  | Neg, Neg => Pos
  end.

Definition flip (s : QSign) : QSign :=
  match s with
  | Pos => Neg
  | Neg => Pos
  end.

(*
  Multiplication of the positive basis elements:

      i^2 = j^2 = k^2 = -1
      ij = k
      jk = i
      ki = j

  Reversing one of the last three products changes the sign.
*)
Definition basis_mul (a b : QBasis) : Q8 :=
  match a, b with
  | E, E => mkQ Pos E
  | E, I => mkQ Pos I
  | E, J => mkQ Pos J
  | E, K => mkQ Pos K

  | I, E => mkQ Pos I
  | I, I => mkQ Neg E
  | I, J => mkQ Pos K
  | I, K => mkQ Neg J

  | J, E => mkQ Pos J
  | J, I => mkQ Neg K
  | J, J => mkQ Neg E
  | J, K => mkQ Pos I

  | K, E => mkQ Pos K
  | K, I => mkQ Pos J
  | K, J => mkQ Neg I
  | K, K => mkQ Neg E
  end.

Definition qmul (a b : Q8) : Q8 :=
  let r := basis_mul (basis_of a) (basis_of b) in
  mkQ
    (sxor (sxor (sign_of a) (sign_of b)) (sign_of r))
    (basis_of r).

Definition qinv (a : Q8) : Q8 :=
  match basis_of a with
  | E => a
  | I => mkQ (flip (sign_of a)) I
  | J => mkQ (flip (sign_of a)) J
  | K => mkQ (flip (sign_of a)) K
  end.

Definition one : Q8 := mkQ Pos E.
Definition qi  : Q8 := mkQ Pos I.
Definition qj  : Q8 := mkQ Pos J.
Definition qk  : Q8 := mkQ Pos K.

(* Q8 is genuinely noncommutative, so reversing multiplication is meaningful. *)
Lemma Q8_noncommutative :
  qmul qi qj <> qmul qj qi.
Proof.
  discriminate.
Qed.

Definition homomorphism (f : Q8 -> Q8) : Prop :=
  forall p q,
    f (qmul p q) = qmul (f p) (f q).

Definition antihomomorphism (f : Q8 -> Q8) : Prop :=
  forall p q,
    f (qmul p q) = qmul (f q) (f p).

Definition bijective (f : Q8 -> Q8) : Prop :=
  exists g : Q8 -> Q8,
    (forall q, g (f q) = q) /\
    (forall q, f (g q) = q).

Definition anti_automorphism (f : Q8 -> Q8) : Prop :=
  antihomomorphism f /\ bijective f.

(* Apply a map on positive basis elements while carrying the input sign. *)
Definition signed_map
    (f : QBasis -> Q8)
    (q : Q8) : Q8 :=
  let r := f (basis_of q) in
  mkQ
    (sxor (sign_of q) (sign_of r))
    (basis_of r).

(*
  Morava's lambda:

      lambda(i) = k
      lambda(j) = -i = i^-1
      lambda(k) = j
      lambda(1) = 1.
*)
Definition lambda_basis (u : QBasis) : Q8 :=
  match u with
  | E => mkQ Pos E
  | I => mkQ Pos K
  | J => mkQ Neg I
  | K => mkQ Pos J
  end.

Definition lambda : Q8 -> Q8 :=
  signed_map lambda_basis.

Definition lambda_inverse_basis (u : QBasis) : Q8 :=
  match u with
  | E => mkQ Pos E
  | I => mkQ Neg J
  | J => mkQ Pos K
  | K => mkQ Pos I
  end.

Definition lambda_inverse : Q8 -> Q8 :=
  signed_map lambda_inverse_basis.

Lemma lambda_antihom :
  antihomomorphism lambda.
Proof.
  intros [sp up] [sq uq].
  destruct sp;
  destruct up;
  destruct sq;
  destruct uq;
  reflexivity.
Qed.

Lemma lambda_bijective :
  bijective lambda.
Proof.
  exists lambda_inverse.
  split;
  intros [s u];
  destruct s;
  destruct u;
  reflexivity.
Qed.

Theorem lambda_is_anti_automorphism :
  anti_automorphism lambda.
Proof.
  split.
  - exact lambda_antihom.
  - exact lambda_bijective.
Qed.

(*
  We do not assign semantics to Levi-Strauss's F_x(a) here.  We isolate the
  structural transformation that Morava models algebraically.
*)
Definition canonical_transform
    (f : Q8 -> Q8)
    (x a y b : Q8) : Prop :=
      f x = x
   /\ f a = b
   /\ f y = qinv a
   /\ f b = y.

Theorem lambda_realizes_canonical_formula :
  canonical_transform lambda one qi qj qk.
Proof.
  repeat split; reflexivity.
Qed.

(*
  Coq-sized synopsis of Morava's mathematical claim:
  a concrete anti-automorphism of Q8 realizes the directed twist appearing
  in his reading of the canonical formula.
*)
Theorem morava_model :
  exists f : Q8 -> Q8,
       anti_automorphism f
    /\ canonical_transform f one qi qj qk.
Proof.
  exists lambda.
  split.
  - exact lambda_is_anti_automorphism.
  - exact lambda_realizes_canonical_formula.
Qed.
