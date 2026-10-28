# Installing Zoxide

Zoxide is one small binary, and it is
installed the ways single binaries are:
from your system's packages, from a
release download, or built from source
by Cargo, Rust's package manager. Every
route ends at the same place — a
`zoxide` command on your path — and then
at the step that actually makes the tool:
one line in your shell's startup file.
**Installing the binary alone gives you
nothing to jump with.** The lab used the
release binary; the other routes are the
project's documented ones.

## The binary

The project's releases page offers a
ready-built archive per platform. On a
Linux machine:

```bash
curl -sSfL https://github.com/ajeetdsouza/zoxide/releases/download/v0.10.0/zoxide-0.10.0-x86_64-unknown-linux-musl.tar.gz | tar xz
sudo install -m 755 zoxide /usr/local/bin/
zoxide --version
```

(The project's own install script,
linked from its README, automates the
same fetch-and-place for those who trust
it.) Package managers carry zoxide
widely — `sudo apt install zoxide`,
`sudo dnf install zoxide`,
`sudo pacman -S zoxide`,
`brew install zoxide`,
`winget install zoxide` — usually a
release or two behind, which for a tool
this settled rarely matters. And
`cargo install zoxide --locked` builds
the current release from source.

Check: the lab's download reports itself
(transcript `zoxide-lab/transcripts/t00-version.txt`):

```text
$ zoxide --version
zoxide 0.10.0
```

The version is worth noting because one
visible thing changed recently: in 0.10
the database file is a compact binary
(chapter 2), where older releases used a
text file. Advice written against older
versions — especially anything telling
you to edit the database in a text
editor — should be read with that in
mind.

## The one line

`zoxide init` prints shell code; your
startup file evaluates it, which defines
`z` and `zi` and installs the hook of
chapter 2. For bash, add this to the
**end** of `~/.bashrc`:

```bash
eval "$(zoxide init bash)"
```

End is a requirement, not a tidiness
preference: the hook attaches itself to
the prompt machinery, and a later line
that rebuilds that machinery — a prompt
theme or another tool's init — can knock
it off again. Zoxide's generated code
includes the doctor of chapter 2, which
prints a warning if it finds its hook
missing, and its advice is the same:
*ensure that zoxide is initialized right
at the end of your shell configuration
file*.

Open a new terminal — or run
`source ~/.bashrc` — and check the two
commands exist:

```bash
type z
```

which should answer that `z` is a
function. The other shells are each the
same idea in their own startup file,
taught from the project's documentation
(the lab ran bash only): zsh uses the
same line with `zsh` in `~/.zshrc`; fish
uses `zoxide init fish | source` in its
config; PowerShell adds the output of
`zoxide init powershell` to its profile.
Nushell, Elvish, tcsh and Xonsh are also
supported by `zoxide init`.

## And fzf, if you want the picker

Chapter 8's `zi` hands its candidate
list to **fzf**, a separate program by a
separate project. Zoxide works entirely
without it — only the picker and the
database editor ask for it, and both
refuse with a clear message when it is
absent (the lab captured the refusal in
transcript t07). Install it the same
way: your package manager, or the
release archive from the fzf project.
This series' *fzf for Mere Mortals*
guide covers the finder itself.
