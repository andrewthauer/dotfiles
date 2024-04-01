# nvim

Configuration for [neovim](https://neovim.io).

## Overview

This is my personal configuration for neovim so far (always a work in progress).
It is heavily inspired by [LazyVim](https://www.lazyvim.org/) but customized to
my needs.

## Plugins

**Current Plugins**

See [plugins](.config/nvim/lua/plugins) for a list of plugins that are currently
installed.

**Plugins to consider adding**

- [neotest](https://github.com/nvim-neotest/neotest)
- [Mini](https://github.com/echasnovski/mini.nvim)
  - mini.ai
  - mini.files
  - mini.pairs
  - mini.surround

## Resources

- https://neovim.io
- https://www.lazyvim.org/
- https://vimawesome.com

## Vim Cheatsheet

### Vim as a Language

#### Verbs

Verbs are the actions we take, and they can be performed on nouns. Here are some
examples:

- d: delete
- c: change
- y: yank (copy)
- v: visually select (V for line vs. character)

#### Modifiers

Modifiers are used before nouns to describe the way in which you’re going to do
something. Some examples:

- i: inside
- a: around
- NUM: number (e.g.: 1, 2, 10)
- t: searches for something and stops before it
- f: searches for that thing and lands on it
- /: find a string (literal or regex)

#### Nouns

In English, nouns are objects you do something to. They are objects. With Vim
it’s the same. Here are some Vim nouns:

- `w`: word
- `s`: sentence
- `)`: sentence (another way of doing it)
- `p`: paragraph
- `}`: paragraph (another way of doing it)
- `t`: tag (think HTML/XML)
- `b`: block (think programming)

#### Nouns as motion

You can also use nouns as motions, meaning you can move around your content
using them as the size of your jump. We’ll see examples of this below in the
moving section.

#### Building sentences (commands) using this Language

Ok, so we have the various pieces, so how would you build a sentence using them?
Well, just like English, you combine the verbs, modifiers, and nouns in (soon to
be) intuitive ways. Here’s what it looks like:

- `d2w`: Delete two words
- `cis`: Change inside sentence (delete the current one and enter insert mode)
- `yip`: Yank inside paragraph (copy the paragraph you’re in)
- `ct<`: Change to open bracket (change the text from where you are to the next
  open bracket)

Remember, the “to” here was an open bracket, but it could have been anything.
And the syntax for “to” was simply t, so I could have said dt. or yt; for
“delete to the next period”, or “copy to the next semicolon”.

Isn’t that beautiful? Using this thought process turns your text editing into an
intuitive elegance, and like any other language the more you use it the more
naturally it will come to you.

### Global

```bash
:help keyword  # open help for keyword
:o file        # open file
:saveas file   # save file as
:close         # close current panel
:ter[minal]    # opens a terminal
```

### Exiting

```bash
:w               # write (save) the file, but don't exit
:w !sudo tee %   # write out the current file using sudo
:wq or :x or ZZ  # write (save) and quit
:q               # quit (fails if there are unsaved changes)
:q! or ZQ        # quit and throw away unsaved changes
```

### Cursor movement

```bash
h         # move cursor left
j         # move cursor down
k         # move cursor up
l         # move cursor right
M         # move to middle of screen
w         # jump forwards to the start of a word
W         # jump forwards to the start of a word (words can contain punctuation)
e         # jump forwards to the end of a word
E         # jump forwards to the end of a word (words can contain punctuation)
b         # jump backwards to the start of a word
B         # jump backwards to the start of a word (words can contain punctuation)
0         # jump to the start of the line
^         # jump to the first non-blank character of the line
$         # jump to the end of the line
g_        # jump to the last non-blank character of the line
gg        # go to the first line of the document
G         # go to the last line of the document
5G        # go to line 5
fx        # jump to next occurrence of character x
tx        # jump to before next occurrence of character x
}         # jump to next paragraph (or function/block, when editing code)
{         # jump to previous paragraph (or function/block, when editing code)
zz        # center cursor on screen
Ctrl + b  # move back one full screen
Ctrl + f  # move forward one full screen
Ctrl + d  # move forward 1/2 a screen
Ctrl + u  # move back 1/2 a screen
```

### Insert mode - inserting/appending text

```bash
i         # insert before the cursor
I         # insert at the beginning of the line
a         # insert (append) after the cursor
A         # insert (append) at the end of the line
o         # append (open) a new line below the current line
O         # append (open) a new line above the current line
ea        # insert (append) at the end of the word
Esc       # exit insert mode
```

### Editing

```bash
r         # replace a single character
J         # join line below to the current one
cc        # change (replace) entire line
cw        # change (replace) to the start of the next word
ciw       # change (replace) text inside next word
caw       # change (replace) text around next word
ce        # change (replace) to the end of the next word
cb        # change (replace) to the start of the previous word
cf?       # change (replace) next occurrence of character
c0        # change (replace) to the start of the line
c$        # change (replace) to the end of the line
ct?       # change (replace) to the given character
s         # delete character and substitute text
S         # delete line and substitute text (same as cc)
xp        # transpose two letters (delete and paste)
.         # repeat last command
u         # undo
Ctrl + r  # redo
```

### Marking text (visual mode)

```bash
v         # start visual mode, mark lines, then do a command (like y-yank)
V         # start linewise visual mode
o         # move to other end of marked area
O         # move to other corner of block
aw        # mark a word
ab        # a block with ()
aB        # a block with {}
ib        # inner block with ()
iB        # inner block with {}
Esc       # exit visual mode
Ctrl + v  # start visual block mode
```

### Visual commands

```bash
>         # shift text right
<         # shift text left
y         # yank (copy) marked text
d         # delete marked text
~         # switch case
```

### Cut and paste

```bash
yy        # yank (copy) a line
2yy       # yank (copy) 2 lines
yw        # yank (copy) the characters of the word from the cursor position to the start of the next word
y$        # yank (copy) to end of line
p         # put (paste) the clipboard after cursor
P         # put (paste) before cursor
dd        # delete (cut) a line
2dd       # delete (cut) 2 lines
dw        # delete (cut) the characters of the word from the cursor position to the start of the next word
D         # delete (cut) to the end of the line
d$        # delete (cut) to the end of the line
d^        # delete (cut) to the first non-blank character of the line
d0        # delete (cut) to the beginning of the line
x         # delete (cut) character
```

### Search and replace

```bash
/pattern        # search for pattern
?pattern        # search backward for pattern
\vpattern       # 'very magic' pattern: non-alphanumeric characters are interpreted as special regex symbols (no escaping needed)
n               # repeat search in same direction
N               # repeat search in opposite direction
:%s/old/new/g   # replace all old with new throughout file
:%s/old/new/gc  # replace all old with new throughout file with confirmations
:noh            # remove highlighting of search matches
```

### Search in multiple files

```bash
:vimgrep /pattern/ {file}  # search for pattern in multiple files
:cn                        # jump to the next match
:cp                        # jump to the previous match
:copen                     # open a window containing the list of matches
```

### Working with multiple files

```bash
:e file             # edit a file in a new buffer
L or :bnext or :bn  # go to the next buffer
H or :bprev or :bp  # go to the previous buffer
:bd                 # delete a buffer (close a file)
:ls                 # list all open buffers
:sp file            # open a file in a new buffer and split window
:vsp file           # open a file in a new buffer and vertically split window
Ctrl + ws           # split window
Ctrl + ww           # switch windows
Ctrl + wq           # quit a window
Ctrl + wv           # split window vertically
Ctrl + wh           # move cursor to the left window (vertical split)
Ctrl + wl           # move cursor to the right window (vertical split)
Ctrl + wj           # move cursor to the window below (horizontal split)
Ctrl + wk           # move cursor to the window above (horizontal split)
```

### Tabs

```bash
:tabnew or :tabnew file  # open a file in a new tab
Ctrl + wT                # move the current split window into its own tab
gt or :tabnext or :tabn  # move to the next tab
gT or :tabprev or :tabp  # move to the previous tab
<number>gt               # move to tab <number>
:tabmove <number>        # move current tab to the <number>th position (indexed from 0)
:tabclose or :tabc       # close the current tab and all its windows
:tabonly or :tabo        # close all tabs except for the current one
:tabdo command           # run the command on all tabs (e.g. :tabdo q - closes all opened tabs)
```
