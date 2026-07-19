---
name: decision-tradeoffs
description: Coach a user through comparing options by clarifying requirements, eliciting benefits and drawbacks in separate turns for each option, then responding to their reasoning, adding missed considerations and summarizing the tradeoffs. Use when a user has two or more possible choices and wants to understand the compromises before deciding.
---

# Decision Tradeoffs

## Phase 1: Clarify the decision

1. Restate the decision in one sentence and list every known option. Continue when the user can correct the decision boundary or option list.
2. Ask a compact series of questions covering only:
   - What outcome is the user trying to achieve, and what would make the decision successful?
   - Which requirements cannot be compromised?
   - Which criteria matter most, such as cost, time, quality, risk, effort or reversibility?
   - What assumptions, concerns or uncertainties could change the choice?
3. Adapt the questions to the context, omit anything already answered and include concrete domain questions only when their answers could change the comparison. Do not ask about the options' benefits or drawbacks yet. Continue when the questions are neutral and answerable without specialist vocabulary.
4. Stop and wait for the user's response unless the initial request already answers every material requirement question. Do not compare, score or recommend.

## Phase 2: Elicit one option at a time

1. Select the first option not yet examined, preserving the user's option order. Ask only which benefits the user sees in that option.
2. Stop and wait for the user's response. Do not evaluate their points, add considerations or ask about drawbacks in the same turn. Mark benefits as collected when the user answers; treat an explicit `none` as complete.
3. On the next turn, briefly acknowledge that the benefits were recorded without judging them. Ask only which drawbacks, risks or concerns the user sees in the same option.
4. Stop and wait for the user's response. Do not evaluate their points, add considerations or ask about another option in the same turn. Mark drawbacks as collected when the user answers; treat an explicit `none` as complete.
5. On the next turn, briefly acknowledge that the option was recorded without judging it. Repeat steps 1-4 for the next unexamined option.
6. Continue when benefits and drawbacks are collected separately for every option. Do not force the user to invent a point.

## Phase 3: Teach through the comparison

1. Summarize the user's goal, priorities and arguments in their own terms. Separate requirements from preferences and label inferred assumptions. Continue when the user could recognize their reasoning without the model strengthening or weakening it.
2. Respond to every benefit and drawback the user identified. Confirm sound points, explain important conditions or limitations, and correct a misconception with a brief reason rather than silently replacing it. Continue when every user-supplied argument has an explicit response.
3. Add material benefits, drawbacks, risks or unknowns the user did not mention. Label them as additional considerations and explain why each matters in this decision. Do not add generic points that cannot affect the choice. Continue when the added analysis is distinct from the user's original reasoning.
4. Compare every option against the same relevant criteria. Do not invent precision, treat the number of bullets as a score or hide a decisive disadvantage in prose. Ask a follow-up question and stop if a remaining unknown could materially reverse the conclusion.
5. Explain the central tradeoffs in plain language: what the user gains, gives up and risks with each option, and which conditions favor it. Recommend an option only when the user's priorities and available evidence support it; otherwise identify the fact or preference that would decide between the leading options.

## Phase 1 output

Return only:

- **Decision:** one sentence and the known options.
- **Questions:** the smallest useful set of numbered questions about the outcome, requirements, priorities and uncertainties.

## Phase 2 output

Return only:

- **Option:** the name of the single option being examined.
- **Question:** if benefits are not collected, ask only about benefits; otherwise ask only about drawbacks, risks and concerns.

## Phase 3 output

Return:

- **Decision:** one sentence.
- **Your priorities:** requirements, preferences and labeled assumptions.
- **Your observations:** the user's benefits and drawbacks, each with a response.
- **Additional considerations:** only material benefits, drawbacks, risks or unknowns the user missed.
- **Tradeoff summary:** a short comparison of the most important gains and sacrifices.
- **Conclusion:** a conditional recommendation or the next deciding question, with a brief reason.

Use a compact table for three or more options when the same criteria apply cleanly. Use short sections for two options or when the considerations are mostly qualitative. Keep unlike criteria separate; do not calculate a total score unless the user supplies or approves weights.

Completion criterion: the requirements were clarified before option elicitation; the user considered benefits and drawbacks in separate turns for every option; every known option was then assessed against their material priorities; every user-supplied argument received a response; added considerations are visibly separate; and the conclusion is traceable to the stated tradeoffs.
