# Making It Yours

Zoxide arrives with sensible settings
and almost no knobs, which suits a tool
whose job is to disappear. The knobs
that exist divide into two families: the
**init options**, which shape the shell
code generated once, and the
**environment variables**, which the
running tool reads. This chapter covers
both, and is careful about a distinction
the lab caught out the hard way: one of
the variables is read at *init* time,
not when you jump.

## The variables

Set these in your shell's startup file,
before the init line, and they apply to
every shell you open:

| Variable | What it does |
|---|---|
| `_ZO_DATA_DIR` | Where `db.zo` lives, replacing the default `~/.local/share/zoxide/` |
| `_ZO_ECHO` | When `1`, each jump prints the folder it landed in |
| `_ZO_EXCLUDE_DIRS` | A colon-separated list of path patterns never to record |
| `_ZO_MAXAGE` | The total-rank budget of chapter 11 (default 10000) |
| `_ZO_RESOLVE_SYMLINKS` | When `1`, folders are recorded under their real, resolved paths |
| `_ZO_FZF_OPTS` | Extra flags handed to fzf for chapter 8's picker |

Two of these the lab put to work in
transcript `zoxide-lab/transcripts/t08-settings.txt`.
The **exclude list** first — the way to
keep a folder (a scratch tree, a mounted
backup, anything you pass through but
never work in) out of the diary:

```text
lab$ export _ZO_EXCLUDE_DIRS="$HOME/workshop"
lab$ cd ~/workshop
lab$ cd ~
lab$ zoxide query --all workshop
zoxide: no match found
```

Excluded means never recorded in the
first place — not recorded and hidden.
With the variable unset again, the very
next visit was learned as usual, as the
same transcript's second half shows.
Note that exclusion is checked when a
visit would be *recorded*: it is not a
filter you can apply to history already
written. For that, `zoxide remove`
(chapter 7) is the tool.

## The init-time variable: echo

`_ZO_ECHO` is the trap mentioned above.
What it changes is the *generated code*:
with the variable set to `1` in the
environment when `zoxide init` runs, the
generated jump function gains a step that
prints the destination after each jump.
Set it afterwards in a shell that already
loaded the plain code, and nothing
changes — the lab demonstrated both
halves of that sentence, and the fix is
simply to put the setting in the startup
file *above* the init line, so the init
sees it every time:

```text
lab$ export _ZO_ECHO=1
lab$ eval "$(zoxide init bash)"
lab$ z web
/home/.../home/projects/website
```

For most people the echo is a learning
aid for the first week — proof of where
each leap is going, until trust sets in
and the extra line becomes noise.

## The init options

`zoxide init bash` takes three options
(they are in its `--help`, and the lab
exercised the first):

- `--cmd <name>` — rename the commands,
  or take over an existing one. The lab
  generated the code with `--cmd cd` and
  watched `cd api` jump to
  `~/projects/api`: with that line in
  your startup file, `cd` *is* zoxide,
  keywords and all, and chapter 5's rule
  5 (a real path is used directly) is
  what keeps ordinary `cd` behaviour
  intact underneath. This is the boldest
  setting zoxide offers and the one many
  long-term users settle on.
- `--hook <when>` — how the learning of
  chapter 2 is triggered: `pwd` (the
  default the lab ran — record a folder
  when the prompt finds you somewhere
  new), `prompt` (count every prompt, so
  lingering somewhere also feeds it), or
  `none` (no learning at all; the
  database then only holds what `zoxide
  add` puts there).
- `--no-cmd` — generate only the hook and
  helper functions, defining no `z` or
  `zi`, for readers wiring the machinery
  into functions of their own.

The last two are described from the
tool's help and generated code rather
than driven in the lab; the default
hook is the one every transcript in
this guide was recorded under.
