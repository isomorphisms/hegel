(* A small formal test of Jack Morava's 2003 interpretation of
   Levi-Strauss's canonical formula using the quaternion group Q8.

   We verify the finite algebra Morava uses: Q8 is a noncommutative group and
   the stated map lambda is a bijective anti-homomorphism with the action on
   x,a,y,b required by the canonical-formula transformation.

   This checks the mathematical example.  It does not prove that the example
   is the unique or empirically correct interpretation of Levi-Strauss. *)

Inductive Q8 : Type :=
| One | NegOne
| I | NegI
| J | NegJ
| K | NegK.

Definition qmul (x y : Q8) : Q8 :=
  match x, y with
  | One, One => One | One, NegOne => NegOne
  | One, I => I | One, NegI => NegI
  | One, J => J | One, NegJ => NegJ
  | One, K => K | One, NegK => NegK

  | NegOne, One => NegOne | NegOne, NegOne => One
  | NegOne, I => NegI | NegOne, NegI => I
  | NegOne, J => NegJ | NegOne, NegJ => J
  | NegOne, K => NegK | NegOne, NegK => K

  | I, One => I | I, NegOne => NegI
  | I, I => NegOne | I, NegI => One
  | I, J => K | I, NegJ => NegK
  | I, K => NegJ | I, NegK => J

  | NegI, One => NegI | NegI, NegOne => I
  | NegI, I => One | NegI, NegI => NegOne
  | NegI, J => NegK | NegI, NegJ => K
  | NegI, K => J | NegI, NegK => NegJ

  | J, One => J | J, NegOne => NegJ
  | J, I => NegK | J, NegI => K
  | J, J => NegOne | J, NegJ => One
  | J, K => I | J, NegK => NegI

  | NegJ, One => NegJ | NegJ, NegOne => J
  | NegJ, I => K | NegJ, NegI => NegK
  | NegJ, J => One | NegJ, NegJ => NegOne
  | NegJ, K => NegI | NegJ, NegK => I

  | K, One => K | K, NegOne => NegK
  | K, I => J | K, NegI => NegJ
  | K, J => NegI | K, NegJ => I
  | K, K => NegOne | K, NegK => One

  | NegK, One => NegK | NegK, NegOne => K
  | NegK, I => NegJ | NegK, NegI => J
  | NegK, J => I | NegK, NegJ => NegI
  | NegK, K => One | NegK, NegK => NegOne
  end.

Definition qinv (x : Q8) : Q8 :=
  match x with
  | One => One
  | NegOne => NegOne
  | I => NegI | NegI => I
  | J => NegJ | NegJ => J
  | K => NegK | NegK => K
  end.

Theorem qmul_assoc :
  forall x y z, qmul x (qmul y z) = qmul (qmul x y) z.
Proof.
  intros x y z. destruct x; destruct y; destruct z; reflexivity.
Qed.

Theorem qmul_left_identity : forall x, qmul One x = x.
Proof. intro x. destruct x; reflexivity. Qed.

Theorem qmul_right_identity : forall x, qmul x One = x.
Proof. intro x. destruct x; reflexivity. Qed.

Theorem qmul_left_inverse : forall x, qmul (qinv x) x = One.
Proof. intro x. destruct x; reflexivity. Qed.

Theorem qmul_right_inverse : forall x, qmul x (qinv x) = One.
Proof. intro x. destruct x; reflexivity. Qed.

Example q8_is_noncommutative : qmul I J <> qmul J I.
Proof. discriminate. Qed.

(* Morava's anti-automorphism: i |-> k, j |-> i^-1 = -i, k |-> j. *)
Definition lambda (x : Q8) : Q8 :=
  match x with
  | One => One
  | NegOne => NegOne
  | I => K
  | NegI => NegK
  | J => NegI
  | NegJ => I
  | K => J
  | NegK => NegJ
  end.

Definition lambda_inverse (x : Q8) : Q8 :=
  match x with
  | One => One
  | NegOne => NegOne
  | I => NegJ
  | NegI => J
  | J => K
  | NegJ => NegK
  | K => I
  | NegK => NegI
  end.

Theorem lambda_reverses_multiplication :
  forall x y, lambda (qmul x y) = qmul (lambda y) (lambda x).
Proof.
  intros x y. destruct x; destruct y; reflexivity.
Qed.

Theorem lambda_inverse_left :
  forall x, lambda_inverse (lambda x) = x.
Proof. intro x. destruct x; reflexivity. Qed.

Theorem lambda_inverse_right :
  forall x, lambda (lambda_inverse x) = x.
Proof. intro x. destruct x; reflexivity. Qed.

Example lambda_is_nontrivial : lambda I <> I.
Proof. discriminate. Qed.

(* Morava's assignment x |-> 1, a |-> i, y |-> j, b |-> k. *)
Definition myth_x : Q8 := One.
Definition myth_a : Q8 := I.
Definition myth_y : Q8 := J.
Definition myth_b : Q8 := K.

Theorem morava_canonical_formula_action :
  lambda myth_x = myth_x /\
  lambda myth_a = myth_b /\
  lambda myth_y = qinv myth_a /\
  lambda myth_b = myth_y.
Proof.
  repeat split; reflexivity.
Qed.
