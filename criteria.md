# Writing criteria for this guide

Every "for Mere Mortals" guide is written to the same nine-point
standard, so a reader who trusts one can trust the rest. Here it
is, with the verification notes for this particular guide below.

1. **Fix it first.** Reader outcomes lead, not action items: each
   chapter opens by naming the outcome it delivers, shows a check
   the reader can run to confirm they got it, and a reasonable
   reader finishes able to state what was done, what it means,
   and what to try next.
2. **Plain language.** Short sentences, everyday vocabulary,
   technical terms defined on first use. No slang, and no
   idioms that only make sense in one country — the reader may
   be translating as they go.
3. **No dead ends.** A guide never tells the reader to do
   something it cannot show them how to verify. Every claim a
   reader relies on — an install, a command, an output — is
   something this guide demonstrates or clearly labels
   documented-only below.
4. **Live-verified where it matters.** Procedures are run for
   real in the guide's lab wherever the build machine allows it,
   and the transcripts kept in the repository are the evidence.
   What could not be run is listed honestly below, never
   presented as if it had been.
5. **General audiences.** Nothing in this guide — examples,
   fixtures, names, addresses — is modelled on any particular
   reader or author's real life, network, or organisations.
   The lab's traffic is the lab talking to itself.
6. **Standalone.** A reader needs this guide, its lab, and
   nothing else. Where another guide would genuinely help, it
   is pointed to once, by name, and the chapter still completes
   without it.
7. **Honest about limits.** Chapter 13 names what the tool
   cannot do: folders it has never seen you visit, a memory
   that starts empty on every new machine, jumps that follow
   your habits rather than your intentions, a database with no
   built-in sync between machines, and the plain record it
   keeps of every folder you have been in.
8. **The privacy point is in the text, early.** Chapter 1 and
   the README state it plainly — *zoxide's database is a diary
   of the folders you visit, kept in your home folder for
   anyone with your account to read* — before any procedure
   depends on it, and later chapters point back to it where
   carrying that diary to another machine would be easy.
9. **Builds clean.** The site builds with MkDocs in strict mode
   with no warnings, and a fresh reader following the chapters
   in order reaches the stated outcome of each.

## Verification notes for this guide

The build machine is a small Linux sandbox. Zoxide **0.10.0**
was taken from the project's official GitHub release (the
x86_64 musl tarball) and run, never installed system-wide,
against a scratch home folder whose `.bashrc` carried the
init line; the interactive sessions ran real interactive
**bash 5.2.21** under a pseudo-terminal so the prompt hook,
the jumps and the landings in the transcripts are genuine.
fzf **0.74.5**, also an official release binary, stood behind
the picker. All transcripts live in
`zoxide-lab/transcripts/`; the practice tree they use is
built by `zoxide-lab/make-fixture.sh`.

Run for real, with transcripts as evidence:

- Version, help for every subcommand, and the full text of
  `zoxide init bash`, read as the specification of the hook,
  the jump function and the doctor (t00, and the lab's notes).
- Learning by visiting: an ordinary `cd` tour of the fixture
  tree in an interactive shell, after which `db.zo` exists in
  the data directory; the file was printed and is a compact
  binary in 0.10, not text (t01).
- First jumps and the matching rules: last-component fragment
  (`z web`), a fragment inside the name (`z oice`, and its
  "already in the only match" refusal when standing there),
  case-insensitivity (`z WEB`), keywords in path order
  succeeding and in reverse order failing, both ways, for two
  pairs (`z proj api` / `z api proj`, `z doc inv` /
  `z inv doc`), a real path used directly, `z -`, and bare
  `z` going home (t02).
- The unseen folder: `website-old` exists on disk throughout
  and never appears in any query, because it was never
  visited (t02).
- The frecency contest: `camera/photos` visited six times,
  `phone/photos` twice, interleaved; scores 24.0 and 8.0, and
  `z photos` landing in the six-visit folder (t03). The
  landing itself raised the winner's score to 28.0 by t04,
  as chapter 6 states.
- Asking directly: `query` with `--score`, `--list` and
  `--all`; a no-match query's message and exit code 1;
  `add --score` raising a rank by exactly the amount given;
  `remove` deleting an entry; a folder deleted from disk
  becoming invisible to default queries while `--all` still
  shows its entry (t04).
- Time decay, measured: four entries imported with equal
  rank 10 and last-visit times 30 minutes, 5 hours, 3 days
  and 30 days old scored exactly 40.0, 20.0, 5.0 and 2.5 —
  the ×4 / ×2 / ×0.5 / ×0.25 multipliers, produced by the
  tool's own scoring (t05). The ages were set by importing a
  data file in z's documented format with those timestamps;
  no system clock was altered and the guide says so.
- Aging, driven: with `_ZO_MAXAGE=10`, adds totalling rank
  13 were scaled by 0.9 × 10/13 (rank 8 → 5.5, rank 5 → 3.5);
  the total settled at 9.0; and repeated one-point adds
  pushed two entries below rank 1, after which even `--all`
  queries answered "no match found" for them (t06).
- The interactive picker: `zi photo` in a real terminal
  opened fzf listing both matches with scores; typing
  "phone" narrowed it to one entry and Enter landed the
  shell in `phone/photos`, proven by `pwd` (t07). With fzf
  off the PATH, the same query refused with "could not find
  fzf" and exit 1 (t07).
- Settings in action: `_ZO_EXCLUDE_DIRS` preventing a visit
  from being recorded at all, and the same folder learned
  immediately once the variable was unset; `_ZO_ECHO=1`
  shown to take effect only when set before `zoxide init`
  runs (the generated code differs — the lab diffed the two
  generated functions); `zoxide init bash --cmd cd` making
  `cd api` jump (t08).
- The traps: a shell whose startup file lacks the init line
  answers `z: command not found` while the binary sits on the
  PATH; a folder visited only by a non-interactive
  `bash -c` was never learned (t90).

Documented only — described from the project's documentation,
not run, and the text does not claim otherwise:

- The other shells' setup (zsh, fish, PowerShell, Nushell,
  Elvish, tcsh, Xonsh): each is the same init line in that
  shell's own startup file; only bash was run.
- `--hook prompt` and `--hook none`, and `--no-cmd`: read
  from `zoxide init --help` and the generated code; the
  default `pwd` hook is the one every transcript used.
- `zoxide edit`'s interactive keystrokes. It is a full-screen
  fzf interface, which leaves no transcript to keep; the lab
  verified that it launches, that it requires fzf (its
  refusal without it was captured in t07's evidence), and
  that the operations it performs are the verified `add` and
  `remove`.
- The importers for autojump, fasd, z.lua, zsh-z and atuin:
  the `z` importer was run (t05); the others share its shape.
- `_ZO_RESOLVE_SYMLINKS` and `_ZO_FZF_OPTS`, and zoxide's
  Tab-completion behaviour, are named from the tool's help
  and generated code, not exercised.
- Package-manager and Cargo installs in chapter 3: the lab
  used the official release binary; the routes are the
  project's documented ones and end at the same binary.
- The neighbours in chapter 12 are characterised, not
  benchmarked, and none was installed for this guide.

Fixtures are this guide's own and deliberately generic: a
project folder with three subfolders, documents with two,
two rival folders both named `photos`, a garden, a workshop,
an attic. Their names and contents were invented for the lab
and model no real person's machine, work or life. The
scratch home's path appears in the transcripts as it truly
was on the build machine; reader machines will show their
own paths, and no score, rule or behaviour in the guide
depends on the difference.
