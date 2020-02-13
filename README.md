# clb // Command-Line Bible

A text-independent (shell) version of the CLI in [bontibon/kjv](https://github.com/bontibon/kjv). Instead of forking, now all you need to do is provide a text file (in the appropriate TSV format) and run `make`.

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

## Building

### Preparation

First, clone the repository (we won't `cd` into it just yet).

```
git clone https://github.com/tumut/clb.git
```

To install a CLI through `clb` you'll need to have one or more `.tsv` files in the folder. As examples we shall use the files in my other repository, [coptic-tsv](https://github.com/tumut/coptic-tsv), which we will clone and copy the files into `clb/`. Afterwards we can change directories.

```
git clone https://github.com/tumut/coptic-tsv
cp coptic-tsv/*.tsv clb/
cd clb
```

### Makefile

All building is done through the Makefile. You can:

 *  Build all possible CLIs (this is the default option). Installation will still be required.
    ```
    make
    ```
    ```
    make build
    ```

 *  Build CLIs individually.
    ```
    make build-boh
    make build-cop
    make build-sah
    ```

 *  Clean builds entirely or individually. Simply removes the files in `$BUILD_DIR/` and doesn't uninstall.
    ```
    make clean
    ```
    ```
    make clean-boh
    make clean-cop
    make clean-sah
    ```

 *  Install CLIs individually, using the filename sans extension as identifier (e.g. `boh.tsv` &rarr; `boh`). Will automatically build it if required.
    ```
    sudo make install-boh
    sudo make install-cop
    sudo make install-sah
    ```

 *  Install all built CLIs at once.
    ```
    sudo make install
    ```

 *  Uninstall all installed CLIs. Will uninstall only those that can be found both in `$BUILD_DIR/` and `$INSTALL_DIR/`, so `clean`ing can affect it.
    ```
    sudo make uninstall
    ```

 *  Uninstall CLIs individually. Useful if you `clean`ed beforehand.
    ```
    sudo make uninstall-boh
    sudo make uninstall-cop
    sudo make uninstall-sah
    ```

## License

Public Domain
