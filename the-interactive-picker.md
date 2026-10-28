# The Interactive Picker

Frecency is a good guesser, but it is a
guesser. Some days the two rival folders
are close in score; some days you know
the folder's face but not its name well
enough to keyword it. For those days
`z` has a sibling, **`zi`**, which asks
the same question and then lets *you*
answer it from a list.

## What zi does

`zi` is `zoxide query --interactive`
(chapter 2): the matching candidates,
with their scores, are handed to
**fzf** — the fuzzy finder, a separate
tool covered by this series' *fzf for
Mere Mortals* guide — which opens a
full-screen list. Type to narrow it,
arrow to the entry, press Enter, and
you are standing in it. Esc leaves you
where you were.

The lab drove it for real, with an
actual fzf 0.74.5 behind a real terminal
(transcript `zoxide-lab/transcripts/t07-interactive-zi.txt`).
The standing situation was chapter 7's
aftermath: `camera/photos` on 28.0,
`phone/photos` removed and then visited
once more, putting it back at 4.0:

```text
lab$ zi photo
    (fzf opens full-screen, best first:)
       28.0 .../home/camera/photos
        4.0 .../home/phone/photos
    > phone        (typed, narrowing to one)
lab$ pwd
/home/.../home/phone/photos
```

Read that result carefully, because it
is the picker's whole reason to exist:
the typist *overruled* frecency. A plain
`z photo` would have gone to the camera
folder, as it did in chapter 6. Today
the phone folder was wanted, and the
picker made wanting it enough — no
ranks edited, no record corrected, just
eyes on the list for one jump.

## The price: fzf must be there

The picker is the one place zoxide
depends on another program (the database
editor of chapter 7 is the other), and
it says so plainly when fzf is missing.
The lab captured the refusal by asking
for an interactive query with fzf off
the path:

```text
$ zoxide query --interactive photos
zoxide: could not find fzf, is it installed?
exit=1
```

If you see that, chapter 3's closing
section is the fix — install fzf by
package manager or release archive —
after which `zi` works with no further
setup. Zoxide itself never pretends the
picker half-happened: it refuses, and
plain `z` carries on unaffected.

## When to pick and when to leap

Leap with `z` when the ranking knows
your habits — which, after the first
days of ordinary use, is most jumps.
Pick with `zi` when:

- the scores are close and the wrong
  twin is winning today (chapter 10's
  alternative fix is to retrain; the
  picker is the fix that lasts one jump);
- you remember the folder's look — a
  parent folder, part of the path — but
  not a keyword the matcher would accept;
- you are exploring what the database
  holds around a name, since the list is
  also a readable answer to "what do I
  have that looks like this?".

One customisation exists and is
documented rather than demonstrated
here: flags for fzf can be passed
through the `_ZO_FZF_OPTS` variable
(chapter 9), for readers whose fzf is
already tuned to their taste.
