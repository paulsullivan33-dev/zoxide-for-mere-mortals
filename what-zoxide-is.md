# What Zoxide Is

Every folder on your machine has an
address, and `cd` wants all of it, every
time. The project you were editing this
morning lives at
`~/projects/website`, the invoices at
`~/documents/invoices`, and going back
and forth between them means typing both
paths in full, again and again, for as
long as the project lasts. The shell is
a computer: it is very good at
remembering things. Yet the ordinary
`cd` remembers nothing. The remembering
is left to you — or to the up-arrow key,
which is the same memory test with extra
steps.

**Zoxide is a `cd` that remembers.**
Once it is set up, a small hook in your
shell notes every folder you enter, and
a ranking builds up: this folder often,
that one rarely, this other one not
since spring. Afterwards you travel by
intention instead of by address:

```bash
z web          # ~/projects/website
z inv          # ~/documents/invoices
z proj api     # ~/projects/api
```

You type a few letters from the folder's
name — sometimes a fragment or two from
the path — and zoxide takes you to the
folder you most plausibly mean. The
ranking it uses is called **frecency**:
a blend of *frequency* (how often you go
somewhere) and *recency* (how long ago
you last went). Chapter 6 takes that
blend apart; it is small arithmetic, and
once you have seen it, zoxide stops
looking clever and starts looking
obedient — which is better.

## The point to take in early

Zoxide's memory lives in a file: a
database in your home folder holding
every folder you have visited, with a
count and a timestamp for each. In other
words, **it is a diary of where you work
on that machine**, in spirit very like
your shell's command history — and worth
the same moment's thought:

> **Zoxide's database is a record of
> every folder you visit. It sits in your
> home folder, readable by anyone who can
> read your files. Treat it the way you
> treat your shell history: yours, useful,
> and not something to copy around
> carelessly.**

Nothing in this guide needs you to share
that file with anyone. Chapter 11 covers
carrying it to a new machine of your
own, and says the same thing again there,
because that is the moment it matters.

## A first taste, after installing

Chapter 4 performs this for real; the
flavour is:

```bash
cd ~/projects/website     # ordinary cd, once
cd ~/documents/invoices   # and once more
cd ~
z web                     # zoxide takes you back
z inv                     # and there
```

Two visits are a thin memory, and at
first zoxide will feel like a parlour
trick that works on exactly the folders
you just left. Give it a day of ordinary
work. The folders of your actual life
accumulate counts, the ranking becomes
yours rather than alphabetical, and the
trick turns into a habit — most people
who keep zoxide stop being able to say
where their folders live, the way you
stop knowing phone numbers your phone
remembers for you.

Check: after a little use, ask the
database what it thinks of a name
(chapter 7 teaches the asking):

```text
$ zoxide query --list --score photos
  24.0 /home/you/camera/photos
   8.0 /home/you/phone/photos
```

Two folders, one name, and a clear
opinion about which one you mean. That
opinion — where it comes from and how to
correct it — is most of this guide.

## Who it is for

Anyone whose work lives in more than a
handful of folders, which is to say
nearly everyone who uses a terminal for
more than one task: the developer moving
between three checkouts, the
administrator moving between configuration,
logs and home, the maker moving between
designs, prints and notes. The common
thread is repetition — the same journeys,
made daily, retyped daily until now.

## What it is not

Zoxide is not a search. It cannot find a
folder it has never seen you visit, no
matter how well you describe it; for
searching the disk itself, this series'
*Finding Files* guide is the tool, and
chapter 12 compares the two honestly.
It is not a bookmark list: bookmarks are
pinned by hand and stay put, while
zoxide's ranking is fluid — folders rise
as you use them and sink, and eventually
fall off entirely, as you stop (chapter
11). It is not a file manager and shows
you nothing; when you want to *look* at
the candidates rather than leap,
chapter 8's picker is the closest it
comes. And it is not inside your other
programs: `z` is a convenience of your
interactive shell, and chapter 10 shows
the form scripts can use instead.
