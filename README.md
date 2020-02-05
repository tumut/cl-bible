# cl-bible // Command-Line Bible

A text-independent version of the CLI in [bontibon/kjv](https://github.com/bontibon/kjv). Instead of forking, now all you need to do is provide a text file (in the appropriate TSV format) and run `make`.

## Usage

    usage: ./kjv [flags] [reference...]

      -l      list books
      -W      no line wrap
      -h      show help

      Reference types:
          <Book>
              Individual book
          <Book>:<Chapter>
              Individual chapter of a book
          <Book>:<Chapter>:<Verse>[,<Verse>]...
              Individual verse(s) of a specific chapter of a book
          <Book>:<Chapter>-<Chapter>
              Range of chapters in a book
          <Book>:<Chapter>:<Verse>-<Verse>
              Range of verses in a book chapter
          <Book>:<Chapter>:<Verse>-<Chapter>:<Verse>
              Range of chapters and verses in a book

          /<Search>
              All verses that match a pattern
          <Book>/<Search>
              All verses in a book that match a pattern
          <Book>:<Chapter>/<Search>
              All verses in a chapter of a book that match a pattern

## Build

First, clone the repository.

```
git clone https://github.com/tumut/cl-bible.git
```

To install a CLI through `cl-bible` you'll need to have one or more `.tsv` files in `cl-bible`'s folder. We shall use [Andrew-William-Smith/drb](https://github.com/Andrew-William-Smith/drb) and [LukeSmithxyz/vul](https://github.com/LukeSmithxyz/vul) as examples, since they inspired this fork.

```
git clone https://github.com/Andrew-William-Smith/drb.git
git clone https://github.com/LukeSmithxyz/vul.git
cd cl-bible
cp ../drb/drb.tsv .
cp ../vul/vul.tsv .
```

We can install and uninstall all CLIs at once.

```
sudo make install
sudo make uninstall
```

We can also install CLIs individually, just use the filename as an identifier (sans suffix, e.g. `vul.tsv` -> `vul`).

```
sudo make install-drb
sudo make install-vul
```

## License

Public domain
