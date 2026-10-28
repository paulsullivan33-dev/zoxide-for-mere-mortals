# The Moving Parts

Zoxide feels like one small command, but
four parts do the work, and most
confusion about it is really confusion
about which part you are talking to.
They are worth meeting separately,
because each can fail in its own way and
chapter 14 names the failures by part.

## The binary

There is a single program, `zoxide`,
written in Rust and shipped as one file
with no dependencies to install
alongside it. By itself it never changes
your directory — a program cannot reach
out of its own process and move your
shell — and it never watches anything on
its own. It does three jobs when asked:
keep the database (`zoxide add` and
`zoxide remove`), answer questions from
it (`zoxide query`), and print shell
code (`zoxide init`). Everything else in
this guide is your shell using those
three jobs on your behalf.

## The hook

The watching is done by a scrap of shell
code that `zoxide init bash` prints and
your startup file runs (chapter 3). In
bash the default arrangement is a **hook**
on the prompt: each time a prompt is
about to be shown, a small function
compares the current directory with the
last one it saw, and if you have moved,
it quietly runs `zoxide add` on the
folder you arrived in. Two details of
the lab's reading of that generated code
are worth knowing now:

- It records *arrivals*, not typing. A
  folder earns its point when you land
  in it, however you got there — `cd`,
  `z`, a script's subshell that changes
  directory and hands you its prompt.
- It only runs where the startup file
  ran: interactive shells. A script's
  private `cd` inside `bash -c` is never
  seen, as chapter 14 shows with a
  folder that was visited in exactly
  that way and learned nothing.

The generated code also carries a
**doctor**: if the hook turns out not to
be installed — usually because the init
line sits in the middle of the startup
file and something after it replaced the
prompt machinery — zoxide prints a
warning saying so, rather than silently
remembering nothing.

## The database

Everything learned lands in one small
file, **`db.zo`**, in zoxide's data
directory: by default `~/.local/share/zoxide/`,
or wherever the `_ZO_DATA_DIR` variable
points (chapter 9). Each entry is a
path, a **rank** — the running total of
visits — and the time of the last visit.

In zoxide 0.10 that file is a compact
binary format, not text. This surprises
people arriving from zoxide's elders
(chapter 12), whose data files were
plain lists you could edit in a text
editor. Here, the supported ways to look
inside are `zoxide query` (chapter 7)
and the interactive `zoxide edit`, and
the supported ways to change it are
`zoxide add` and `zoxide remove`. The
lab confirmed the file is binary by the
simple expedient of printing it: a few
readable paths in a thicket of control
characters. Treat that as a design
decision to live with, not a puzzle.

## The commands your shell grows

The init script also defines two shell
functions:

- **`z`** — the jumper. Given keywords,
  it asks `zoxide query` for the best
  match and changes directory to the
  answer. Given nothing, it goes home;
  given `-`, back to the previous folder;
  given one argument that is already a
  real path, it goes straight there
  without consulting the database at all.
  Chapter 5 states the matching rules
  these behaviours add up to.
- **`zi`** — the same question asked
  interactively: `zoxide query --interactive`
  hands the candidates to **fzf**, the
  fuzzy finder, and you pick from a list
  (chapter 8). `zi` is the only part of
  zoxide that needs a second program
  installed.

So a jump is a relay: your words reach
`z`, `z` reaches `zoxide query`, the
query reads `db.zo`, does the frecency
arithmetic of chapter 6, and prints one
path, which `z` finally steps into —
earning that folder another point from
the hook as the next prompt appears.
