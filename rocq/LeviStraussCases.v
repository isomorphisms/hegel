(* Real-case fixtures for the Levi-Strauss / Morava adequacy test.

   Important boundary:
   - narrative events below are transcribed from myths or from Levi-Strauss's
     own summaries of them;
   - bundle/opposition assignments are Levi-Strauss's analysis;
   - the quaternion encoding is Morava's mathematical interpretation.

   Rocq proves that those explicit encodings are internally consistent.  It
   does NOT prove that Levi-Strauss's classifications are anthropologically
   correct, uniquely determined by the stories, or empirically true. *)

Require Import Morava.

(* ------------------------------------------------------------------------- *)
(* 1. Oedipus: the concrete mytheme table in "The Structural Study of Myth". *)
(* ------------------------------------------------------------------------- *)

Inductive OedipusMytheme : Type :=
| CadmusSeeksEuropa
| CadmusKillsDragon
| SpartoiKillEachOther
| LabdacusLame
| OedipusKillsLaius
| LaiusLeftSided
| OedipusKillsSphinx
| OedipusSwollenFoot
| OedipusMarriesJocasta
| EteoclesKillsPolynices
| AntigoneBuriesPolynices.

(* These names deliberately stay close to the observable grouping in
   Levi-Strauss's table rather than formalizing his further interpretation
   about autochthony. *)
Inductive OedipusBundle : Type :=
| OverratedBloodRelation
| UnderratedBloodRelation
| MonsterSlaying
| ImpairedGait.

Definition oedipus_bundle (m : OedipusMytheme) : OedipusBundle :=
  match m with
  | CadmusSeeksEuropa => OverratedBloodRelation
  | OedipusMarriesJocasta => OverratedBloodRelation
  | AntigoneBuriesPolynices => OverratedBloodRelation

  | SpartoiKillEachOther => UnderratedBloodRelation
  | OedipusKillsLaius => UnderratedBloodRelation
  | EteoclesKillsPolynices => UnderratedBloodRelation

  | CadmusKillsDragon => MonsterSlaying
  | OedipusKillsSphinx => MonsterSlaying

  | LabdacusLame => ImpairedGait
  | LaiusLeftSided => ImpairedGait
  | OedipusSwollenFoot => ImpairedGait
  end.

(* Positive regression cases: these are the placements in Levi-Strauss's
   published chart. *)
Example oedipus_cadmus_seeks_europa :
  oedipus_bundle CadmusSeeksEuropa = OverratedBloodRelation.
Proof. reflexivity. Qed.

Example oedipus_spartoi :
  oedipus_bundle SpartoiKillEachOther = UnderratedBloodRelation.
Proof. reflexivity. Qed.

Example oedipus_sphinx :
  oedipus_bundle OedipusKillsSphinx = MonsterSlaying.
Proof. reflexivity. Qed.

Example oedipus_swollen_foot :
  oedipus_bundle OedipusSwollenFoot = ImpairedGait.
Proof. reflexivity. Qed.

(* Negative regressions: tempting lexical shortcuts must not collapse the
   published bundles.  "kills" does not by itself determine a bundle. *)
Example oedipus_father_is_not_monster_case :
  oedipus_bundle OedipusKillsLaius <> MonsterSlaying.
Proof. discriminate. Qed.

Example oedipus_sphinx_is_not_kin_case :
  oedipus_bundle OedipusKillsSphinx <> UnderratedBloodRelation.
Proof. discriminate. Qed.

(* ------------------------------------------------------------------------- *)
(* 2. Asdiwal: concrete reversals in the Boas-1912 version analyzed by LS.   *)
(* ------------------------------------------------------------------------- *)

(* Rather than asserting that every event "really means" one abstract thing,
   we record only opposition-poles that Levi-Strauss explicitly pairs in his
   analysis of this version. *)
Inductive AsdiwalPole : Type :=
| Downstream
| Upstream
| Earth
| Heaven
| MountainHunting
| SeaHunting
| KillingAnimals
| HealingAnimals
| EastToWest
| WestToEast
| MobileWithSnowshoes
| PetrifiedWithoutSnowshoes.

Definition asdiwal_flip (p : AsdiwalPole) : AsdiwalPole :=
  match p with
  | Downstream => Upstream
  | Upstream => Downstream
  | Earth => Heaven
  | Heaven => Earth
  | MountainHunting => SeaHunting
  | SeaHunting => MountainHunting
  | KillingAnimals => HealingAnimals
  | HealingAnimals => KillingAnimals
  | EastToWest => WestToEast
  | WestToEast => EastToWest
  | MobileWithSnowshoes => PetrifiedWithoutSnowshoes
  | PetrifiedWithoutSnowshoes => MobileWithSnowshoes
  end.

Theorem asdiwal_flip_involutive :
  forall p, asdiwal_flip (asdiwal_flip p) = p.
Proof.
  intro p. destruct p; reflexivity.
Qed.

(* Story-level regression cases from Levi-Strauss's own summary/analysis:
   - mother and daughter begin down-river/up-river and meet halfway;
   - the white-bear/Evening-Star episode carries Asdiwal earth -> heaven;
   - the brothers-in-law episode opposes mountain- and sea-hunting;
   - after the reef episode, the animal killer becomes healer of sea-lions;
   - the subterranean episode reverses the westward journey eastward;
   - forgetting the magic snowshoes leaves him immobile and petrified. *)
Example asdiwal_initial_river_opposition :
  asdiwal_flip Downstream = Upstream.
Proof. reflexivity. Qed.

Example asdiwal_white_bear_journey :
  asdiwal_flip Earth = Heaven.
Proof. reflexivity. Qed.

Example asdiwal_brothers_in_law_hunt :
  asdiwal_flip MountainHunting = SeaHunting.
Proof. reflexivity. Qed.

Example asdiwal_sealion_reversal :
  asdiwal_flip KillingAnimals = HealingAnimals.
Proof. reflexivity. Qed.

Example asdiwal_geographic_reversal :
  asdiwal_flip EastToWest = WestToEast.
Proof. reflexivity. Qed.

Example asdiwal_final_petrification :
  asdiwal_flip MobileWithSnowshoes = PetrifiedWithoutSnowshoes.
Proof. reflexivity. Qed.

(* A negative case prevents a very easy overgeneralization: sea-hunting is an
   opposition to mountain-hunting, not to heaven. *)
Example asdiwal_dont_mix_codes :
  asdiwal_flip MountainHunting <> Heaven.
Proof. discriminate. Qed.

(* ------------------------------------------------------------------------- *)
(* 3. The Jealous Potter: a concrete canonical-formula / Q8 compatibility.  *)
(* ------------------------------------------------------------------------- *)

(* In the case discussed by Levi-Strauss:
      a = goatsucker/nightjar
      b = woman
      x = jealousy
      y = potter
   and the inverse/opposite of the goatsucker position is identified with the
   ovenbird position.

   Morava encodes x->1, a->i, y->j, b->k.  We keep the source labels and
   transformed labels separate so that the test can say exactly which bridge
   assumption is being made. *)
Inductive PotterSource : Type :=
| SourceJealousy
| SourceGoatsuckerNightjar
| SourcePotter
| SourceWoman.

Inductive PotterTarget : Type :=
| TargetJealousy
| TargetWoman
| TargetOvenbird
| TargetPotter.

Definition potter_source_q8 (s : PotterSource) : Q8 :=
  match s with
  | SourceJealousy => One
  | SourceGoatsuckerNightjar => I
  | SourcePotter => J
  | SourceWoman => K
  end.

Definition potter_step (s : PotterSource) : PotterTarget :=
  match s with
  | SourceJealousy => TargetJealousy
  | SourceGoatsuckerNightjar => TargetWoman
  | SourcePotter => TargetOvenbird
  | SourceWoman => TargetPotter
  end.

Definition potter_target_q8 (t : PotterTarget) : Q8 :=
  match t with
  | TargetJealousy => One
  | TargetWoman => K
  | TargetOvenbird => NegI
  | TargetPotter => J
  end.

(* This is the real-case adequacy test: after supplying Levi-Strauss's concrete
   labels, his advertised transformation commutes with Morava's lambda. *)
Theorem jealous_potter_commutes_with_morava :
  forall s,
    potter_target_q8 (potter_step s) = lambda (potter_source_q8 s).
Proof.
  intro s. destruct s; reflexivity.
Qed.

(* The double twist must actually occur. *)
Example jealous_potter_a_goes_to_b :
  potter_step SourceGoatsuckerNightjar = TargetWoman.
Proof. reflexivity. Qed.

Example jealous_potter_y_goes_to_inverse_a :
  potter_step SourcePotter = TargetOvenbird /\
  potter_target_q8 TargetOvenbird = qinv (potter_source_q8 SourceGoatsuckerNightjar).
Proof. split; reflexivity. Qed.

Example jealous_potter_b_goes_to_y :
  potter_step SourceWoman = TargetPotter.
Proof. reflexivity. Qed.

Example jealous_potter_not_plain_swap :
  potter_step SourcePotter <> TargetPotter.
Proof. discriminate. Qed.
