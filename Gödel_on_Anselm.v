(*
  Gödel on Anselm
  =================

  A small shallow Coq embedding of the Gödel/Scott ontological argument.

  This file does NOT prove that Gödel's axioms are philosophically true.
  It makes the assumptions explicit and proves the modal consequence:

      necessarily, a God-like being exists.

  The embedding uses constant-domain Kripke semantics.  Properties may vary
  from world to world, and positivity is itself world-relative.  The final
  modal step uses symmetry and transitivity of accessibility; these suffice
  here for the familiar S5 principle ◇□p -> □p.

  The five hypotheses A1--A5 are the standard Scott-style presentation of
  Gödel's notes:

    A1  the negation of a property is positive iff the property is not positive
    A2  necessary consequences of positive properties are positive
    A3  God-likeness is positive
    A4  positive properties are necessarily positive
    A5  necessary existence is positive

  The point of the formalization is therefore diagnostic as much as
  demonstrative: Coq verifies the derivation while leaving the metaphysical
  load-bearing assumptions visible.
*)

From Coq Require Import Classical.

Section GodelOnAnselm.

Context {World Individual : Type}.
Variable access : World -> World -> Prop.

(* Modal propositions and intensional individual properties. *)
Definition MProp := World -> Prop.
Definition Property := Individual -> World -> Prop.

Definition box (p : MProp) : MProp :=
  fun w => forall v, access w v -> p v.

Definition diamond (p : MProp) : MProp :=
  fun w => exists v, access w v /\ p v.

Definition neg_property (phi : Property) : Property :=
  fun x w => ~ phi x w.

Definition exists_property (phi : Property) : MProp :=
  fun w => exists x, phi x w.

(* Positivity is primitive, just as in Gödel's argument. *)
Variable Positive : Property -> World -> Prop.

(* A God-like individual has every positive property. *)
Definition Godlike : Property :=
  fun x w => forall phi, Positive phi w -> phi x w.

(* phi is an essence of x when x has phi and phi necessarily entails every
   property x actually has. *)
Definition Essence (phi : Property) (x : Individual) (w : World) : Prop :=
  phi x w /\
  forall psi,
    psi x w ->
    box (fun v => forall y, phi y v -> psi y v) w.

(* Necessary existence: every essence of x is necessarily exemplified. *)
Definition NecessaryExistence : Property :=
  fun x w =>
    forall phi,
      Essence phi x w ->
      box (exists_property phi) w.

(* Scott's presentation of Gödel's axioms. *)
Hypothesis A1 :
  forall phi w,
    Positive (neg_property phi) w <-> ~ Positive phi w.

Hypothesis A2 :
  forall phi psi w,
    Positive phi w ->
    box (fun v => forall x, phi x v -> psi x v) w ->
    Positive psi w.

Hypothesis A3 :
  forall w, Positive Godlike w.

Hypothesis A4 :
  forall phi w,
    Positive phi w ->
    box (fun v => Positive phi v) w.

Hypothesis A5 :
  forall w, Positive NecessaryExistence w.

(* Frame assumptions used by the final S5-style step. *)
Hypothesis access_sym :
  forall w v, access w v -> access v w.

Hypothesis access_trans :
  forall u v z, access u v -> access v z -> access u z.

(* Gödel's first important lemma: every positive property is possibly
   exemplified. *)
Lemma positive_possible :
  forall phi w,
    Positive phi w -> diamond (exists_property phi) w.
Proof.
  intros phi w Hpos.
  apply NNPP.
  intro Hnot.

  assert (Hboxneg :
    box (fun v => forall x, phi x v -> neg_property phi x v) w).
  {
    unfold box, neg_property.
    intros v Hwv x Hphi Hphi_again.
    apply Hnot.
    exists v.
    split.
    - exact Hwv.
    - exists x. exact Hphi.
  }

  assert (Hnegpos : Positive (neg_property phi) w).
  {
    exact (A2 phi (neg_property phi) w Hpos Hboxneg).
  }

  exact ((proj1 (A1 phi w) Hnegpos) Hpos).
Qed.

(* Since God-likeness itself is positive, a God-like being is possible. *)
Lemma possibly_godlike :
  forall w, diamond (exists_property Godlike) w.
Proof.
  intro w.
  apply positive_possible.
  apply A3.
Qed.

(* For a God-like individual, any property it actually has must be positive.
   Otherwise the negation of that property would be positive by A1, and the
   individual would have both the property and its negation. *)
Lemma godlike_properties_are_positive :
  forall x w psi,
    Godlike x w -> psi x w -> Positive psi w.
Proof.
  intros x w psi HG Hpsi.
  apply NNPP.
  intro Hnotpos.

  assert (Hnegpos : Positive (neg_property psi) w).
  {
    apply (proj2 (A1 psi w)).
    exact Hnotpos.
  }

  pose proof (HG (neg_property psi) Hnegpos) as Hnotpsi.
  exact (Hnotpsi Hpsi).
Qed.

(* God-likeness is an essence of every God-like being.  A4 is the crucial
   bridge: a property positive here remains positive at accessible worlds. *)
Lemma godlike_is_an_essence :
  forall x w,
    Godlike x w -> Essence Godlike x w.
Proof.
  intros x w HG.
  split.
  - exact HG.
  - intros psi Hpsi.

    assert (Hpos : Positive psi w).
    {
      exact (godlike_properties_are_positive x w psi HG Hpsi).
    }

    pose proof (A4 psi w Hpos) as Hnecessarily_positive.
    unfold box in Hnecessarily_positive.
    unfold box.
    intros v Hwv y HGy.
    apply HGy.
    exact (Hnecessarily_positive v Hwv).
Qed.

(* Necessary existence is positive, so every God-like being has it. *)
Lemma godlike_has_necessary_existence :
  forall x w,
    Godlike x w -> NecessaryExistence x w.
Proof.
  intros x w HG.
  exact (HG NecessaryExistence (A5 w)).
Qed.

(* Therefore actual God-like existence at any world entails necessary
   God-like existence at that world. *)
Lemma godlike_exists_implies_necessary :
  forall w,
    exists_property Godlike w -> box (exists_property Godlike) w.
Proof.
  intros w Hex.
  unfold exists_property in Hex.
  destruct Hex as [x HG].

  pose proof (godlike_has_necessary_existence x w HG) as HNE.
  pose proof (godlike_is_an_essence x w HG) as Hessence.
  exact (HNE Godlike Hessence).
Qed.

(* On a symmetric, transitive frame, ◇□p -> □p.  This is the modal skeleton
   usually attributed to the final S5 step of the argument. *)
Lemma possible_necessary_implies_necessary :
  forall p w,
    diamond (box p) w -> box p w.
Proof.
  intros p w Hpossible.
  unfold diamond in Hpossible.
  destruct Hpossible as [v [Hwv Hvbox]].
  unfold box in Hvbox.
  unfold box.
  intros u Hwu.
  apply Hvbox.
  eapply access_trans.
  - apply access_sym. exact Hwv.
  - exact Hwu.
Qed.

(* Gödel/Scott conclusion: necessarily, a God-like being exists. *)
Theorem godel_scott_ontological_argument :
  forall w, box (exists_property Godlike) w.
Proof.
  intro w.
  apply possible_necessary_implies_necessary.

  destruct (possibly_godlike w) as [v [Hwv Hvexists]].
  unfold diamond.
  exists v.
  split.
  - exact Hwv.
  - apply godlike_exists_implies_necessary.
    exact Hvexists.
Qed.

End GodelOnAnselm.
