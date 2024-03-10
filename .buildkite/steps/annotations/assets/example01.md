<!-- TODO: Better nested alignment by removing margin next to details chevron '::marker' -->

<p class="h1 pb1">👋 Welcome to Buildkite Annotations</p>

<p>Let's take a look at what you can do with annotations...</p>

---

<!-- <p class="h3 pb1">:terminal: When we want to show some code</p> -->

We can use `inline code` to show code inside a sentence

Or a basic code block

```
function logSomething(something) {
  console.log("Something", something);
}
```

Or a fancy terminal code block

```term
\x1b[31mFailure/Error:\x1b[0m \x1b[32mexpect\x1b[0m(new_item.created_at).to eql(now)

\x1b[31m  expected: 2018-06-20 19:42:26.290538462 +0000\x1b[0m
\x1b[31m       got: 2018-06-20 19:42:26.290538000 +0000\x1b[0m

\x1b[31m  (compared using eql?)\x1b[0m
```

---

<!-- <p class="h3 pb1">🎨 For styling fonts</p> -->

<p class="">
  <span class="h6">We can </span>
  <span class="h5">use one</span>
  <span class="h4">of many</span>
  <span class="h3">different</span>
  <span class="h2">font</span>
  <span class="h1">sizes</span>
</p>

<p class="">
  <!-- these colors work -->
  <span class="regular">We can use </span>
  <span class="bold black">black</span>
  <span class="bold gray">gray</span>
  <span class="bold blue">blue</span>
  <span class="bold green">green</span>
  <span class="bold orange">orange</span>
  <span class="regular">or</span>
  <span class="bold red">red</span>
  <!-- these colors don't work -->
  <!-- <span class="silver">.silver</span> -->
  <!-- <span class="white">.white</span> -->
  <!-- <span class="aqua">.aqua</span> -->
  <!-- <span class="navy">.navy</span> -->
  <!-- <span class="teal">.teal</span> -->
  <!-- <span class="olive">.olive</span> -->
  <!-- <span class="lime">.lime</span> -->
  <!-- <span class="yellow">.yellow</span> -->
  <!-- <span class="fuchsia">.fuchsia</span> -->
  <!-- <span class="purple">.purple</span> -->
  <!-- <span class="maroon">.maroon</span> -->
  <!-- <span class="color-inherit">.color-inherit</span> -->
</p>

<p class="">
  <span class="regular">We can use </span>
  <span class="bold">bold</span>
  <span class="regular">, </span>
  <span class="italic">italic</span>
  <span class="regular">, </span>
  <span class="underline">underline</span>
  <span class="regular">, </span>
  <span class="caps">or all caps</span>
</p>

<p class="left-align">Text can be left-aligned</p>
<p class="center">centered</p>
<p class="right-align">or right-aligned</p>

---

<!-- <p class="h3 pb1">:white_check_mark: We can use tables</p> -->

We can use tables

<div class="flex h6 overflow-scroll">
  <div class="flex-none">
    <table class="border rounded">
      <thead class="bold">
        <tr>
          <th>Artist</th> <th>Album</th> <th>Release Date</th>
        </tr>
      </thead>
      <tbody class="regular">
        <tr> <td>Huey Lewis and the News</td> <td>Sports</td> <td>1983</td> </tr>
        <tr> <td>Phil Collins</td> <td>No Jacket Required</td> <td>1985</td> </tr>
        <tr> <td>Peter Gabriel</td> <td>So</td> <td>1986</td> </tr>
      </tbody>
    </table>
  </div>
</div>

---

We can display images

<details class="pt1">
  <summary class="h4"><span class="pl1">Expand this section to see image options...</span></summary>
  <div class="pl3 mb1">
    <img class="" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" width="128" height="128" />
    <img class="rounded" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" width="128" height="128" />
    <img class="rounded" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" width="64" height="64" />
    <img class="rounded" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" width="32" height="32" />
    <img class="rounded" src="artifact://assets/man.gif" alt="man-nodding" width="164" />
  </div>
</details>

---

<!-- <p class="h3 pb1">:white_check_mark: We can expand/colllapse sections</p> -->

Sections can be expanded and collapsed

<details class="pt1">
  <summary class="h4"><span class="pl1">Expand this section to see font-size options...</span></summary>
  <div class="pl3">
    <p class="h1">Heading 1</p>
    <p class="h2">Heading 2</p>
    <p class="h3">Heading 3</p>
    <p class="h4">Heading 4</p>
    <p class="h5">Heading 5</p>
    <p class="h6">Heading 6</p>
  </div>
</details>

<details class="pt1">
  <summary class="h4"><span class="pl1">Expand this section to see typography options...</span></summary>
  <div class="pl3 mb1">
    <p class="h5 mb1 regular">Regular text</p>
    <p class="h5 mb1 bold">Bold text</p>
    <p class="h5 mb1 italic">Italic text</p>
    <p class="h5 mb1 underline">Underline text</p>
    <p class="h5 mb1 caps">All caps text</p>
    <p class="h5 mb0 left-align rounded">Left align text</p>
    <p class="h5 mb0 center rounded">Center text</p>
    <p class="h5 mb2 right-align rounded">Right align text</p>
    <p class=""><span class="bold">This is a normal paragraph </span>bacon ipsum dolor sit amet chuck prosciutto landjaeger ham hock filet mignon shoulder hamburger pig venison.</p>
    <!-- justify works on wrap, resize browser window to see -->
    <p class="justify"><span class="bold">This Paragraph of text will be justified, resize the browser window to see it in action! </span>bacon ipsum dolor sit amet chuck prosciutto landjaeger ham hock filet mignon shoulder hamburger pig venison.</p>
    <!-- truncate works, resize browser window to see -->
    <p class="truncate"><span class="bold">This Paragraph of text will be truncated, resize the browser window to see it in action! </span>bacon ipsum dolor sit amet chuck prosciutto landjaeger ham hock filet mignon shoulder hamburger pig venison.</p>
  </div>
</details>

<details class="pt1">
  <summary class="h4"><span class="pl1">Expand this section to see table options...</span></summary>
  <div class="pl3">

  <p class="h4">h6 table</p>

  <div class="h6 regular overflow-scroll">
    <table class="table-light">
      <thead>
        <tr>
          <th class="px1 py2">Artist</th> <th>Album</th> <th>Release Date</th>
        </tr>
      </thead>
      <tbody class="mxn2 px1">
        <tr class="mxn2 px1"> <td>Huey Lewis and the News</td> <td>Sports</td> <td>1983</td> </tr>
        <tr> <td class="mxn2 px1">Phil Collins</td> <td>No Jacket Required</td> <td>1985</td> </tr>
        <tr> <td>Peter Gabriel</td> <td class="mxn2">So</td> <td>1986</td> </tr>
      </tbody>
    </table>
  </div>

  <p class="h4">h6 table with underline header and rounded border</p>

  <div class="flex h6 overflow-scroll">
    <div class="flex-none">
      <table class="border rounded">
        <thead class="bold underline">
          <tr>
            <th>Artist</th> <th>Album</th> <th>Release Date</th>
          </tr>
        </thead>
        <tbody class="regular">
          <tr> <td>Huey Lewis and the News</td> <td>Sports</td> <td>1983</td> </tr>
          <tr> <td>Phil Collins</td> <td>No Jacket Required</td> <td>1985</td> </tr>
          <tr> <td>Peter Gabriel</td> <td>So</td> <td>1986</td> </tr>
        </tbody>
      </table>
    </div>
  </div>

  </div>
</details>

<details class="pt1">
  <summary class="h4"><span class="pl1">Expand this section to see image options...</span></summary>
  <div class="pl3 mb1">
    <img class="" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" width="128" height="128" />
    <img class="rounded" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" width="128" height="128" />
    <img class="rounded" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" width="64" height="64" />
    <img class="rounded" src="https://pbs.twimg.com/profile_images/1709434079639404544/yqsDuoQp_400x400.png" width="32" height="32" />
    <img class="rounded" src="artifact://assets/man.gif" alt="man-nodding" width="164" />
  </div>
</details>

---

<blockquote class="py1 h4 bold">this is a h4 bold blockquote</blockquote>
<blockquote class="py1 h4">this is a h4 blockquote</blockquote>
<blockquote class="py1 h4 regular">this is a h4 regular blockquote</blockquote>
<blockquote class="py1 h4 regular italic">this is a h4 regular italic blockquote</blockquote>
<blockquote class="py1 h5">this is a h5 blockquote</blockquote>
<blockquote class="py1 h6">this is a h6 blockquote</blockquote>

<!-- <div class="h4 p2 border rounded">
  This is a simple box
</div>

<div class="flex">
  <div class="flex-none">
    <div class="h4 p2 border rounded">
      This is another simple box
    </div>
  </div>
</div> -->

<details class="pt1">
  <summary class="h4"><span class="pl1">Expand this section to see options for displaying code...</span></summary>
  <div class="pl3 mb1">
    <p class="h4">We can display <code>inline code</code> inside a sentence.</p>
    <div>
      <pre><code>or use a
  code
  block</code></pre>
    </div>

    <p class="h4">We can display <code>inline code</code> inside a sentence.</p>
    <div>
      <pre class="term"><code><span class="term-fg31">Failure/Error:</span> <span class="term-fg32">expect</span>(new_item.created_at).to eql(now)
        &nbsp;
        <span class="term-fg31">  expected: 2018-06-20 19:42:26.290538462 +0000</span>
        <span class="term-fg31">       got: 2018-06-20 19:42:26.290538000 +0000</span>
        &nbsp;
        <span class="term-fg31">  (compared using eql?)</span></code></pre>
    </div>

  </div>
</details>

<!-- <div class="my4">
  <p></p>
  <p></p>
  <p></p>
</div> -->
 <!-- nowrap does fuck all -->
<!-- <p class="nowrap">No wrap text bacon ipsum dolor sit amet chuck prosciutto landjaeger ham hock filet mignon shoulder hamburger pig venison.</p> -->
<!-- <p class="font-family-inherit">Font Family Inherit</p> -->
<!-- <p class="font-size-inherit">Font Size Inherit</p> -->
<!-- <a class="text-decoration-none">Text Decoration None</a> -->

<!-- <ul class="ul">
  <li class="li">class list</li>
  <li class="li">first</li>
  <li class="li">second</li>
  <li class="li">third</li>
</ul> -->

<!-- ## Is this a markdown list?

- markdown unordered list one
  - markdown unordered list two
    - markdown unordered list three

## Or is this a markdown list?

1. markdown ordered list one
1. markdown ordered list two
1. markdown ordered list three

<ul>
  <li>list</li>
  <li>first</li>
  <li>second</li>
  <li>third</li>
</ul>

<ul class="list-reset">
  <li>List Reset</li>
  <li>Removes bullets</li>
  <li>Removes numbers</li>
  <li>Removes padding</li>
</ul>

<ul class="list-reset">
  <li class="inline-block mr1">Lists</li>
  <li class="inline-block mr1">can</li>
  <li class="inline-block mr1">be</li>
  <li class="inline-block mr1">in-line</li>
</ul>

<div class="inline">inline</div>
<div class="inline-block">inline-block</div>
<a href="#" class="block">block</a> -->

<div class="table border">
  <div class="table-cell border">table-cell</div>
  <div class="table-cell border rounded">table-cell</div>
  <div class="table-cell rounded">table-cell</div>
</div>

<!-- <div class="clearfix border">
  <div class="left border">clearfix left border</div>
  <div class="right border">clearfix right border</div>
</div> -->

<!-- <div class="col-3">
  <img class="fit" src="http://d2v52k3cl9vedd.cloudfront.net/assets/images/placeholder.svg" />
  <img class="fit" src="http://d2v52k3cl9vedd.cloudfront.net/assets/images/placeholder.svg" />
  <img class="fit" src="http://d2v52k3cl9vedd.cloudfront.net/assets/images/placeholder.svg" />
</div> -->
<!--
<p class="max-width-1">Bacon ipsum dolor sit amet chuck prosciutto landjaeger ham hock filet mignon shoulder hamburger pig venison.</p>
<p class="max-width-2">Bacon ipsum dolor sit amet chuck prosciutto landjaeger ham hock filet mignon shoulder hamburger pig venison.</p>
<p class="max-width-3">Bacon ipsum dolor sit amet chuck prosciutto landjaeger ham hock filet mignon shoulder hamburger pig venison.</p>
<p class="max-width-4">Bacon ipsum dolor sit amet chuck prosciutto landjaeger ham hock filet mignon shoulder hamburger pig venison.</p>
-->

<div class="col-6 p2 border-box border">.border-box</div>

<div class="clearfix mb2 border">
  <div class="left p2 mr1 border">Image</div>
  <div class="overflow-hidden">
    <p><b>Body</b> Bacon ipsum dolor sit amet chuck prosciutto landjaeger ham hock filet mignon shoulder hamburger pig venison.</p>
  </div>
</div>

<div class="mb2 border">
  <div class="left p2 mr1 border">Image</div>
  <div class="right p2 ml1 border">Image</div>
  <div class="overflow-hidden">
    <p><b>Body</b> Bacon ipsum dolor sit amet chuck prosciutto landjaeger ham hock filet mignon shoulder hamburger pig venison.</p>
  </div>
</div>

<div class="overflow-auto">
  <div class="table rounded">
    <div class="table-cell"><h1>Hamburger</h1></div>
    <div class="table-cell align-baseline">.align-baseline</div>
    <div class="table-cell align-top">.align-top</div>
    <div class="table-cell align-middle">.align-middle</div>
    <div class="table-cell align-bottom">.align-bottom</div>
  </div>
</div>

<!-- <h1 class="h1 m0">h1 no margin</h1>
<h1 class="h1 mt0">h1 no margin top</h1>
<h1 class="h1 mb0">h1 no margin bottom</h1> -->

<!-- <div class="mxn1">
  <div class="m1">Hamburger spacing mxn1 m1</div>
  <div class="m1">Hamburger spacing mxn1 m1</div>
  <div class="m1">Hamburger spacing mxn1 m1</div>
</div> -->

<!-- <img src="http://d2v52k3cl9vedd.cloudfront.net/assets/images/placeholder-square.svg"
  width="96"
  height="96"
  class="block mx-auto" />

<div class="flex">
  <div class="ml-auto">Hamburger</div>
  <div>Hot Dog</div>
</div> -->

<!-- <div class="overflow-hidden border rounded">
  <div class="p2 bold white bg-blue">
    Panel Header
  </div>
  <div class="p2">
    Panel Body
  </div>
  <div class="p2 bg-silver">
    Panel Footer
  </div>
</div> -->

<!-- <div class="fixed top-0 left-0 right-0 p2 white bg-black">
  Fixed bar
</div>

<div class="fixed z2 top-0 left-0 right-0 p2 white bg-black">
  Fixed bar
</div> -->

<!-- <div class="clearfix border">
  <div class="sm-col sm-col-6 border">.sm-col.sm-col-6</div>
  <div class="sm-col sm-col-6 border">.sm-col.sm-col-6</div>
</div> -->

<!-- <div class="clearfix mxn2 border">
  <div class="sm-col sm-col-6 md-col-5 lg-col-4 px2"><div class="border">.px2</div></div>
  <div class="sm-col sm-col-6 md-col-7 lg-col-8 px2"><div class="border">.px2</div></div>
</div>

<div class="clearfix border">
  <div class="sm-col p2 border">.sm-col</div>
  <div class="overflow-hidden border">.overflow-hidden</div>
</div>

<div class="flex border">
  <div class="flex-auto border">Hamburger</div>
  <div class="border">Hot Dog</div>
</div>

<div class="flex flex-wrap content-start border" style="min-height: 128px">
  <div class="col-6 border">Hamburger</div>
  <div class="col-6 border">Hamburger</div>
  <div class="col-6 border">Hamburger</div>
  <div class="col-6 border">Hamburger</div>
</div> -->

<!-- <div class="p1 m1 border">.border</div>
<div class="p1 m1 border-top">.border-top</div>
<div class="p1 m1 border-right">.border-right</div>
<div class="p1 m1 border-bottom">.border-bottom</div>
<div class="p1 m1 border-left">.border-left</div> -->

<!-- <div class="h3">Image with rounded border radii </div> -->
<!-- <img class="rounded" src="http://d2v52k3cl9vedd.cloudfront.net/assets/images/placeholder-square.svg" width="64" height="64" /> -->
<!-- the below don't work... -->
<!-- <img class="circle" src="http://d2v52k3cl9vedd.cloudfront.net/assets/images/placeholder-square.svg" width="64" height="64" /> -->
<!-- <img class="rounded-top" src="http://d2v52k3cl9vedd.cloudfront.net/assets/images/placeholder-square.svg" width="64" height="64" /> -->
<!-- <img class="rounded-right" src="http://d2v52k3cl9vedd.cloudfront.net/assets/images/placeholder-square.svg" width="64" height="64" /> -->
<!-- <img class="rounded-bottom" src="http://d2v52k3cl9vedd.cloudfront.net/assets/images/placeholder-square.svg" width="64" height="64" /> -->
<!-- <img class="rounded-left" src="http://d2v52k3cl9vedd.cloudfront.net/assets/images/placeholder-square.svg" width="64" height="64" /> -->

<!-- backgournd colors don't work -->
<!-- <div class="center p1 white bg-black">.bg-black</div>
<div class="center p1 bg-gray">.bg-gray</div>
<div class="center p1 bg-silver">.bg-silver</div>
<div class="center p1 bg-white">.bg-white</div>
<div class="center p1 bg-aqua">.bg-aqua</div>
<div class="center p1 bg-blue">.bg-blue</div>
<div class="center p1 white bg-navy">.bg-navy</div>
<div class="center p1 bg-teal">.bg-teal</div>
<div class="center p1 bg-green">.bg-green</div>
<div class="center p1 bg-olive">.bg-olive</div>
<div class="center p1 bg-lime">.bg-lime</div>
<div class="center p1 bg-yellow">.bg-yellow</div>
<div class="center p1 bg-orange">.bg-orange</div>
<div class="center p1 bg-red">.bg-red</div>
<div class="center p1 bg-fuchsia">.bg-fuchsia</div>
<div class="center p1 bg-purple">.bg-purple</div>
<div class="center p1 white bg-maroon">.bg-maroon</div>
<div class="center p1 bg-darken-1">.bg-darken-1</div>
<div class="center p1 bg-darken-2">.bg-darken-2</div>
<div class="center p1 bg-darken-3">.bg-darken-3</div>
<div class="center p1 bg-darken-4">.bg-darken-4</div>
<div class="bg-black">
  <div class="center p1 white bg-lighten-1">.bg-lighten-1</div>
  <div class="center p1 white bg-lighten-2">.bg-lighten-2</div>
  <div class="center p1 white bg-lighten-3">.bg-lighten-3</div>
  <div class="center p1 white bg-lighten-4">.bg-lighten-4</div>
</div> -->

<!-- this shit doesn't work -->
<!-- <label>Input</label>
<input type="text" class="block col-12 field">
<label>Select</label>
<select class="block col-12 field">

  <option value="1">One</option>
  <option value="2">Two</option>
  <option value="3">Three</option>
</select>
<label>Textarea</label>
<textarea class="block col-12 field"></textarea>

<label>Normal</label>
<input type="text" class="block col-12 field">
<label>Disabled</label>
<input type="text" class="block col-12 field" disabled value="This is disabled">
<label>Read Only</label>
<input type="text" class="block col-12 field" readonly value="This is read-only">
<label>Required</label>
<input type="text" class="block col-12 field" required>
<label>.is-focused</label>
<input type="text" class="block col-12 field is-focused">
<label>.is-disabled</label>
<input type="text" class="block col-12 field is-disabled">
<label>.is-read-only</label>
<input type="text" class="block col-12 field is-read-only">
<label>Success</label>
<input type="text" class="block col-12 field is-success">
<label>Warning</label>
<input type="text" class="block col-12 field is-warning">
<label>Error</label>
<input type="text" class="block col-12 field is-error"> -->

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

```
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
