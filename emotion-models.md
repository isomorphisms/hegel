# Learned emotion and empathy models

This note records third-party learned models that may provide a perceptual layer for experiments on dialogue, emotion, empathy, and inference. The models and the ideas behind them are not original to this repository.

A theorem prover cannot usefully infer psychological structure directly from raw prose. If Coq is used here, the intended architecture is therefore not

```text
therapy transcript -> Coq -> psychological conclusion
```

but something closer to

```text
therapy transcript
    -> learned text / vector models
    -> uncertain, attributed observations
    -> typed relational representation
    -> Coq inference and verification
```

The learned model supplies empirical measurements. The formal layer can then state exactly which measurements, thresholds, assumptions, and inference rules were used, and can distinguish a checked implication from a model prediction.

## Candidate Hugging Face models

### Fine-grained emotion

**`SamLowe/roberta-base-go_emotions`**

- Hugging Face: https://huggingface.co/SamLowe/roberta-base-go_emotions
- Task: multi-label emotion classification.
- Labels: the 27 GoEmotions emotion categories plus neutral.
- Language/domain: English; fine-tuned from RoBERTa on GoEmotions.
- Hugging Face license: MIT.

This is the most obvious first model for converting individual utterances into a vector of candidate emotions rather than a single positive/negative sentiment label.

### Social-media emotion

**`cardiffnlp/twitter-roberta-base-emotion-latest`**

- Hugging Face: https://huggingface.co/cardiffnlp/twitter-roberta-base-emotion-latest
- Task: emotion classification.
- Labels include anger, anticipation, disgust, fear, joy, love, optimism, pessimism, sadness, surprise, and trust.
- Domain: social-media text.
- Hugging Face license: MIT.

This gives a coarser alternative whose training domain is relatively close to informal conversational writing.

### Multilingual GoEmotions

**`AnasAlokla/multilingual_go_emotions`**

- Hugging Face: https://huggingface.co/AnasAlokla/multilingual_go_emotions
- Task: multilingual multi-label emotion classification.
- Languages listed by the model card: Arabic, English, French, Spanish, Dutch, and Turkish.
- Hugging Face license: MIT.

This is relevant if the experiment later needs to distinguish the formal inference system from assumptions peculiar to English-language emotion vocabulary.

## EPITOME empathy models

Sharma, Miner, Atkins, and Althoff introduced EPITOME in *A Computational Approach to Understanding Empathy Expressed in Text-Based Mental Health Support* (EMNLP 2020):

https://aclanthology.org/2020.emnlp-main.425/

EPITOME separates expressed empathy into three mechanisms:

- **Emotional Reactions**: expressing emotion such as warmth, compassion, or concern in response to the seeker;
- **Interpretations**: communicating an understanding of feelings or experiences inferred from the seeker's post;
- **Explorations**: probing feelings or experiences that were not explicitly stated in order to understand them better.

The paper used a multi-task RoBERTa bi-encoder and rationale extraction on annotated mental-health-support conversations. These categories are especially relevant to therapist/support-thread analysis because they concern relations between one utterance and a response rather than merely assigning an emotion label to an isolated sentence.

Hugging Face ports of this three-model family are available as:

- **`RyanDDD/empathy-mental-health-reddit-ER`** — Emotional Reactions
  - https://huggingface.co/RyanDDD/empathy-mental-health-reddit-ER
- **`RyanDDD/empathy-mental-health-reddit-IP`** — Interpretations
  - https://huggingface.co/RyanDDD/empathy-mental-health-reddit-IP
- **`RyanDDD/empathy-mental-health-reddit-EX`** — Explorations
  - https://huggingface.co/RyanDDD/empathy-mental-health-reddit-EX

The current model cards describe a RoBERTa bi-encoder that consumes a seeker post and response, classifies the relevant empathy mechanism at low/medium/high level, and identifies rationale tokens. The Hugging Face model cards list the models as MIT licensed. The original EPITOME code/data have their own upstream terms and should be checked independently before redistributing training data or upstream artifacts.

## Intended interface to a formal layer

The useful boundary is between **measurement** and **inference**.

A learned model might emit evidence such as:

```text
EmotionEvidence {
  turn       = 17,
  model      = "SamLowe/roberta-base-go_emotions",
  label      = disappointment,
  score      = 0.73
}

EmpathyEvidence {
  seekerTurn = 17,
  replyTurn  = 18,
  model      = "RyanDDD/empathy-mental-health-reddit-IP",
  mechanism  = interpretation,
  level      = high
}
```

The formal system should not silently turn either record into a fact such as `Disappointed person` or `Understands therapist person`. Instead it should preserve provenance and uncertainty and reason conditionally from explicit evidence.

For example, a later Coq development could distinguish:

```text
observed utterance
model prediction
human annotation
inferred relation
proved consequence of stated assumptions
```

That distinction is important. The neural/vector layer can recognize patterns that a symbolic system cannot extract from raw language, while Coq can make the subsequent rules inspectable and prevent probabilistic guesses from being disguised as deductions.

## What these models do not establish

None of these models diagnoses a person, establishes an unconscious motive, or proves a Hegelian or psychoanalytic interpretation of a conversation. Their useful role here is narrower: convert language into explicit candidate measurements that a separate formal system can inspect, combine, reject, or reason from.

For therapist-thread experiments, speaker identity, conversational order, quoted material, and model/version provenance should be retained rather than reducing an entire thread to one pooled embedding.
