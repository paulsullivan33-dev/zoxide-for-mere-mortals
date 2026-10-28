# Frecency and Rank

Several folders can pass the match test
of chapter 5 — two folders literally
named `photos`, in the lab's tree. This
chapter is how zoxide chooses between
them, in numbers you can print. Nothing
here is a heuristic you must take on
trust: every figure below is the lab's
real arithmetic, and you can reproduce
each one against your own database with
the commands shown.

## Rank: the visit count

Each database entry carries a **rank**,
and the rule is as plain as it sounds:
arrive in a folder, and its rank goes up
by one. Arrive via the hook after a
`cd`, after a `z` jump, after anything —
the hook of chapter 2 does not ask how
you travelled. Rank is therefore nothing
more mysterious than a visit counter,
kept per folder.

## Score: rank, aged

The number a query actually competes on
is the **score**:

> **score = rank × an age multiplier**

where the multiplier depends on how long
ago the *last* visit was:

| Last visited | Multiplier |
|---|---|
| Within the last hour | × 4 |
| Within the last day | × 2 |
| Within the last week | × 0.5 |
| Longer ago | × 0.25 |

"Frecency" is exactly this: frequency in
the rank, recency in the multiplier. A
folder you live in beats a folder you
visited twice as often but abandoned in
spring — eventually, and by arithmetic,
not by opinion.

The lab proved the table rather than
quoting it. Four folders were imported
into a fresh database with **identical
rank 10** and last-visit times of half
an hour, five hours, three days and
thirty days ago (chapter 11 shows the
importing; transcript
`zoxide-lab/transcripts/t05-time-decay.txt`):

```text
$ zoxide query --score website     40.0
$ zoxide query --score api         20.0
$ zoxide query --score invoices     5.0
$ zoxide query --score letters      2.5
```

10 × 4, 10 × 2, 10 × 0.5, 10 × 0.25.
The table is the tool's real behaviour,
measured on its own scoring code.

## The contest of the two photos

Rank's half of the story was staged in
transcript `t03-frecency-rivals.txt`.
The lab visited `~/camera/photos` six
times and `~/phone/photos` twice, in an
interleaved walk so neither had a recency
advantage — both were visited inside the
same few minutes, so both earned the ×4
multiplier, and only the ranks differed:

```text
lab$ zoxide query --list --score photos
  24.0 /home/.../home/camera/photos
   8.0 /home/.../home/phone/photos
lab$ z photos
lab$ pwd
/home/.../home/camera/photos
```

24 is 6 visits × 4; 8 is 2 visits × 4;
and the jump lands where the bigger
number is. That is the whole trick, and
it generalises: `z` takes you to your
most-worked folder that matches, which
is right far more often than it is
wrong, because your journeys repeat.

Two honest corollaries, both visible in
this guide's own transcripts. First,
**jumping feeds the winner**: the `z
photos` landing above was itself an
arrival, so by chapter 8's transcript
the same folder's score has risen to
28.0 — the rich get richer, which is
usually what you want from a habit.
Second, **rank is not a verdict on your
intentions**: it counts the past. A
folder you hammered during one finished
project will outrank your current daily
one for a while, and chapter 10 has the
recipe for correcting a jump that keeps
landing in yesterday's work.
