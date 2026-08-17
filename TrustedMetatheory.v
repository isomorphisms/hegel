From Stdlib Require Import List.
Import ListNotations.

(*
  This file checks only the formal inference boundary. Atom numbers have no
  psychological or philosophical meaning here; any such interpretation belongs
  in the layer that supplies premises.
*)
Inductive Claim : Type :=
| Atom : nat -> Claim
| Implies : Claim -> Claim -> Claim.

Definition claim_eq_dec : forall x y : Claim, {x = y} + {x <> y}.
Proof.
  decide equality.
Defined.

Inductive derives (premises : list Claim) : Claim -> Prop :=
| derives_premise : forall claim,
    In claim premises ->
    derives premises claim
| derives_modus_ponens : forall antecedent conclusion,
    derives premises (Implies antecedent conclusion) ->
    derives premises antecedent ->
    derives premises conclusion.

Definition infer_from (premises : list Claim) (claim : Claim) : list Claim :=
  match claim with
  | Implies antecedent conclusion =>
      if in_dec claim_eq_dec antecedent premises then [conclusion] else []
  | Atom _ => []
  end.

(* One finite pass: premises plus direct modus-ponens consequences. *)
Definition infer (premises : list Claim) : list Claim :=
  premises ++ flat_map (infer_from premises) premises.

Lemma infer_from_sound :
  forall premises rule conclusion,
    In rule premises ->
    In conclusion (infer_from premises rule) ->
    derives premises conclusion.
Proof.
  intros premises rule conclusion Hrule Hin.
  destruct rule as [n | antecedent consequent].
  - simpl in Hin. contradiction.
  - simpl in Hin.
    destruct (in_dec claim_eq_dec antecedent premises) as [Hantecedent | Hantecedent].
    + simpl in Hin.
      destruct Hin as [Heq | Hin].
      * subst conclusion.
        eapply derives_modus_ponens.
        -- apply derives_premise. exact Hrule.
        -- apply derives_premise. exact Hantecedent.
      * contradiction.
    + simpl in Hin. contradiction.
Qed.

Theorem infer_sound :
  forall premises conclusion,
    In conclusion (infer premises) ->
    derives premises conclusion.
Proof.
  intros premises conclusion Hin.
  unfold infer in Hin.
  apply in_app_or in Hin.
  destruct Hin as [Hpremise | Hinferred].
  - apply derives_premise. exact Hpremise.
  - apply in_flat_map in Hinferred.
    destruct Hinferred as [rule [Hrule Hconclusion]].
    eapply infer_from_sound; eauto.
Qed.

(* Tiny, inspectable example: Atom 0 and 0 -> 1 yield Atom 1. *)
Definition example_premises : list Claim :=
  [Atom 0; Implies (Atom 0) (Atom 1)].

Definition example_conclusion : Claim := Atom 1.

Example example_is_emitted :
  In example_conclusion (infer example_premises).
Proof.
  simpl. auto.
Qed.

Example example_is_derivable :
  derives example_premises example_conclusion.
Proof.
  apply infer_sound.
  exact example_is_emitted.
Qed.

Compute infer example_premises.
