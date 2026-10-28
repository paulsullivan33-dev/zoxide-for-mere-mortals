# Glossary

**Aging** — the database's forgetting
mechanism: when total rank exceeds the
`_ZO_MAXAGE` budget, all ranks are
scaled down and entries below rank 1
are deleted (chapter 11).

**Database** — the file `db.zo` holding
every entry's path, rank, and last-visit
time; zoxide's memory, and the diary of
chapter 1.

**Data directory** — where the database
lives: `~/.local/share/zoxide/` by
default, or `_ZO_DATA_DIR` if set
(chapters 2 and 9).

**Doctor** — the check built into the
generated shell code that warns when the
hook is not installed, usually because
the init line is not at the end of the
startup file (chapters 2 and 14).

**Exclude list** — `_ZO_EXCLUDE_DIRS`: a
colon-separated list of path patterns
the hook will never record (chapter 9).

**Frecency** — the ranking idea behind
the score: frequency of visits blended
with recency of the last one
(chapter 6).

**fzf** — the fuzzy finder, a separate
tool that powers `zi`'s list and the
database editor's screen (chapter 8).

**Hook** — the generated shell code,
attached to the prompt, that records
each new directory you arrive in
(chapter 2).

**Init** — `zoxide init <shell>`: prints
the shell code (hook, `z`, `zi`) that a
startup file evaluates to set zoxide up
(chapter 3).

**Keyword** — one of the words given to
`z` or `zoxide query`; a fragment that
must appear in the path, with the last
keyword required to appear in the
folder's own name (chapter 5).

**Match** — a database entry whose path
satisfies all the keywords, in order;
the score then chooses among matches
(chapters 5 and 6).

**Picker** — the `zi` command: an
interactive fzf list of the matches, for
choosing with your eyes (chapter 8).

**Query** — `zoxide query`: asks the
database for the best match (or, with
flags, all matches, with scores) and
prints it instead of travelling
(chapter 7).

**Rank** — an entry's visit count: one
point per arrival, kept as a running
total, and the raw material of the
score (chapter 6).

**Score** — rank multiplied by an age
multiplier (×4 within the hour, ×2
within the day, ×0.5 within the week,
×0.25 beyond): the number matches
compete on (chapter 6).

**z** — the jump command: a shell
function that queries the database and
changes directory to the answer
(chapter 2).

**zi** — the interactive jump command:
`z` with the answer chosen from fzf's
list instead of by score (chapter 8).
