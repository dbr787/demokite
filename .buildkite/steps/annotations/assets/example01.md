<p class="h1">Pastrami 1</p>
<p class="h2">Pastrami 2</p>
<p class="h3">Pastrami 3</p>
<p class="h4">Pastrami 4</p>
<p class="h5">Pastrami 5</p>
<p class="h6">Pastrami 6</p>

<h1 class="h1">class h1 override of h1</h1>
<h2 class="h1">class h1 override of h2</h2>
<h3 class="h1">class h1 override of h3</h3>
<h4 class="h1">class h1 override of h4</h4>

<h1 class="h2">class h2 override of h1</h1>
<h2 class="h2">class h2 override of h2</h2>
<h3 class="h2">class h2 override of h3</h3>
<h4 class="h2">class h2 override of h4</h4>

<h1 class="h3">class h3 override of h1</h1>
<h2 class="h3">class h3 override of h2</h2>
<h3 class="h3">class h3 override of h3</h3>
<h4 class="h3">class h3 override of h4</h4>

<h1 class="h4">class h4 override of h1</h1>
<h2 class="h4">class h4 override of h2</h2>
<h3 class="h4">class h4 override of h3</h3>
<h4 class="h4">class h4 override of h4</h4>

<h1 class="m0">h1 no margin</h1>
<h1 class="mt0">h1 no margin top</h1>
<h1 class="mb0">h1 no margin bottom</h1>

<p class="bold">Bold</p>
<p class="regular">Regular</p>
<p class="italic">Italic</p>
<p class="caps">Caps</p>
<p class="left-align">Left align</p>
<p class="center">Center</p>
<p class="right-align">Right align</p>
<p class="justify">Justify Bacon ipsum dolor sit amet chuck prosciutto landjaeger ham hock filet mignon shoulder hamburger pig venison.</p>
<p class="nowrap">No wrap</p>
<p class="underline">Underline</p>
<p class="truncate">Truncate</p>
<p class="font-family-inherit">Font Family Inherit</p>
<p class="font-size-inherit">Font Size Inherit</p>
<a class="text-decoration-none">Text Decoration None</a>

<ul class="list-reset">
  <li>List Reset</li>
  <li>Removes bullets</li>
  <li>Removes numbers</li>
  <li>Removes padding</li>
</ul>

<ul class="list-reset">
  <li class="inline-block mr1">Half-Smoke</li>
  <li class="inline-block mr1">Kielbasa</li>
  <li class="inline-block mr1">Bologna</li>
  <li class="inline-block mr1">Prosciutto</li>
</ul>

---

That's nice

<details>
  <summary>Click here to see a GIF...</summary>

<img src="artifact://assets/man.gif" alt="man" height=250 >

</details>

---

We can link to <a href="artifact://assets/example01.md">an artifact!</a>

---

<details>
  <summary>Click here to see some code...</summary>

### A traditional code block

```js
function logSomething(something) {
  console.log("Something", something);
}
```

### A fancy terminal code block

```term
\x1b[31mFailure/Error:\x1b[0m \x1b[32mexpect\x1b[0m(new_item.created_at).to eql(now)

\x1b[31m  expected: 2018-06-20 19:42:26.290538462 +0000\x1b[0m
\x1b[31m       got: 2018-06-20 19:42:26.290538000 +0000\x1b[0m

\x1b[31m  (compared using eql?)\x1b[0m
```

</details>

---

**This is bold text**

_This is italic text_

~~This is strikethrough text~~

This is <sub>subscript</sub> text

This is <sup>superscript</sup> text

---

### Blockquotes

> Blockquotes can also be nested...
>
> > ...by using additional greater-than signs right next to each other...
> >
> > > ...or with spaces between arrows.

#### Lists

Unordered

- Create a list by starting a line with `+`, `-`, or `*`
- Sub-lists are made by indenting 2 spaces:
  - Marker character change forces new list start:
    - Ac tristique libero volutpat at
    * Facilisis in pretium nisl aliquet
    - Nulla volutpat aliquam velit
- Very easy!

Ordered

1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
3. Integer molestie lorem at massa

4. You can use sequential numbers...
5. ...or keep all the numbers as `1.`

Start numbering with offset:

57. foo
1. bar

## Code

Inline `code`

Indented code

    // Some comments
    line 1 of code
    line 2 of code
    line 3 of code

Block code "fences"

```
Sample text here...
```

Syntax highlighting

```js
var foo = function (bar) {
  return bar++;
};

console.log(foo(5));
```

## Tables

| Option | Description                                                               |
| ------ | ------------------------------------------------------------------------- |
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default.    |
| ext    | extension to be used for dest files.                                      |

Right aligned columns

| Option |                                                               Description |
| -----: | ------------------------------------------------------------------------: |
|   data | path to data files to supply the data that will be passed into templates. |
| engine |    engine to be used for processing templates. Handlebars is the default. |
|    ext |                                      extension to be used for dest files. |

## Links

[link text](http://dev.nodeca.com)

[link with title](http://nodeca.github.io/pica/demo/ "title text!")

Autoconverted link https://github.com/nodeca/pica (enable linkify to see)

## Images

![Minion](https://octodex.github.com/images/minion.png)
![Stormtroopocat](https://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")

Like links, Images also have a footnote style syntax

![Alt text][id]

With a reference later in the document defining the URL location:

[id]: https://octodex.github.com/images/dojocat.jpg "The Dojocat"

## Plugins

The killer feature of `markdown-it` is very effective support of
[syntax plugins](https://www.npmjs.org/browse/keyword/markdown-it-plugin).

### [Emojies](https://github.com/markdown-it/markdown-it-emoji)

> Classic markup: :wink: :cry: :laughing: :yum:
>
> Shortcuts (emoticons): :-) :-( 8-) ;)

see [how to change output](https://github.com/markdown-it/markdown-it-emoji#change-output) with twemoji.

### [Subscript](https://github.com/markdown-it/markdown-it-sub) / [Superscript](https://github.com/markdown-it/markdown-it-sup)

- 19^th^
- H~2~O

### [\<ins>](https://github.com/markdown-it/markdown-it-ins)

++Inserted text++

### [\<mark>](https://github.com/markdown-it/markdown-it-mark)

==Marked text==

### [Footnotes](https://github.com/markdown-it/markdown-it-footnote)

Footnote 1 link[^first].

Footnote 2 link[^second].

Inline footnote^[Text of inline footnote] definition.

Duplicated footnote reference[^second].

[^first]: Footnote **can have markup**

    and multiple paragraphs.

[^second]: Footnote text.

### [Definition lists](https://github.com/markdown-it/markdown-it-deflist)

Term 1

: Definition 1
with lazy continuation.

Term 2 with _inline markup_

: Definition 2

        { some code, part of Definition 2 }

    Third paragraph of definition 2.

_Compact style:_

Term 1
~ Definition 1

Term 2
~ Definition 2a
~ Definition 2b

### [Abbreviations](https://github.com/markdown-it/markdown-it-abbr)

This is HTML abbreviation example.

It converts "HTML", but keep intact partial entries like "xxxHTMLyyy" and so on.

\*[HTML]: Hyper Text Markup Language

### [Custom containers](https://github.com/markdown-it/markdown-it-container)

::: warning
_here be dragons_
:::
