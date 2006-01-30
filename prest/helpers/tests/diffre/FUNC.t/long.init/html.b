<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="generator" content="Docutils 0.3.1: http://docutils.sourceforge.net/" />
<title>reStructuredText Markup Specification</title>
<meta name="author" content="David Goodger" />
<meta name="date" content="2003-12-30" />
<meta name="copyright" content="This document has been placed in the public domain." />
<link rel="stylesheet" href="../../tools/stylesheets/default.css" type="text/css" />
</head>
<body>
<div class="document" id="restructuredtext-markup-specification">
<h1 class="title">reStructuredText Markup Specification</h1>
<table class="docinfo" frame="void" rules="none">
<col class="docinfo-name" />
<col class="docinfo-content" />
<tbody valign="top">
<tr><th class="docinfo-name">Author:</th>
<td>David Goodger</td></tr>
<tr><th class="docinfo-name">Contact:</th>
<td><a class="first last reference" href="mailto:goodger&#64;users.sourceforge.net">goodger&#64;users.sourceforge.net</a></td></tr>
<tr><th class="docinfo-name">Revision:</th>
<td>1.54</td></tr>
<tr><th class="docinfo-name">Date:</th>
<td>2003-12-30</td></tr>
<tr><th class="docinfo-name">Copyright:</th>
<td>This document has been placed in the public domain.</td></tr>
</tbody>
</table>
<div class="note">
<p class="admonition-title">Note</p>
This document is a detailed technical specification; it is not a
tutorial or a primer.  If this is your first exposure to
reStructuredText, please read <a class="reference" href="../../docs/rst/quickstart.html">A ReStructuredText Primer</a> and the
<a class="reference" href="../../docs/rst/quickref.html">Quick reStructuredText</a> user reference first.</div>
<p><a class="reference" href="http://docutils.sourceforge.net/rst.html">reStructuredText</a> is plaintext that uses simple and intuitive
constructs to indicate the structure of a document.  These constructs
are equally easy to read in raw and processed forms.  This document is
itself an example of reStructuredText (raw, if you are reading the
text file, or processed, if you are reading an HTML document, for
example).  The reStructuredText parser is a component of <a class="reference" href="http://docutils.sourceforge.net/">Docutils</a>.</p>
<p>Simple, implicit markup is used to indicate special constructs, such
as section headings, bullet lists, and emphasis.  The markup used is
as minimal and unobtrusive as possible.  Less often-used constructs
and extensions to the basic reStructuredText syntax may have more
elaborate or explicit markup.</p>
<p>reStructuredText is applicable to documents of any length, from the
very small (such as inline program documentation fragments, e.g.
Python docstrings) to the quite large (this document).</p>
<p>The first section gives a quick overview of the syntax of the
reStructuredText markup by example.  A complete specification is given
in the <a class="reference" href="#syntax-details">Syntax Details</a> section.</p>
<p><a class="reference" href="#literal-blocks">Literal blocks</a> (in which no markup processing is done) are used for
examples throughout this document, to illustrate the plaintext markup.</p>
<div class="contents topic" id="contents">
<p class="topic-title"><a name="contents">Contents</a></p>
<ul class="simple">
<li><a class="reference" href="#quick-syntax-overview" id="id17" name="id17">Quick Syntax Overview</a></li>
<li><a class="reference" href="#syntax-details" id="id18" name="id18">Syntax Details</a><ul>
<li><a class="reference" href="#whitespace" id="id19" name="id19">Whitespace</a><ul>
<li><a class="reference" href="#blank-lines" id="id20" name="id20">Blank Lines</a></li>
<li><a class="reference" href="#indentation" id="id21" name="id21">Indentation</a></li>
</ul>
</li>
<li><a class="reference" href="#escaping-mechanism" id="id22" name="id22">Escaping Mechanism</a></li>
<li><a class="reference" href="#reference-names" id="id23" name="id23">Reference Names</a></li>
<li><a class="reference" href="#document-structure" id="id24" name="id24">Document Structure</a><ul>
<li><a class="reference" href="#document" id="id25" name="id25">Document</a></li>
<li><a class="reference" href="#sections" id="id26" name="id26">Sections</a></li>
<li><a class="reference" href="#transitions" id="id27" name="id27">Transitions</a></li>
</ul>
</li>
<li><a class="reference" href="#body-elements" id="id28" name="id28">Body Elements</a><ul>
<li><a class="reference" href="#paragraphs" id="id29" name="id29">Paragraphs</a></li>
<li><a class="reference" href="#bullet-lists" id="id30" name="id30">Bullet Lists</a></li>
<li><a class="reference" href="#enumerated-lists" id="id31" name="id31">Enumerated Lists</a></li>
<li><a class="reference" href="#definition-lists" id="id32" name="id32">Definition Lists</a></li>
<li><a class="reference" href="#field-lists" id="id33" name="id33">Field Lists</a><ul>
<li><a class="reference" href="#bibliographic-fields" id="id34" name="id34">Bibliographic Fields</a></li>
<li><a class="reference" href="#rcs-keywords" id="id35" name="id35">RCS Keywords</a></li>
</ul>
</li>
<li><a class="reference" href="#option-lists" id="id36" name="id36">Option Lists</a></li>
<li><a class="reference" href="#literal-blocks" id="id37" name="id37">Literal Blocks</a><ul>
<li><a class="reference" href="#indented-literal-blocks" id="id38" name="id38">Indented Literal Blocks</a></li>
<li><a class="reference" href="#quoted-literal-blocks" id="id39" name="id39">Quoted Literal Blocks</a></li>
</ul>
</li>
<li><a class="reference" href="#block-quotes" id="id40" name="id40">Block Quotes</a></li>
<li><a class="reference" href="#doctest-blocks" id="id41" name="id41">Doctest Blocks</a></li>
<li><a class="reference" href="#tables" id="id42" name="id42">Tables</a><ul>
<li><a class="reference" href="#grid-tables" id="id43" name="id43">Grid Tables</a></li>
<li><a class="reference" href="#simple-tables" id="id44" name="id44">Simple Tables</a></li>
</ul>
</li>
<li><a class="reference" href="#explicit-markup-blocks" id="id45" name="id45">Explicit Markup Blocks</a><ul>
<li><a class="reference" href="#footnotes" id="id46" name="id46">Footnotes</a><ul>
<li><a class="reference" href="#auto-numbered-footnotes" id="id47" name="id47">Auto-Numbered Footnotes</a></li>
<li><a class="reference" href="#auto-symbol-footnotes" id="id48" name="id48">Auto-Symbol Footnotes</a></li>
<li><a class="reference" href="#mixed-manual-and-auto-numbered-footnotes" id="id49" name="id49">Mixed Manual and Auto-Numbered Footnotes</a></li>
</ul>
</li>
<li><a class="reference" href="#citations" id="id50" name="id50">Citations</a></li>
<li><a class="reference" href="#hyperlink-targets" id="id51" name="id51">Hyperlink Targets</a><ul>
<li><a class="reference" href="#anonymous-hyperlinks" id="id52" name="id52">Anonymous Hyperlinks</a></li>
</ul>
</li>
<li><a class="reference" href="#directives" id="id53" name="id53">Directives</a></li>
<li><a class="reference" href="#substitution-definitions" id="id54" name="id54">Substitution Definitions</a></li>
<li><a class="reference" href="#comments" id="id55" name="id55">Comments</a></li>
</ul>
</li>
</ul>
</li>
<li><a class="reference" href="#implicit-hyperlink-targets" id="id56" name="id56">Implicit Hyperlink Targets</a></li>
<li><a class="reference" href="#inline-markup" id="id57" name="id57">Inline Markup</a><ul>
<li><a class="reference" href="#character-level-inline-markup" id="id58" name="id58">Character-Level Inline Markup</a></li>
<li><a class="reference" href="#emphasis" id="id59" name="id59">Emphasis</a></li>
<li><a class="reference" href="#strong-emphasis" id="id60" name="id60">Strong Emphasis</a></li>
<li><a class="reference" href="#interpreted-text" id="id61" name="id61">Interpreted Text</a></li>
<li><a class="reference" href="#inline-literals" id="id62" name="id62">Inline Literals</a></li>
<li><a class="reference" href="#hyperlink-references" id="id63" name="id63">Hyperlink References</a><ul>
<li><a class="reference" href="#embedded-uris" id="id64" name="id64">Embedded URIs</a></li>
</ul>
</li>
<li><a class="reference" href="#inline-internal-targets" id="id65" name="id65">Inline Internal Targets</a></li>
<li><a class="reference" href="#footnote-references" id="id66" name="id66">Footnote References</a></li>
<li><a class="reference" href="#citation-references" id="id67" name="id67">Citation References</a></li>
<li><a class="reference" href="#substitution-references" id="id68" name="id68">Substitution References</a></li>
<li><a class="reference" href="#standalone-hyperlinks" id="id69" name="id69">Standalone Hyperlinks</a></li>
</ul>
</li>
</ul>
</li>
<li><a class="reference" href="#error-handling" id="id70" name="id70">Error Handling</a></li>
</ul>
</div>
<div class="section" id="quick-syntax-overview">
<h1><a class="toc-backref" href="#id17" name="quick-syntax-overview">Quick Syntax Overview</a></h1>
<p>A reStructuredText document is made up of body or block-level
elements, and may be structured into sections.  <a class="reference" href="#sections">Sections</a> are
indicated through title style (underlines &amp; optional overlines).
Sections contain body elements and/or subsections.  Some body elements
contain further elements, such as lists containing list items, which
in turn may contain paragraphs and other body elements.  Others, such
as paragraphs, contain text and <a class="reference" href="#inline-markup">inline markup</a> elements.</p>
<p>Here are examples of <a class="reference" href="#body-elements">body elements</a>:</p>
<ul>
<li><p class="first"><a class="reference" href="#paragraphs">Paragraphs</a> (and <a class="reference" href="#inline-markup">inline markup</a>):</p>
<pre class="literal-block">
Paragraphs contain text and may contain inline markup:
*emphasis*, **strong emphasis**, `interpreted text`, ``inline
literals``, standalone hyperlinks (http://www.python.org),
external hyperlinks (Python_), internal cross-references
(example_), footnote references ([1]_), citation references
([CIT2002]_), substitution references (|example|), and _`inline
internal targets`.

Paragraphs are separated by blank lines and are left-aligned.
</pre>
</li>
<li><p class="first">Five types of lists:</p>
<ol class="arabic">
<li><p class="first"><a class="reference" href="#bullet-lists">Bullet lists</a>:</p>
<pre class="literal-block">
- This is a bullet list.

- Bullets can be &quot;-&quot;, &quot;*&quot;, or &quot;+&quot;.
</pre>
</li>
<li><p class="first"><a class="reference" href="#enumerated-lists">Enumerated lists</a>:</p>
<pre class="literal-block">
1. This is an enumerated list.

2. Enumerators may be arabic numbers, letters, or roman
   numerals.
</pre>
</li>
<li><p class="first"><a class="reference" href="#definition-lists">Definition lists</a>:</p>
<pre class="literal-block">
what
    Definition lists associate a term with a definition.

how
    The term is a one-line phrase, and the definition is one
    or more paragraphs or body elements, indented relative to
    the term.
</pre>
</li>
<li><p class="first"><a class="reference" href="#field-lists">Field lists</a>:</p>
<pre class="literal-block">
:what: Field lists map field names to field bodies, like
       database records.  They are often part of an extension
       syntax.

:how: The field marker is a colon, the field name, and a
      colon.

      The field body may contain one or more body elements,
      indented relative to the field marker.
</pre>
</li>
<li><p class="first"><a class="reference" href="#option-lists">Option lists</a>, for listing command-line options:</p>
<pre class="literal-block">
-a            command-line option &quot;a&quot;
-b file       options can have arguments
              and long descriptions
--long        options can be long also
--input=file  long options can also have
              arguments
/V            DOS/VMS-style options too
</pre>
<p>There must be at least two spaces between the option and the
description.</p>
</li>
</ol>
</li>
<li><p class="first"><a class="reference" href="#literal-blocks">Literal blocks</a>:</p>
<pre class="literal-block">
Literal blocks are either indented or line-prefix-quoted blocks,
and indicated with a double-colon (&quot;::&quot;) at the end of the
preceding paragraph (right here --&gt;)::

    if literal_block:
        text = 'is left as-is'
        spaces_and_linebreaks = 'are preserved'
        markup_processing = None
</pre>
</li>
<li><p class="first"><a class="reference" href="#block-quotes">Block quotes</a>:</p>
<pre class="literal-block">
Block quotes consist of indented body elements:

    This theory, that is mine, is mine.

    -- Anne Elk (Miss)
</pre>
</li>
<li><p class="first"><a class="reference" href="#doctest-blocks">Doctest blocks</a>:</p>
<pre class="literal-block">
&gt;&gt;&gt; print 'Python-specific usage examples; begun with &quot;&gt;&gt;&gt;&quot;'
Python-specific usage examples; begun with &quot;&gt;&gt;&gt;&quot;
&gt;&gt;&gt; print '(cut and pasted from interactive Python sessions)'
(cut and pasted from interactive Python sessions)
</pre>
</li>
<li><p class="first">Two syntaxes for <a class="reference" href="#tables">tables</a>:</p>
<ol class="arabic">
<li><p class="first"><a class="reference" href="#grid-tables">Grid tables</a>; complete, but complex and verbose:</p>
<pre class="literal-block">
+------------------------+------------+----------+
| Header row, column 1   | Header 2   | Header 3 |
+========================+============+==========+
| body row 1, column 1   | column 2   | column 3 |
+------------------------+------------+----------+
| body row 2             | Cells may span        |
+------------------------+-----------------------+
</pre>
</li>
<li><p class="first"><a class="reference" href="#simple-tables">Simple tables</a>; easy and compact, but limited:</p>
<pre class="literal-block">
====================  ==========  ==========
Header row, column 1  Header 2    Header 3
====================  ==========  ==========
body row 1, column 1  column 2    column 3
body row 2            Cells may span columns
====================  ======================
</pre>
</li>
</ol>
</li>
<li><p class="first"><a class="reference" href="#explicit-markup-blocks">Explicit markup blocks</a> all begin with an explicit block marker,
two periods and a space:</p>
<ul>
<li><p class="first"><a class="reference" href="#footnotes">Footnotes</a>:</p>
<pre class="literal-block">
.. [1] A footnote contains body elements, consistently
   indented by at least 3 spaces.
</pre>
</li>
<li><p class="first"><a class="reference" href="#citations">Citations</a>:</p>
<pre class="literal-block">
.. [CIT2002] Just like a footnote, except the label is
   textual.
</pre>
</li>
<li><p class="first"><a class="reference" href="#hyperlink-targets">Hyperlink targets</a>:</p>
<pre class="literal-block">
.. _Python: http://www.python.org

.. _example:

The &quot;_example&quot; target above points to this paragraph.
</pre>
</li>
<li><p class="first"><a class="reference" href="#directives">Directives</a>:</p>
<pre class="literal-block">
.. image:: mylogo.png
</pre>
</li>
<li><p class="first"><a class="reference" href="#substitution-definitions">Substitution definitions</a>:</p>
<pre class="literal-block">
.. |symbol here| image:: symbol.png
</pre>
</li>
<li><p class="first"><a class="reference" href="#comments">Comments</a>:</p>
<pre class="literal-block">
.. Comments begin with two dots and a space.  Anything may
   follow, except for the syntax of footnotes/citations,
   hyperlink targets, directives, or substitution definitions.
</pre>
</li>
</ul>
</li>
</ul>
</div>
<div class="section" id="syntax-details">
<h1><a class="toc-backref" href="#id18" name="syntax-details">Syntax Details</a></h1>
<p>Descriptions below list &quot;doctree elements&quot; (document tree element
names; XML DTD generic identifiers) corresponding to syntax
constructs.  For details on the hierarchy of elements, please see <a class="reference" href="../doctree.html">The
Docutils Document Tree</a> and the <a class="reference" href="../docutils.dtd">Docutils Generic DTD</a> XML document
type definition.</p>
<div class="section" id="whitespace">
<h2><a class="toc-backref" href="#id19" name="whitespace">Whitespace</a></h2>
<p>Spaces are recommended for <a class="reference" href="#indentation">indentation</a>, but tabs may also be used.
Tabs will be converted to spaces.  Tab stops are at every 8th column.</p>
<p>Other whitespace characters (form feeds [chr(12)] and vertical tabs
[chr(11)]) are converted to single spaces before processing.</p>
<div class="section" id="blank-lines">
<h3><a class="toc-backref" href="#id20" name="blank-lines">Blank Lines</a></h3>
<p>Blank lines are used to separate paragraphs and other elements.
Multiple successive blank lines are equivalent to a single blank line,
except within literal blocks (where all whitespace is preserved).
Blank lines may be omitted when the markup makes element separation
unambiguous, in conjunction with indentation.  The first line of a
document is treated as if it is preceded by a blank line, and the last
line of a document is treated as if it is followed by a blank line.</p>
</div>
<div class="section" id="indentation">
<h3><a class="toc-backref" href="#id21" name="indentation">Indentation</a></h3>
<p>Indentation is used to indicate, and is only significant in
indicating:</p>
<ul class="simple">
<li>multi-line contents of list items,</li>
<li>multiple body elements within a list item (including nested lists),</li>
<li>the definition part of a definition list item,</li>
<li>block quotes,</li>
<li>the extent of literal blocks, and</li>
<li>the extent of explicit markup blocks.</li>
</ul>
<p>Any text whose indentation is less than that of the current level
(i.e., unindented text or &quot;dedents&quot;) ends the current level of
indentation.</p>
<p>Since all indentation is significant, the level of indentation must be
consistent.  For example, indentation is the sole markup indicator for
<a class="reference" href="#block-quotes">block quotes</a>:</p>
<pre class="literal-block">
This is a top-level paragraph.

    This paragraph belongs to a first-level block quote.

    Paragraph 2 of the first-level block quote.
</pre>
<p>Multiple levels of indentation within a block quote will result in
more complex structures:</p>
<pre class="literal-block">
This is a top-level paragraph.

    This paragraph belongs to a first-level block quote.

        This paragraph belongs to a second-level block quote.

Another top-level paragraph.

        This paragraph belongs to a second-level block quote.

    This paragraph belongs to a first-level block quote.  The
    second-level block quote above is inside this first-level
    block quote.
</pre>
<p>When a paragraph or other construct consists of more than one line of
text, the lines must be left-aligned:</p>
<pre class="literal-block">
This is a paragraph.  The lines of
this paragraph are aligned at the left.

    This paragraph has problems.  The
lines are not left-aligned.  In addition
  to potential misinterpretation, warning
    and/or error messages will be generated
  by the parser.
</pre>
<p>Several constructs begin with a marker, and the body of the construct
must be indented relative to the marker.  For constructs using simple
markers (<a class="reference" href="#bullet-lists">bullet lists</a>, <a class="reference" href="#enumerated-lists">enumerated lists</a>, <a class="reference" href="#footnotes">footnotes</a>, <a class="reference" href="#citations">citations</a>,
<a class="reference" href="#hyperlink-targets">hyperlink targets</a>, <a class="reference" href="#directives">directives</a>, and <a class="reference" href="#comments">comments</a>), the level of
indentation of the body is determined by the position of the first
line of text, which begins on the same line as the marker.  For
example, bullet list bodies must be indented by at least two columns
relative to the left edge of the bullet:</p>
<pre class="literal-block">
- This is the first line of a bullet list
  item's paragraph.  All lines must align
  relative to the first line.  [1]_

      This indented paragraph is interpreted
      as a block quote.

Because it is not sufficiently indented,
this paragraph does not belong to the list
item.

.. [1] Here's a footnote.  The second line is aligned
   with the beginning of the footnote label.  The &quot;..&quot;
   marker is what determines the indentation.
</pre>
<p>For constructs using complex markers (<a class="reference" href="#field-lists">field lists</a> and <a class="reference" href="#option-lists">option
lists</a>), where the marker may contain arbitrary text, the indentation
of the first line <em>after</em> the marker determines the left edge of the
body.  For example, field lists may have very long markers (containing
the field names):</p>
<pre class="literal-block">
:Hello: This field has a short field name, so aligning the field
        body with the first line is feasible.

:Number-of-African-swallows-required-to-carry-a-coconut: It would
    be very difficult to align the field body with the left edge
    of the first line.  It may even be preferable not to begin the
    body on the same line as the marker.
</pre>
</div>
</div>
<div class="section" id="escaping-mechanism">
<h2><a class="toc-backref" href="#id22" name="escaping-mechanism">Escaping Mechanism</a></h2>
<p>The character set universally available to plaintext documents, 7-bit
ASCII, is limited.  No matter what characters are used for markup,
they will already have multiple meanings in written text.  Therefore
markup characters <em>will</em> sometimes appear in text <strong>without being
intended as markup</strong>.  Any serious markup system requires an escaping
mechanism to override the default meaning of the characters used for
the markup.  In reStructuredText we use the backslash, commonly used
as an escaping character in other domains.</p>
<p>A backslash followed by any character (except whitespace characters)
escapes that character.  The escaped character represents the
character itself, and is prevented from playing a role in any markup
interpretation.  The backslash is removed from the output.  A literal
backslash is represented by two backslashes in a row (the first
backslash &quot;escapes&quot; the second, preventing it being interpreted in an
&quot;escaping&quot; role).</p>
<p>Backslash-escaped whitespace characters are removed from the document.
This allows for character-level <a class="reference" href="#inline-markup">inline markup</a>.</p>
<p>There are two contexts in which backslashes have no special meaning:
literal blocks and inline literals.  In these contexts, a single
backslash represents a literal backslash, without having to double up.</p>
<p>Please note that the reStructuredText specification and parser do not
address the issue of the representation or extraction of text input
(how and in what form the text actually <em>reaches</em> the parser).
Backslashes and other characters may serve a character-escaping
purpose in certain contexts and must be dealt with appropriately.  For
example, Python uses backslashes in strings to escape certain
characters, but not others.  The simplest solution when backslashes
appear in Python docstrings is to use raw docstrings:</p>
<pre class="literal-block">
r&quot;&quot;&quot;This is a raw docstring.  Backslashes (\) are not touched.&quot;&quot;&quot;
</pre>
</div>
<div class="section" id="reference-names">
<h2><a class="toc-backref" href="#id23" name="reference-names">Reference Names</a></h2>
<p>Simple reference names are single words consisting of alphanumerics
plus isolated (no two adjacent) internal hyphens, underscores, and
periods; no whitespace or other characters are allowed.  Footnote
labels (<a class="reference" href="#footnotes">Footnotes</a> &amp; <a class="reference" href="#footnote-references">Footnote References</a>), citation labels
(<a class="reference" href="#citations">Citations</a> &amp; <a class="reference" href="#citation-references">Citation References</a>), <a class="reference" href="#interpreted-text">interpreted text</a> roles, and
some <a class="reference" href="#hyperlink-references">hyperlink references</a> use the simple reference name syntax.</p>
<p>Reference names using punctuation or whose names are phrases (two or
more space-separated words) are called &quot;phrase-references&quot;.
Phrase-references are expressed by enclosing the phrase in backquotes
and treating the backquoted text as a reference name:</p>
<pre class="literal-block">
Want to learn about `my favorite programming language`_?

.. _my favorite programming language: http://www.python.org
</pre>
<p>Simple reference names may also optionally use backquotes.</p>
<p>Reference names are whitespace-neutral and case-insensitive.  When
resolving reference names internally:</p>
<ul class="simple">
<li>whitespace is normalized (one or more spaces, horizontal or vertical
tabs, newlines, carriage returns, or form feeds, are interpreted as
a single space), and</li>
<li>case is normalized (all alphabetic characters are converted to
lowercase).</li>
</ul>
<p>For example, the following <a class="reference" href="#hyperlink-references">hyperlink references</a> are equivalent:</p>
<pre class="literal-block">
- `A HYPERLINK`_
- `a    hyperlink`_
- `A
  Hyperlink`_
</pre>
<p><a class="reference" href="#hyperlinks">Hyperlinks</a>, <a class="reference" href="#footnotes">footnotes</a>, and <a class="reference" href="#citations">citations</a> all share the same namespace
for reference names.  The labels of citations (simple reference names)
and manually-numbered footnotes (numbers) are entered into the same
database as other hyperlink names.  This means that a footnote
(defined as &quot;<tt class="literal"><span class="pre">..</span> <span class="pre">[1]</span></tt>&quot;) which can be referred to by a footnote
reference (<tt class="literal"><span class="pre">[1]_</span></tt>), can also be referred to by a plain hyperlink
reference (<a class="reference" href="#id2">1</a>).  Of course, each type of reference (hyperlink,
footnote, citation) may be processed and rendered differently.  Some
care should be taken to avoid reference name conflicts.</p>
</div>
<div class="section" id="document-structure">
<h2><a class="toc-backref" href="#id24" name="document-structure">Document Structure</a></h2>
<div class="section" id="document">
<h3><a class="toc-backref" href="#id25" name="document">Document</a></h3>
<p>Doctree element: document.</p>
<p>The top-level element of a parsed reStructuredText document is the
&quot;document&quot; element.  After initial parsing, the document element is a
simple container for a document fragment, consisting of <a class="reference" href="#body-elements">body
elements</a>, <a class="reference" href="#transitions">transitions</a>, and <a class="reference" href="#sections">sections</a>, but lacking a document title
or other bibliographic elements.  The code that calls the parser may
choose to run one or more optional post-parse <a class="reference" href="http://docutils.sourceforge.net/docutils/transforms/">transforms</a>,
rearranging the document fragment into a complete document with a
title and possibly other metadata elements (author, date, etc.; see
<a class="reference" href="#bibliographic-fields">Bibliographic Fields</a>).</p>
<p>Specifically, there is no way to indicate a document title and
subtitle explicitly in reStructuredText.  Instead, a lone top-level
section title (see <a class="reference" href="#sections">Sections</a> below) can be treated as the document
title.  Similarly, a lone second-level section title immediately after
the &quot;document title&quot; can become the document subtitle.  See the
<a class="reference" href="http://docutils.sourceforge.net/docutils/transforms/frontmatter.py">DocTitle transform</a> for details.</p>
</div>
<div class="section" id="sections">
<h3><a class="toc-backref" href="#id26" name="sections">Sections</a></h3>
<p>Doctree elements: section, title.</p>
<p>Sections are identified through their titles, which are marked up with
adornment: &quot;underlines&quot; below the title text, or underlines and
matching &quot;overlines&quot; above the title.  An underline/overline is a
single repeated punctuation character that begins in column 1 and
forms a line extending at least as far as the right edge of the title
text.  Specifically, an underline/overline character may be any
non-alphanumeric printable 7-bit ASCII character <a class="footnote-reference" href="#id2" id="id1" name="id1"><sup>1</sup></a>.  When an
overline is used, the length and character used must match the
underline.  Underline-only adornment styles are distinct from
overline-and-underline styles that use the same character.  There may
be any number of levels of section titles, although some output
formats may have limits (HTML has 6 levels).</p>
<table class="footnote" frame="void" id="id2" rules="none">
<colgroup><col class="label" /><col /></colgroup>
<tbody valign="top">
<tr><td class="label"><a class="fn-backref" href="#id1" name="id2">[1]</a></td><td><p>The following are all valid section title adornment
characters:</p>
<pre class="literal-block">
! &quot; # $ % &amp; ' ( ) * + , - . / : ; &lt; = &gt; ? &#64; [ \ ] ^ _ ` { | } ~
</pre>
<p>Some characters are more suitable than others.  The following are
recommended:</p>
<pre class="literal-block">
= - ` : . ' &quot; ~ ^ _ * + #
</pre>
</td></tr>
</tbody>
</table>
<p>Rather than imposing a fixed number and order of section title
adornment styles, the order enforced will be the order as encountered.
The first style encountered will be an outermost title (like HTML H1),
the second style will be a subtitle, the third will be a subsubtitle,
and so on.</p>
<p>Below are examples of section title styles:</p>
<pre class="literal-block">
===============
 Section Title
===============

---------------
 Section Title
---------------

Section Title
=============

Section Title
-------------

Section Title
`````````````

Section Title
'''''''''''''

Section Title
.............

Section Title
~~~~~~~~~~~~~

Section Title
*************

Section Title
+++++++++++++

Section Title
^^^^^^^^^^^^^
</pre>
<p>When a title has both an underline and an overline, the title text may
be inset, as in the first two examples above.  This is merely
aesthetic and not significant.  Underline-only title text may <em>not</em> be
inset.</p>
<p>A blank line after a title is optional.  All text blocks up to the
next title of the same or higher level are included in a section (or
subsection, etc.).</p>
<p>All section title styles need not be used, nor need any specific
section title style be used.  However, a document must be consistent
in its use of section titles: once a hierarchy of title styles is
established, sections must use that hierarchy.</p>
<p>Each section title automatically generates a hyperlink target pointing
to the section.  The text of the hyperlink target (the &quot;reference
name&quot;) is the same as that of the section title.  See <a class="reference" href="#implicit-hyperlink-targets">Implicit
Hyperlink Targets</a> for a complete description.</p>
<p>Sections may contain <a class="reference" href="#body-elements">body elements</a>, <a class="reference" href="#transitions">transitions</a>, and nested
sections.</p>
</div>
<div class="section" id="transitions">
<h3><a class="toc-backref" href="#id27" name="transitions">Transitions</a></h3>
<p>Doctree element: transition.</p>
<blockquote>
<p>Instead of subheads, extra space or a type ornament between
paragraphs may be used to mark text divisions or to signal
changes in subject or emphasis.</p>
<p>(The Chicago Manual of Style, 14th edition, section 1.80)</p>
</blockquote>
<p>Transitions are commonly seen in novels and short fiction, as a gap
spanning one or more lines, with or without a type ornament such as a
row of asterisks.  Transitions separate other body elements.  A
transition should not begin or end a section or document, nor should
two transitions be immediately adjacent.</p>
<p>The syntax for a transition marker is a horizontal line of 4 or more
repeated punctuation characters.  The syntax is the same as section
title underlines without title text.  Transition markers require blank
lines before and after:</p>
<pre class="literal-block">
Para.

----------

Para.
</pre>
<p>Unlike section title underlines, no hierarchy of transition markers is
enforced, nor do differences in transition markers accomplish
anything.  It is recommended that a single consistent style be used.</p>
<p>The processing system is free to render transitions in output in any
way it likes.  For example, horizontal rules (<tt class="literal"><span class="pre">&lt;hr&gt;</span></tt>) in HTML output
would be an obvious choice.</p>
</div>
</div>
<div class="section" id="body-elements">
<h2><a class="toc-backref" href="#id28" name="body-elements">Body Elements</a></h2>
<div class="section" id="paragraphs">
<h3><a class="toc-backref" href="#id29" name="paragraphs">Paragraphs</a></h3>
<p>Doctree element: paragraph.</p>
<p>Paragraphs consist of blocks of left-aligned text with no markup
indicating any other body element.  Blank lines separate paragraphs
from each other and from other body elements.  Paragraphs may contain
<a class="reference" href="#inline-markup">inline markup</a>.</p>
<p>Syntax diagram:</p>
<pre class="literal-block">
+------------------------------+
| paragraph                    |
|                              |
+------------------------------+

+------------------------------+
| paragraph                    |
|                              |
+------------------------------+
</pre>
</div>
<div class="section" id="bullet-lists">
<h3><a class="toc-backref" href="#id30" name="bullet-lists">Bullet Lists</a></h3>
<p>Doctree elements: bullet_list, list_item.</p>
<p>A text block which begins with a &quot;-&quot;, &quot;*&quot;, or &quot;+&quot;, followed by
whitespace, is a bullet list item (a.k.a. &quot;unordered&quot; list item).
List item bodies must be left-aligned and indented relative to the
bullet; the text immediately after the bullet determines the
indentation.  For example:</p>
<pre class="literal-block">
- This is the first bullet list item.  The blank line above the
  first list item is required; blank lines between list items
  (such as below this paragraph) are optional.

- This is the first paragraph in the second item in the list.

  This is the second paragraph in the second item in the list.
  The blank line above this paragraph is required.  The left edge
  of this paragraph lines up with the paragraph above, both
  indented relative to the bullet.

  - This is a sublist.  The bullet lines up with the left edge of
    the text blocks above.  A sublist is a new list so requires a
    blank line above and below.

- This is the third item of the main list.

This paragraph is not part of the list.
</pre>
<p>Here are examples of <strong>incorrectly</strong> formatted bullet lists:</p>
<pre class="literal-block">
- This first line is fine.
A blank line is required between list items and paragraphs.
(Warning)

- The following line appears to be a new sublist, but it is not:
  - This is a paragraph continuation, not a sublist (since there's
    no blank line).  This line is also incorrectly indented.
  - Warnings may be issued by the implementation.
</pre>
<p>Syntax diagram:</p>
<pre class="literal-block">
+------+-----------------------+
| &quot;- &quot; | list item             |
+------| (body elements)+      |
       +-----------------------+
</pre>
</div>
<div class="section" id="enumerated-lists">
<h3><a class="toc-backref" href="#id31" name="enumerated-lists">Enumerated Lists</a></h3>
<p>Doctree elements: enumerated_list, list_item.</p>
<p>Enumerated lists (a.k.a. &quot;ordered&quot; lists) are similar to bullet lists,
but use enumerators instead of bullets.  An enumerator consists of an
enumeration sequence member and formatting, followed by whitespace.
The following enumeration sequences are recognized:</p>
<ul class="simple">
<li>arabic numerals: 1, 2, 3, ... (no upper limit).</li>
<li>uppercase alphabet characters: A, B, C, ..., Z.</li>
<li>lower-case alphabet characters: a, b, c, ..., z.</li>
<li>uppercase Roman numerals: I, II, III, IV, ..., MMMMCMXCIX (4999).</li>
<li>lowercase Roman numerals: i, ii, iii, iv, ..., mmmmcmxcix (4999).</li>
</ul>
<p>The following formatting types are recognized:</p>
<ul class="simple">
<li>suffixed with a period: &quot;1.&quot;, &quot;A.&quot;, &quot;a.&quot;, &quot;I.&quot;, &quot;i.&quot;.</li>
<li>surrounded by parentheses: &quot;(1)&quot;, &quot;(A)&quot;, &quot;(a)&quot;, &quot;(I)&quot;, &quot;(i)&quot;.</li>
<li>suffixed with a right-parenthesis: &quot;1)&quot;, &quot;A)&quot;, &quot;a)&quot;, &quot;I)&quot;, &quot;i)&quot;.</li>
</ul>
<p>While parsing an enumerated list, a new list will be started whenever:</p>
<ul class="simple">
<li>An enumerator is encountered which does not have the same format and
sequence type as the current list (e.g. &quot;1.&quot;, &quot;(a)&quot; produces two
separate lists).</li>
<li>The enumerators are not in sequence (e.g., &quot;1.&quot;, &quot;3.&quot; produces two
separate lists).</li>
</ul>
<p>It is recommended that the enumerator of the first list item be
ordinal-1 (&quot;1&quot;, &quot;A&quot;, &quot;a&quot;, &quot;I&quot;, or &quot;i&quot;).  Although other start-values
will be recognized, they may not be supported by the output format.  A
level-1 [info] system message will be generated for any list beginning
with a non-ordinal-1 enumerator.</p>
<p>Lists using Roman numerals must begin with &quot;I&quot;/&quot;i&quot; or a
multi-character value, such as &quot;II&quot; or &quot;XV&quot;.  Any other
single-character Roman numeral (&quot;V&quot;, &quot;X&quot;, &quot;L&quot;, &quot;C&quot;, &quot;D&quot;, &quot;M&quot;) will be
interpreted as a letter of the alphabet, not as a Roman numeral.
Likewise, lists using letters of the alphabet may not begin with
&quot;I&quot;/&quot;i&quot;, since these are recognized as Roman numeral 1.</p>
<p>The second line of each enumerated list item is checked for validity.
This is to prevent ordinary paragraphs from being mistakenly
interpreted as list items, when they happen to begin with text
identical to enumerators.  For example, this text is parsed as an
ordinary paragraph:</p>
<pre class="literal-block">
A. Einstein was a really
smart dude.
</pre>
<p>However, ambiguity cannot be avoided if the paragraph consists of only
one line.  This text is parsed as an enumerated list item:</p>
<pre class="literal-block">
A. Einstein was a really smart dude.
</pre>
<p>If a single-line paragraph begins with text identical to an enumerator
(&quot;A.&quot;, &quot;1.&quot;, &quot;(b)&quot;, &quot;I)&quot;, etc.), the first character will have to be
escaped in order to have the line parsed as an ordinary paragraph:</p>
<pre class="literal-block">
\A. Einstein was a really smart dude.
</pre>
<p>Nested enumerated lists must be created with indentation.  For
example:</p>
<pre class="literal-block">
1. Item 1.

   a) Item 1a.
   b) Item 1b.
</pre>
<p>Example syntax diagram:</p>
<pre class="literal-block">
+-------+----------------------+
| &quot;1. &quot; | list item            |
+-------| (body elements)+     |
        +----------------------+
</pre>
</div>
<div class="section" id="definition-lists">
<h3><a class="toc-backref" href="#id32" name="definition-lists">Definition Lists</a></h3>
<p>Doctree elements: definition_list, definition_list_item, term,
classifier, definition.</p>
<p>Each definition list item contains a term, an optional classifier, and
a definition.  A term is a simple one-line word or phrase.  An
optional classifier may follow the term on the same line, after an
inline &quot; : &quot; (space, colon, space).  A definition is a block indented
relative to the term, and may contain multiple paragraphs and other
body elements.  There may be no blank line between a term line and a
definition block (this distinguishes definition lists from <a class="reference" href="#block-quotes">block
quotes</a>).  Blank lines are required before the first and after the
last definition list item, but are optional in-between.  For example:</p>
<pre class="literal-block">
term 1
    Definition 1.

term 2
    Definition 2, paragraph 1.

    Definition 2, paragraph 2.

term 3 : classifier
    Definition 3.
</pre>
<p>Inline markup is parsed in the term line before the term/classifier
delimiter (&quot; : &quot;) is recognized.  The delimiter will only be
recognized if it appears outside of any inline markup.</p>
<p>A definition list may be used in various ways, including:</p>
<ul class="simple">
<li>As a dictionary or glossary.  The term is the word itself, a
classifier may be used to indicate the usage of the term (noun,
verb, etc.), and the definition follows.</li>
<li>To describe program variables.  The term is the variable name, a
classifier may be used to indicate the type of the variable (string,
integer, etc.), and the definition describes the variable's use in
the program.  This usage of definition lists supports the classifier
syntax of <a class="reference" href="http://www.mems-exchange.org/software/grouch/">Grouch</a>, a system for describing and enforcing a Python
object schema.</li>
</ul>
<p>Syntax diagram:</p>
<pre class="literal-block">
+---------------------------+
| term [ &quot; : &quot; classifier ] |
+--+------------------------+--+
   | definition                |
   | (body elements)+          |
   +---------------------------+
</pre>
</div>
<div class="section" id="field-lists">
<h3><a class="toc-backref" href="#id33" name="field-lists">Field Lists</a></h3>
<p>Doctree elements: field_list, field, field_name, field_body.</p>
<p>Field lists are used as part of an extension syntax, such as options
for <a class="reference" href="#directives">directives</a>, or database-like records meant for further
processing.  They may also be used for two-column table-like
structures resembling database records (label &amp; data pairs).
Applications of reStructuredText may recognize field names and
transform fields or field bodies in certain contexts.  For examples,
see <a class="reference" href="#bibliographic-fields">Bibliographic Fields</a> below, or the &quot;image&quot; and &quot;meta&quot;
directives in <a class="reference" href="directives.html">reStructuredText Directives</a>.</p>
<p>Field lists are mappings from field names to field bodies, modeled on
<a class="reference" href="http://www.rfc-editor.org/rfc/rfc822.txt">RFC822</a> headers.  A field name is made up of one or more letters,
numbers, whitespace, and punctuation, except colons (&quot;:&quot;).  Inline
markup is parsed in field names.  Field names are case-insensitive
when further processed or transformed.  The field name, along with a
single colon prefix and suffix, together form the field marker.  The
field marker is followed by whitespace and the field body.  The field
body may contain multiple body elements, indented relative to the
field marker.  The first line after the field name marker determines
the indentation of the field body.  For example:</p>
<pre class="literal-block">
:Date: 2001-08-16
:Version: 1
:Authors: - Me
          - Myself
          - I
:Indentation: Since the field marker may be quite long, the second
   and subsequent lines of the field body do not have to line up
   with the first line, but they must be indented relative to the
   field name marker, and they must line up with each other.
:Parameter i: integer
</pre>
<p>The interpretation of individual words in a multi-word field name is
up to the application.  The application may specify a syntax for the
field name.  For example, second and subsequent words may be treated
as &quot;arguments&quot;, quoted phrases may be treated as a single argument,
and direct support for the &quot;name=value&quot; syntax may be added.</p>
<p>Standard <a class="reference" href="http://www.rfc-editor.org/rfc/rfc822.txt">RFC822</a> headers cannot be used for this construct because
they are ambiguous.  A word followed by a colon at the beginning of a
line is common in written text.  However, in well-defined contexts
such as when a field list invariably occurs at the beginning of a
document (PEPs and email messages), standard RFC822 headers could be
used.</p>
<p>Syntax diagram (simplified):</p>
<pre class="literal-block">
+--------------------+----------------------+
| &quot;:&quot; field name &quot;:&quot; | field body           |
+-------+------------+                      |
        | (body elements)+                  |
        +-----------------------------------+
</pre>
<div class="section" id="bibliographic-fields">
<h4><a class="toc-backref" href="#id34" name="bibliographic-fields">Bibliographic Fields</a></h4>
<p>Doctree elements: docinfo, author, authors, organization, contact,
version, status, date, copyright, field, topic.</p>
<p>When a field list is the first non-comment element in a document
(after the document title, if there is one), it may have its fields
transformed to document bibliographic data.  This bibliographic data
corresponds to the front matter of a book, such as the title page and
copyright page.</p>
<p>Certain registered field names (listed below) are recognized and
transformed to the corresponding doctree elements, most becoming child
elements of the &quot;docinfo&quot; element.  No ordering is required of these
fields, although they may be rearranged to fit the document structure,
as noted.  Unless otherwise indicated below, each of the bibliographic
elements' field bodies may contain a single paragraph only.  Field
bodies may be checked for <a class="reference" href="#rcs-keywords">RCS keywords</a> and cleaned up.  Any
unrecognized fields will remain as generic fields in the docinfo
element.</p>
<p>The registered bibliographic field names and their corresponding
doctree elements are as follows:</p>
<ul class="simple">
<li>Field name &quot;Author&quot;: author element.</li>
<li>&quot;Authors&quot;: authors.</li>
<li>&quot;Organization&quot;: organization.</li>
<li>&quot;Contact&quot;: contact.</li>
<li>&quot;Address&quot;: address.</li>
<li>&quot;Version&quot;: version.</li>
<li>&quot;Status&quot;: status.</li>
<li>&quot;Date&quot;: date.</li>
<li>&quot;Copyright&quot;: copyright.</li>
<li>&quot;Dedication&quot;: topic.</li>
<li>&quot;Abstract&quot;: topic.</li>
</ul>
<p>The &quot;Authors&quot; field may contain either: a single paragraph consisting
of a list of authors, separated by &quot;;&quot; or &quot;,&quot;; or a bullet list whose
elements each contain a single paragraph per author.  &quot;;&quot; is checked
first, so &quot;Doe, Jane; Doe, John&quot; will work.  In some languages
(e.g. Swedish), there is no singular/plural distinction between
&quot;Author&quot; and &quot;Authors&quot;, so only an &quot;Authors&quot; field is provided, and a
single name is interpreted as an &quot;Author&quot;.  If a single name contains
a comma, end it with a semicolon to disambiguate: &quot;:Authors: Doe,
Jane;&quot;.</p>
<p>The &quot;Address&quot; field is for a multi-line surface mailing address.  A
specialized form of line block`_ (see <a class="reference" href="directives.html">reStructuredText Directives</a>),
newlines and whitespace will be preserved.</p>
<p>The &quot;Dedication&quot; and &quot;Abstract&quot; fields may contain arbitrary body
elements.  Only one of each is allowed.  They become topic elements
with &quot;Dedication&quot; or &quot;Abstract&quot; titles (or language equivalents)
immediately following the docinfo element.</p>
<p>This field-name-to-element mapping can be replaced for other
languages.  See the <a class="reference" href="http://docutils.sourceforge.net/docutils/transforms/frontmatter.py">DocInfo transform</a> implementation documentation
for details.</p>
<p>Unregistered/generic fields may contain one or more paragraphs or
arbitrary body elements.</p>
</div>
<div class="section" id="rcs-keywords">
<h4><a class="toc-backref" href="#id35" name="rcs-keywords">RCS Keywords</a></h4>
<p><a class="reference" href="#bibliographic-fields">Bibliographic fields</a> recognized by the parser are normally checked
for RCS <a class="footnote-reference" href="#id6" id="id3" name="id3"><sup>2</sup></a> keywords and cleaned up <a class="footnote-reference" href="#id7" id="id4" name="id4"><sup>3</sup></a>.  RCS keywords may be
entered into source files as &quot;$keyword$&quot;, and once stored under RCS or
CVS <a class="footnote-reference" href="#id8" id="id5" name="id5"><sup>4</sup></a>, they are expanded to &quot;$keyword: expansion text $&quot;.  For
example, a &quot;Status&quot; field will be transformed to a &quot;status&quot; element:</p>
<pre class="literal-block">
:Status: $keyword: expansion text $
</pre>
<table class="footnote" frame="void" id="id6" rules="none">
<colgroup><col class="label" /><col /></colgroup>
<tbody valign="top">
<tr><td class="label"><a class="fn-backref" href="#id3" name="id6">[2]</a></td><td>Revision Control System.</td></tr>
</tbody>
</table>
<table class="footnote" frame="void" id="id7" rules="none">
<colgroup><col class="label" /><col /></colgroup>
<tbody valign="top">
<tr><td class="label"><a class="fn-backref" href="#id4" name="id7">[3]</a></td><td>RCS keyword processing can be turned off (unimplemented).</td></tr>
</tbody>
</table>
<table class="footnote" frame="void" id="id8" rules="none">
<colgroup><col class="label" /><col /></colgroup>
<tbody valign="top">
<tr><td class="label"><a class="fn-backref" href="#id5" name="id8">[4]</a></td><td>Concurrent Versions System.  CVS uses the same keywords as RCS.</td></tr>
</tbody>
</table>
<p>Processed, the &quot;status&quot; element's text will become simply &quot;expansion
text&quot;.  The dollar sign delimiters and leading RCS keyword name are
removed.</p>
<p>The RCS keyword processing only kicks in when all of these conditions
hold:</p>
<ol class="arabic simple">
<li>The field list is in bibliographic context (first non-comment
construct in the document, after a document title if there is
one).</li>
<li>The field name is a recognized bibliographic field name.</li>
<li>The sole contents of the field is an expanded RCS keyword, of the
form &quot;$Keyword: data $&quot;.</li>
</ol>
</div>
</div>
<div class="section" id="option-lists">
<h3><a class="toc-backref" href="#id36" name="option-lists">Option Lists</a></h3>
<p>Doctree elements: option_list, option_list_item, option_group, option,
option_string, option_argument, description.</p>
<p>Option lists are two-column lists of command-line options and
descriptions, documenting a program's options.  For example:</p>
<pre class="literal-block">
-a         Output all.
-b         Output both (this description is
           quite long).
-c arg     Output just arg.
--long     Output all day long.

-p         This option has two paragraphs in the description.
           This is the first.

           This is the second.  Blank lines may be omitted between
           options (as above) or left in (as here and below).

--very-long-option  A VMS-style option.  Note the adjustment for
                    the required two spaces.

--an-even-longer-option
           The description can also start on the next line.

-2, --two  This option has two variants.

-f FILE, --file=FILE  These two options are synonyms; both have
                      arguments.

/V         A VMS/DOS-style option.
</pre>
<p>There are several types of options recognized by reStructuredText:</p>
<ul class="simple">
<li>Short POSIX options consist of one dash and an option letter.</li>
<li>Long POSIX options consist of two dashes and an option word; some
systems use a single dash.</li>
<li>Old GNU-style &quot;plus&quot; options consist of one plus and an option
letter (&quot;plus&quot; options are deprecated now, their use discouraged).</li>
<li>DOS/VMS options consist of a slash and an option letter or word.</li>
</ul>
<p>Please note that both POSIX-style and DOS/VMS-style options may be
used by DOS or Windows software.  These and other variations are
sometimes used mixed together.  The names above have been chosen for
convenience only.</p>
<p>The syntax for short and long POSIX options is based on the syntax
supported by Python's <a class="reference" href="http://www.python.org/doc/current/lib/module-getopt.html">getopt.py</a> module, which implements an option
parser similar to the <a class="reference" href="http://www.gnu.org/manual/glibc-2.2.3/html_node/libc_516.html">GNU libc getopt_long()</a> function but with some
restrictions.  There are many variant option systems, and
reStructuredText option lists do not support all of them.</p>
<p>Although long POSIX and DOS/VMS option words may be allowed to be
truncated by the operating system or the application when used on the
command line, reStructuredText option lists do not show or support
this with any special syntax.  The complete option word should be
given, supported by notes about truncation if and when applicable.</p>
<p>Options may be followed by an argument placeholder, whose role and
syntax should be explained in the description text.  Either a space or
an equals sign may be used as a delimiter between options and option
argument placeholders; short options (&quot;-&quot; or &quot;+&quot; prefix only) may omit
the delimiter.  Option arguments may take one of two forms:</p>
<ul class="simple">
<li>Begins with a letter (<tt class="literal"><span class="pre">[a-zA-Z]</span></tt>) and subsequently consists of
letters, numbers, underscores and hyphens (<tt class="literal"><span class="pre">[a-zA-Z0-9_-]</span></tt>).</li>
<li>Begins with an open-angle-bracket (<tt class="literal"><span class="pre">&lt;</span></tt>) and ends with a
close-angle-bracket (<tt class="literal"><span class="pre">&gt;</span></tt>); any characters except angle brackets
are allowed internally.</li>
</ul>
<p>Multiple option &quot;synonyms&quot; may be listed, sharing a single
description.  They must be separated by comma-space.</p>
<p>There must be at least two spaces between the option(s) and the
description.  The description may contain multiple body elements.  The
first line after the option marker determines the indentation of the
description.  As with other types of lists, blank lines are required
before the first option list item and after the last, but are optional
between option entries.</p>
<p>Syntax diagram (simplified):</p>
<pre class="literal-block">
+----------------------------+-------------+
| option [&quot; &quot; argument] &quot;  &quot; | description |
+-------+--------------------+             |
        | (body elements)+                 |
        +----------------------------------+
</pre>
</div>
<div class="section" id="literal-blocks">
<h3><a class="toc-backref" href="#id37" name="literal-blocks">Literal Blocks</a></h3>
<p>Doctree element: literal_block.</p>
<p>A paragraph consisting of two colons (&quot;::&quot;) signifies that the
following text block(s) comprise a literal block.  The literal block
must either be indented or quoted (see below).  No markup processing
is done within a literal block.  It is left as-is, and is typically
rendered in a monospaced typeface:</p>
<pre class="literal-block">
This is a typical paragraph.  An indented literal block follows.

::

    for a in [5,4,3,2,1]:   # this is program code, shown as-is
        print a
    print &quot;it's...&quot;
    # a literal block continues until the indentation ends

This text has returned to the indentation of the first paragraph,
is outside of the literal block, and is therefore treated as an
ordinary paragraph.
</pre>
<p>The paragraph containing only &quot;::&quot; will be completely removed from the
output; no empty paragraph will remain.</p>
<p>As a convenience, the &quot;::&quot; is recognized at the end of any paragraph.
If immediately preceded by whitespace, both colons will be removed
from the output (this is the &quot;partially minimized&quot; form).  When text
immediately precedes the &quot;::&quot;, <em>one</em> colon will be removed from the
output, leaving only one colon visible (i.e., &quot;::&quot; will be replaced by
&quot;:&quot;; this is the &quot;fully minimized&quot; form).</p>
<p>In other words, these are all equivalent (please pay attention to the
colons after &quot;Paragraph&quot;):</p>
<ol class="arabic">
<li><p class="first">Expanded form:</p>
<pre class="literal-block">
Paragraph:

::

    Literal block
</pre>
</li>
<li><p class="first">Partially minimized form:</p>
<pre class="literal-block">
Paragraph: ::

    Literal block
</pre>
</li>
<li><p class="first">Fully minimized form:</p>
<pre class="literal-block">
Paragraph::

    Literal block
</pre>
</li>
</ol>
<p>All whitespace (including line breaks, but excluding minimum
indentation for indented literal blocks) is preserved.  Blank lines
are required before and after a literal block, but these blank lines
are not included as part of the literal block.</p>
<div class="section" id="indented-literal-blocks">
<h4><a class="toc-backref" href="#id38" name="indented-literal-blocks">Indented Literal Blocks</a></h4>
<p>Indented literal blocks are indicated by indentation relative to the
surrounding text (leading whitespace on each line).  The minimum
indentation will be removed from each line of an indented literal
block.  The literal block need not be contiguous; blank lines are
allowed between sections of indented text.  The literal block ends
with the end of the indentation.</p>
<p>Syntax diagram:</p>
<pre class="literal-block">
+------------------------------+
| paragraph                    |
| (ends with &quot;::&quot;)             |
+------------------------------+
   +---------------------------+
   | indented literal block    |
   +---------------------------+
</pre>
</div>
<div class="section" id="quoted-literal-blocks">
<h4><a class="toc-backref" href="#id39" name="quoted-literal-blocks">Quoted Literal Blocks</a></h4>
<p>Quoted literal blocks are unindented contiguous blocks of text where
each line begins with the same non-alphanumeric printable 7-bit ASCII
character <a class="footnote-reference" href="#id10" id="id9" name="id9"><sup>5</sup></a>.  A blank line ends a quoted literal block.  The
quoting characters are preserved in the processed document.</p>
<table class="footnote" frame="void" id="id10" rules="none">
<colgroup><col class="label" /><col /></colgroup>
<tbody valign="top">
<tr><td class="label"><a class="fn-backref" href="#id9" name="id10">[5]</a></td><td><p>The following are all valid quoting characters:</p>
<pre class="literal-block">
! &quot; # $ % &amp; ' ( ) * + , - . / : ; &lt; = &gt; ? &#64; [ \ ] ^ _ ` { | } ~
</pre>
<p>Note that these are the same characters as are valid for title
adornment of <a class="reference" href="#sections">sections</a>.</p>
</td></tr>
</tbody>
</table>
<p>Possible uses include literate programming in Haskell and email
quoting:</p>
<pre class="literal-block">
John Doe wrote::

&gt;&gt; Great idea!
&gt;
&gt; Why didn't I think of that?

You just did!  ;-)
</pre>
<p>Syntax diagram:</p>
<pre class="literal-block">
+------------------------------+
| paragraph                    |
| (ends with &quot;::&quot;)             |
+------------------------------+
+------------------------------+
| &quot;&gt;&quot; per-line-quoted          |
| &quot;&gt;&quot; contiguous literal block |
+------------------------------+
</pre>
</div>
</div>
<div class="section" id="block-quotes">
<h3><a class="toc-backref" href="#id40" name="block-quotes">Block Quotes</a></h3>
<p>Doctree element: block_quote, attribution.</p>
<p>A text block that is indented relative to the preceding text, without
markup indicating it to be a literal block, is a block quote.  All
markup processing (for body elements and inline markup) continues
within the block quote:</p>
<pre class="literal-block">
This is an ordinary paragraph, introducing a block quote.

    &quot;It is my business to know things.  That is my trade.&quot;

    -- Sherlock Holmes
</pre>
<p>If the final block of a block quote begins with &quot;--&quot;, &quot;---&quot;, or a true
em-dash (flush left within the block quote), it is interpreted as an
attribution.  If the attribution consists of multiple lines, the left
edges of the second and subsequent lines must align.</p>
<p>Blank lines are required before and after a block quote, but these
blank lines are not included as part of the block quote.</p>
<p>Syntax diagram:</p>
<pre class="literal-block">
+------------------------------+
| (current level of            |
| indentation)                 |
+------------------------------+
   +---------------------------+
   | block quote               |
   | (body elements)+          |
   |                           |
   | -- attribution text       |
   |    (optional)             |
   +---------------------------+
</pre>
</div>
<div class="section" id="doctest-blocks">
<h3><a class="toc-backref" href="#id41" name="doctest-blocks">Doctest Blocks</a></h3>
<p>Doctree element: doctest_block.</p>
<p>Doctest blocks are interactive Python sessions cut-and-pasted into
docstrings.  They are meant to illustrate usage by example, and
provide an elegant and powerful testing environment via the <a class="reference" href="http://www.python.org/doc/current/lib/module-doctest.html">doctest
module</a> in the Python standard library.</p>
<p>Doctest blocks are text blocks which begin with <tt class="literal"><span class="pre">&quot;&gt;&gt;&gt;</span> <span class="pre">&quot;</span></tt>, the Python
interactive interpreter main prompt, and end with a blank line.
Doctest blocks are treated as a special case of literal blocks,
without requiring the literal block syntax.  If both are present, the
literal block syntax takes priority over Doctest block syntax:</p>
<pre class="literal-block">
This is an ordinary paragraph.

&gt;&gt;&gt; print 'this is a Doctest block'
this is a Doctest block

The following is a literal block::

    &gt;&gt;&gt; This is not recognized as a doctest block by
    reStructuredText.  It *will* be recognized by the doctest
    module, though!
</pre>
<p>Indentation is not required for doctest blocks.</p>
</div>
<div class="section" id="tables">
<h3><a class="toc-backref" href="#id42" name="tables">Tables</a></h3>
<p>Doctree elements: table, tgroup, colspec, thead, tbody, row, entry.</p>
<p>ReStructuredText provides two syntaxes for delineating table cells:
<a class="reference" href="#grid-tables">Grid Tables</a> and <a class="reference" href="#simple-tables">Simple Tables</a>.</p>
<p>As with other body elements, blank lines are required before and after
tables.  Tables' left edges should align with the left edge of
preceding text blocks; if indented, the table is considered to be part
of a block quote.</p>
<p>Once isolated, each table cell is treated as a miniature document; the
top and bottom cell boundaries act as delimiting blank lines.  Each
cell contains zero or more body elements.  Cell contents may include
left and/or right margins, which are removed before processing.</p>
<div class="section" id="grid-tables">
<h4><a class="toc-backref" href="#id43" name="grid-tables">Grid Tables</a></h4>
<p>Grid tables provide a complete table representation via grid-like
&quot;ASCII art&quot;.  Grid tables allow arbitrary cell contents (body
elements), and both row and column spans.  However, grid tables can be
cumbersome to produce, especially for simple data sets.  The <a class="reference" href="http://table.sourceforge.net/">Emacs
table mode</a> is a tool that allows easy editing of grid tables, in
Emacs.  See <a class="reference" href="#simple-tables">Simple Tables</a> for a simpler (but limited)
representation.</p>
<p>Grid tables are described with a visual grid made up of the characters
&quot;-&quot;, &quot;=&quot;, &quot;|&quot;, and &quot;+&quot;.  The hyphen (&quot;-&quot;) is used for horizontal lines
(row separators).  The equals sign (&quot;=&quot;) may be used to separate
optional header rows from the table body (not supported by the <a class="reference" href="http://table.sourceforge.net/">Emacs
table mode</a>).  The vertical bar (&quot;|&quot;) is used for vertical lines
(column separators).  The plus sign (&quot;+&quot;) is used for intersections of
horizontal and vertical lines.  Example:</p>
<pre class="literal-block">
+------------------------+------------+----------+----------+
| Header row, column 1   | Header 2   | Header 3 | Header 4 |
| (header rows optional) |            |          |          |
+========================+============+==========+==========+
| body row 1, column 1   | column 2   | column 3 | column 4 |
+------------------------+------------+----------+----------+
| body row 2             | Cells may span columns.          |
+------------------------+------------+---------------------+
| body row 3             | Cells may  | - Table cells       |
+------------------------+ span rows. | - contain           |
| body row 4             |            | - body elements.    |
+------------------------+------------+---------------------+
</pre>
<p>Some care must be taken with grid tables to avoid undesired
interactions with cell text in rare cases.  For example, the following
table contains a cell in row 2 spanning from column 2 to column 4:</p>
<pre class="literal-block">
+--------------+----------+-----------+-----------+
| row 1, col 1 | column 2 | column 3  | column 4  |
+--------------+----------+-----------+-----------+
| row 2        |                                  |
+--------------+----------+-----------+-----------+
| row 3        |          |           |           |
+--------------+----------+-----------+-----------+
</pre>
<p>If a vertical bar is used in the text of that cell, it could have
unintended effects if accidentally aligned with column boundaries:</p>
<pre class="literal-block">
+--------------+----------+-----------+-----------+
| row 1, col 1 | column 2 | column 3  | column 4  |
+--------------+----------+-----------+-----------+
| row 2        | Use the command ``ls | more``.   |
+--------------+----------+-----------+-----------+
| row 3        |          |           |           |
+--------------+----------+-----------+-----------+
</pre>
<p>Several solutions are possible.  All that is needed is to break the
continuity of the cell outline rectangle.  One possibility is to shift
the text by adding an extra space before:</p>
<pre class="literal-block">
+--------------+----------+-----------+-----------+
| row 1, col 1 | column 2 | column 3  | column 4  |
+--------------+----------+-----------+-----------+
| row 2        |  Use the command ``ls | more``.  |
+--------------+----------+-----------+-----------+
| row 3        |          |           |           |
+--------------+----------+-----------+-----------+
</pre>
<p>Another possibility is to add an extra line to row 2:</p>
<pre class="literal-block">
+--------------+----------+-----------+-----------+
| row 1, col 1 | column 2 | column 3  | column 4  |
+--------------+----------+-----------+-----------+
| row 2        | Use the command ``ls | more``.   |
|              |                                  |
+--------------+----------+-----------+-----------+
| row 3        |          |           |           |
+--------------+----------+-----------+-----------+
</pre>
</div>
<div class="section" id="simple-tables">
<h4><a class="toc-backref" href="#id44" name="simple-tables">Simple Tables</a></h4>
<p>Simple tables provide a compact and easy to type but limited
row-oriented table representation for simple data sets.  Cell contents
are typically single paragraphs, although arbitrary body elements may
be represented in most cells.  Simple tables allow multi-line rows (in
all but the first column) and column spans, but not row spans.  See
<a class="reference" href="#grid-tables">Grid Tables</a> above for a complete table representation.</p>
<p>Simple tables are described with horizontal borders made up of &quot;=&quot; and
&quot;-&quot; characters.  The equals sign (&quot;=&quot;) is used for top and bottom
table borders, and to separate optional header rows from the table
body.  The hyphen (&quot;-&quot;) is used to indicate column spans in a single
row by underlining the joined columns.</p>
<p>A simple table begins with a top border of equals signs with one or
more spaces at each column boundary (two or more spaces recommended).
Regardless of spans, the top border <em>must</em> fully describe all table
columns.  There must be at least two columns in the table (to
differentiate it from section headers).  The last of the optional
header rows is underlined with '=', again with spaces at column
boundaries.  There may not be a blank line below the header row
separator; it would be interpreted as the bottom border of the table.
The bottom boundary of the table consists of '=' underlines, also with
spaces at column boundaries.  For example, here is a truth table, a
three-column table with one header row and four body rows:</p>
<pre class="literal-block">
=====  =====  =======
  A      B    A and B
=====  =====  =======
False  False  False
True   False  False
False  True   False
True   True   True
=====  =====  =======
</pre>
<p>Underlines of '-' may be used to indicate column spans by &quot;filling in&quot;
column margins to join adjacent columns.  Column span underlines must
be complete (they must cover all columns) and align with established
column boundaries.  Text lines containing column span underlines may
not contain any other text.  A column span underline applies only to
one row immediately above it.  For example, here is a table with a
column span in the header:</p>
<pre class="literal-block">
=====  =====  ======
   Inputs     Output
------------  ------
  A      B    A or B
=====  =====  ======
False  False  False
True   False  True
False  True   True
True   True   True
=====  =====  ======
</pre>
<p>Each line of text must contain spaces at column boundaries, except
where cells have been joined by column spans.  Each line of text
starts a new row, except when there is a blank cell in the first
column.  In that case, that line of text is parsed as a continuation
line.  For this reason, cells in the first column of new rows (<em>not</em>
continuation lines) <em>must</em> contain some text; blank cells would lead
to a misinterpretation.  An empty comment (&quot;..&quot;) is sufficient and
will be omitted from the processed output (see <a class="reference" href="#comments">Comments</a> below).
Also, this mechanism limits cells in the first column to only one line
of text.  Use <a class="reference" href="#grid-tables">grid tables</a> if this limitation is unacceptable.</p>
<p>Underlines of '-' may also be used to visually separate rows, even if
there are no column spans.  This is especially useful in long tables,
where rows are many lines long.</p>
<p>Blank lines are permitted within simple tables.  Their interpretation
depends on the context.  Blank lines <em>between</em> rows are ignored.
Blank lines <em>within</em> multi-line rows may separate paragraphs or other
body elements within cells.</p>
<p>The rightmost column is unbounded; text may continue past the edge of
the table (as indicated by the table borders).  However, it is
recommended that borders be made long enough to contain the entire
text.</p>
<p>The following example illustrates continuation lines (row 2 consists
of two lines of text, and four lines for row 3), a blank line
separating paragraphs (row 3, column 2), and text extending past the
right edge of the table:</p>
<pre class="literal-block">
=====  =====
col 1  col 2
=====  =====
1      Second column of row 1.
2      Second column of row 2.
       Second line of paragraph.
3      - Second column of row 3.

       - Second item in bullet
         list (row 3, column 2).
=====  =====
</pre>
</div>
</div>
<div class="section" id="explicit-markup-blocks">
<h3><a class="toc-backref" href="#id45" name="explicit-markup-blocks">Explicit Markup Blocks</a></h3>
<p>An explicit markup block is a text block:</p>
<ul class="simple">
<li>whose first line begins with &quot;..&quot; followed by whitespace (the
&quot;explicit markup start&quot;),</li>
<li>whose second and subsequent lines (if any) are indented relative to
the first, and</li>
<li>which ends before an unindented line.</li>
</ul>
<p>Explicit markup blocks are analogous to bullet list items, with &quot;..&quot;
as the bullet.  The text immediately after the explicit markup start
determines the indentation of the block body.  Blank lines are
required between explicit markup blocks and other elements, but are
optional between explicit markup blocks where unambiguous.</p>
<p>The explicit markup syntax is used for footnotes, citations, hyperlink
targets, directives, substitution definitions, and comments.</p>
<div class="section" id="footnotes">
<h4><a class="toc-backref" href="#id46" name="footnotes">Footnotes</a></h4>
<p>Doctree elements: footnote, label.</p>
<p>Each footnote consists of an explicit markup start (&quot;.. &quot;), a left
square bracket, the footnote label, a right square bracket, and
whitespace, followed by indented body elements.  A footnote label can
be:</p>
<ul class="simple">
<li>a whole decimal number consisting of one or more digits,</li>
<li>a single &quot;#&quot; (denoting <a class="reference" href="#auto-numbered-footnotes">auto-numbered footnotes</a>),</li>
<li>a &quot;#&quot; followed by a simple reference name (an <a class="reference" href="#autonumber-labels">autonumber label</a>),
or</li>
<li>a single &quot;*&quot; (denoting <a class="reference" href="#auto-symbol-footnotes">auto-symbol footnotes</a>).</li>
</ul>
<p>If the first body element within a footnote is a simple paragraph, it
may begin on the same line as the footnote label.  Other elements must
begin on a new line, consistently indented (by at least 3 spaces) and
left-aligned.</p>
<p>Footnotes may occur anywhere in the document, not only at the end.
Where or how they appear in the processed output depends on the
processing system.</p>
<p>Here is a manually numbered footnote:</p>
<pre class="literal-block">
.. [1] Body elements go here.
</pre>
<p>Each footnote automatically generates a hyperlink target pointing to
itself.  The text of the hyperlink target name is the same as that of
the footnote label.  <a class="reference" href="#auto-numbered-footnotes">Auto-numbered footnotes</a> generate a number as
their footnote label and reference name.  See <a class="reference" href="#implicit-hyperlink-targets">Implicit Hyperlink
Targets</a> for a complete description of the mechanism.</p>
<p>Syntax diagram:</p>
<pre class="literal-block">
+-------+-------------------------+
| &quot;.. &quot; | &quot;[&quot; label &quot;]&quot; footnote  |
+-------+                         |
        | (body elements)+        |
        +-------------------------+
</pre>
<div class="section" id="auto-numbered-footnotes">
<h5><a class="toc-backref" href="#id47" name="auto-numbered-footnotes">Auto-Numbered Footnotes</a></h5>
<p>A number sign (&quot;#&quot;) may be used as the first character of a footnote
label to request automatic numbering of the footnote or footnote
reference.</p>
<p>The first footnote to request automatic numbering is assigned the
label &quot;1&quot;, the second is assigned the label &quot;2&quot;, and so on (assuming
there are no manually numbered footnotes present; see <a class="reference" href="#mixed-manual-and-auto-numbered-footnotes">Mixed Manual
and Auto-Numbered Footnotes</a> below).  A footnote which has
automatically received a label &quot;1&quot; generates an implicit hyperlink
target with name &quot;1&quot;, just as if the label was explicitly specified.</p>
<p>A footnote may specify a label explicitly while at the same time
requesting automatic numbering: <tt class="literal"><span class="pre">[#label]</span></tt>.  These labels are called
<a class="target" id="autonumber-labels" name="autonumber-labels">autonumber labels</a>.  Autonumber labels do two things:</p>
<ul>
<li><p class="first">On the footnote itself, they generate a hyperlink target whose name
is the autonumber label (doesn't include the &quot;#&quot;).</p>
</li>
<li><p class="first">They allow an automatically numbered footnote to be referred to more
than once, as a footnote reference or hyperlink reference.  For
example:</p>
<pre class="literal-block">
If [#note]_ is the first footnote reference, it will show up as
&quot;[1]&quot;.  We can refer to it again as [#note]_ and again see
&quot;[1]&quot;.  We can also refer to it as note_ (an ordinary internal
hyperlink reference).

.. [#note] This is the footnote labeled &quot;note&quot;.
</pre>
</li>
</ul>
<p>The numbering is determined by the order of the footnotes, not by the
order of the references.  For footnote references without autonumber
labels (<tt class="literal"><span class="pre">[#]_</span></tt>), the footnotes and footnote references must be in
the same relative order but need not alternate in lock-step.  For
example:</p>
<pre class="literal-block">
[#]_ is a reference to footnote 1, and [#]_ is a reference to
footnote 2.

.. [#] This is footnote 1.
.. [#] This is footnote 2.
.. [#] This is footnote 3.

[#]_ is a reference to footnote 3.
</pre>
<p>Special care must be taken if footnotes themselves contain
auto-numbered footnote references, or if multiple references are made
in close proximity.  Footnotes and references are noted in the order
they are encountered in the document, which is not necessarily the
same as the order in which a person would read them.</p>
</div>
<div class="section" id="auto-symbol-footnotes">
<h5><a class="toc-backref" href="#id48" name="auto-symbol-footnotes">Auto-Symbol Footnotes</a></h5>
<p>An asterisk (&quot;*&quot;) may be used for footnote labels to request automatic
symbol generation for footnotes and footnote references.  The asterisk
may be the only character in the label.  For example:</p>
<pre class="literal-block">
Here is a symbolic footnote reference: [*]_.

.. [*] This is the footnote.
</pre>
<p>A transform will insert symbols as labels into corresponding footnotes
and footnote references.  The number of references must be equal to
the number of footnotes.  One symbol footnote cannot have multiple
references.</p>
<p>The standard Docutils system uses the following symbols for footnote
marks <a class="footnote-reference" href="#id12" id="id11" name="id11"><sup>6</sup></a>:</p>
<ul class="simple">
<li>asterisk/star (&quot;*&quot;)</li>
<li>dagger (HTML character entity &quot;&amp;dagger;&quot;, Unicode U+02020)</li>
<li>double dagger (&quot;&amp;Dagger;&quot;/U+02021)</li>
<li>section mark (&quot;&amp;sect;&quot;/U+000A7)</li>
<li>pilcrow or paragraph mark (&quot;&amp;para;&quot;/U+000B6)</li>
<li>number sign (&quot;#&quot;)</li>
<li>spade suit (&quot;&amp;spades;&quot;/U+02660)</li>
<li>heart suit (&quot;&amp;hearts;&quot;/U+02665)</li>
<li>diamond suit (&quot;&amp;diams;&quot;/U+02666)</li>
<li>club suit (&quot;&amp;clubs;&quot;/U+02663)</li>
</ul>
<table class="footnote" frame="void" id="id12" rules="none">
<colgroup><col class="label" /><col /></colgroup>
<tbody valign="top">
<tr><td class="label"><a class="fn-backref" href="#id11" name="id12">[6]</a></td><td>This list was inspired by the list of symbols for &quot;Note
Reference Marks&quot; in The Chicago Manual of Style, 14th edition,
section 12.51.  &quot;Parallels&quot; (&quot;||&quot;) were given in CMoS instead of
the pilcrow.  The last four symbols (the card suits) were added
arbitrarily.</td></tr>
</tbody>
</table>
<p>If more than ten symbols are required, the same sequence will be
reused, doubled and then tripled, and so on (&quot;**&quot; etc.).</p>
<div class="note">
<p class="admonition-title">Note</p>
When using auto-symbol footnotes, the choice of output
encoding is important.  Many of the symbols used are not encodable
in certain common text encodings such as Latin-1 (ISO 8859-1).  The
use of UTF-8 for the output encoding is recommended.  An
alternative for HTML and XML output is to use the
&quot;xmlcharrefreplace&quot; <a class="reference" href="http://docutils.sf.net/docs/config.html#output-encoding-error-handler">output encoding error handler</a> (available in
Python 2.3 &amp; later).</div>
</div>
<div class="section" id="mixed-manual-and-auto-numbered-footnotes">
<h5><a class="toc-backref" href="#id49" name="mixed-manual-and-auto-numbered-footnotes">Mixed Manual and Auto-Numbered Footnotes</a></h5>
<p>Manual and automatic footnote numbering may both be used within a
single document, although the results may not be expected.  Manual
numbering takes priority.  Only unused footnote numbers are assigned
to auto-numbered footnotes.  The following example should be
illustrative:</p>
<pre class="literal-block">
[2]_ will be &quot;2&quot; (manually numbered),
[#]_ will be &quot;3&quot; (anonymous auto-numbered), and
[#label]_ will be &quot;1&quot; (labeled auto-numbered).

.. [2] This footnote is labeled manually, so its number is fixed.

.. [#label] This autonumber-labeled footnote will be labeled &quot;1&quot;.
   It is the first auto-numbered footnote and no other footnote
   with label &quot;1&quot; exists.  The order of the footnotes is used to
   determine numbering, not the order of the footnote references.

.. [#] This footnote will be labeled &quot;3&quot;.  It is the second
   auto-numbered footnote, but footnote label &quot;2&quot; is already used.
</pre>
</div>
</div>
<div class="section" id="citations">
<h4><a class="toc-backref" href="#id50" name="citations">Citations</a></h4>
<p>Citations are identical to footnotes except that they use only
non-numeric labels such as <tt class="literal"><span class="pre">[note]</span></tt> or <tt class="literal"><span class="pre">[GVR2001]</span></tt>.  Citation
labels are simple <a class="reference" href="#reference-names">reference names</a> (case-insensitive single words
consisting of alphanumerics plus internal hyphens, underscores, and
periods; no whitespace).  Citations may be rendered separately and
differently from footnotes.  For example:</p>
<pre class="literal-block">
Here is a citation reference: [CIT2002]_.

.. [CIT2002] This is the citation.  It's just like a footnote,
   except the label is textual.
</pre>
<a class="target" id="hyperlinks" name="hyperlinks"></a></div>
<div class="section" id="hyperlink-targets">
<h4><a class="toc-backref" href="#id51" name="hyperlink-targets">Hyperlink Targets</a></h4>
<p>Doctree element: target.</p>
<p>These are also called <a class="target" id="explicit-hyperlink-targets" name="explicit-hyperlink-targets">explicit hyperlink targets</a>, to differentiate
them from <a class="reference" href="#implicit-hyperlink-targets">implicit hyperlink targets</a> defined below.</p>
<p>Hyperlink targets identify a location within or outside of a document,
which may be linked to by <a class="reference" href="#hyperlink-references">hyperlink references</a>.</p>
<p>Hyperlink targets may be named or anonymous.  Named hyperlink targets
consist of an explicit markup start (&quot;.. &quot;), an underscore, the
reference name (no trailing underscore), a colon, whitespace, and a
link block:</p>
<pre class="literal-block">
.. _hyperlink-name: link-block
</pre>
<p>Reference names are whitespace-neutral and case-insensitive.  See
<a class="reference" href="#reference-names">Reference Names</a> for details and examples.</p>
<p>Anonymous hyperlink targets consist of an explicit markup start
(&quot;.. &quot;), two underscores, a colon, whitespace, and a link block; there
is no reference name:</p>
<pre class="literal-block">
.. __: anonymous-hyperlink-target-link-block
</pre>
<p>An alternate syntax for anonymous hyperlinks consists of two
underscores, a space, and a link block:</p>
<pre class="literal-block">
__ anonymous-hyperlink-target-link-block
</pre>
<p>See <a class="reference" href="#anonymous-hyperlinks">Anonymous Hyperlinks</a> below.</p>
<p>There are three types of hyperlink targets: internal, external, and
indirect.</p>
<ol class="arabic">
<li><p class="first"><a class="target" id="internal-hyperlink-targets" name="internal-hyperlink-targets">Internal hyperlink targets</a> have empty link blocks.  They provide
an end point allowing a hyperlink to connect one place to another
within a document.  An internal hyperlink target points to the
element following the target.  For example:</p>
<pre class="literal-block">
Clicking on this internal hyperlink will take us to the target_
below.

.. _target:

The hyperlink target above points to this paragraph.
</pre>
<p>Internal hyperlink targets may be &quot;chained&quot;.  Multiple adjacent
internal hyperlink targets all point to the same element:</p>
<pre class="literal-block">
.. _target1:
.. _target2:

The targets &quot;target1&quot; and &quot;target2&quot; are synonyms; they both
point to this paragraph.
</pre>
<p>If the element &quot;pointed to&quot; is an external hyperlink target (with a
URI in its link block; see #2 below) the URI from the external
hyperlink target is propagated to the internal hyperlink targets;
they will all &quot;point to&quot; the same URI.  There is no need to
duplicate a URI.  For example, all three of the following hyperlink
targets refer to the same URI:</p>
<pre class="literal-block">
   .. _Python DOC-SIG mailing list archive:
   .. _archive:
   .. _Doc-SIG: http://mail.python.org/pipermail/doc-sig/

An inline form of internal hyperlink target is available; see
`Inline Internal Targets`_.
</pre>
</li>
<li><p class="first"><a class="target" id="external-hyperlink-targets" name="external-hyperlink-targets">External hyperlink targets</a> have an absolute or relative URI or
email address in their link blocks.  For example, take the
following input:</p>
<pre class="literal-block">
See the Python_ home page for info.

`Write to me`_ with your questions.

.. _Python: http://www.python.org
.. _Write to me: jdoe&#64;example.com
</pre>
<p>After processing into HTML, the hyperlinks might be expressed as:</p>
<pre class="literal-block">
See the &lt;a href=&quot;http://www.python.org&quot;&gt;Python&lt;/a&gt; home page
for info.

&lt;a href=&quot;mailto:jdoe&#64;example.com&quot;&gt;Write to me&lt;/a&gt; with your
questions.
</pre>
<p>An external hyperlink's URI may begin on the same line as the
explicit markup start and target name, or it may begin in an
indented text block immediately following, with no intervening
blank lines.  If there are multiple lines in the link block, they
are stripped of leading and trailing whitespace and concatenated.
The following external hyperlink targets are equivalent:</p>
<pre class="literal-block">
.. _one-liner: http://docutils.sourceforge.net/rst.html

.. _starts-on-this-line: http://
   docutils.sourceforge.net/rst.html

.. _entirely-below:
   http://docutils.
   sourceforge.net/rst.html
</pre>
<p>If an external hyperlink target's URI contains an underscore as its
last character, it must be escaped to avoid being mistaken for an
indirect hyperlink target:</p>
<pre class="literal-block">
This link_ refers to a file called ``underscore_``.

.. _link: underscore\_
</pre>
<p>It is possible (although not generally recommended) to include URIs
directly within hyperlink references.  See <a class="reference" href="#embedded-uris">Embedded URIs</a> below.</p>
</li>
<li><p class="first"><a class="target" id="indirect-hyperlink-targets" name="indirect-hyperlink-targets">Indirect hyperlink targets</a> have a hyperlink reference in their
link blocks.  In the following example, target &quot;one&quot; indirectly
references whatever target &quot;two&quot; references, and target &quot;two&quot;
references target &quot;three&quot;, an internal hyperlink target.  In
effect, all three reference the same thing:</p>
<pre class="literal-block">
.. _one: two_
.. _two: three_
.. _three:
</pre>
<p>Just as with <a class="reference" href="#hyperlink-references">hyperlink references</a> anywhere else in a document,
if a phrase-reference is used in the link block it must be enclosed
in backquotes.  As with <a class="reference" href="#external-hyperlink-targets">external hyperlink targets</a>, the link
block of an indirect hyperlink target may begin on the same line as
the explicit markup start or the next line.  It may also be split
over multiple lines, in which case the lines are joined with
whitespace before being normalized.</p>
<p>For example, the following indirect hyperlink targets are
equivalent:</p>
<pre class="literal-block">
.. _one-liner: `A HYPERLINK`_
.. _entirely-below:
   `a    hyperlink`_
.. _split: `A
   Hyperlink`_
</pre>
</li>
</ol>
<p>If a reference name contains a colon followed by whitespace, either:</p>
<ul>
<li><p class="first">the phrase must be enclosed in backquotes:</p>
<pre class="literal-block">
.. _`FAQTS: Computers: Programming: Languages: Python`:
   http://python.faqts.com/
</pre>
</li>
<li><p class="first">or the colon(s) must be backslash-escaped in the link target:</p>
<pre class="literal-block">
.. _Chapter One\: &quot;Tadpole Days&quot;:

It's not easy being green...
</pre>
</li>
</ul>
<p>See <a class="reference" href="#implicit-hyperlink-targets">Implicit Hyperlink Targets</a> below for the resolution of
duplicate reference names.</p>
<p>Syntax diagram:</p>
<pre class="literal-block">
+-------+----------------------+
| &quot;.. &quot; | &quot;_&quot; name &quot;:&quot; link    |
+-------+ block                |
        |                      |
        +----------------------+
</pre>
<div class="section" id="anonymous-hyperlinks">
<h5><a class="toc-backref" href="#id52" name="anonymous-hyperlinks">Anonymous Hyperlinks</a></h5>
<p>The <a class="reference" href="http://www.w3.org/">World Wide Web Consortium</a> recommends in its <a class="reference" href="http://www.w3.org/TR/WCAG10-HTML-TECHS/#link-text">HTML Techniques
for Web Content Accessibility Guidelines</a> that authors should
&quot;clearly identify the target of each link.&quot;  Hyperlink references
should be as verbose as possible, but duplicating a verbose hyperlink
name in the target is onerous and error-prone.  Anonymous hyperlinks
are designed to allow convenient verbose hyperlink references, and are
analogous to <a class="reference" href="#auto-numbered-footnotes">Auto-Numbered Footnotes</a>.  They are particularly useful
in short or one-off documents.  However, this feature is easily abused
and can result in unreadable plaintext and/or unmaintainable
documents.  Caution is advised.</p>
<p>Anonymous <a class="reference" href="#hyperlink-references">hyperlink references</a> are specified with two underscores
instead of one:</p>
<pre class="literal-block">
See `the web site of my favorite programming language`__.
</pre>
<p>Anonymous targets begin with &quot;.. __:&quot;; no reference name is required
or allowed:</p>
<pre class="literal-block">
.. __: http://www.python.org
</pre>
<p>As a convenient alternative, anonymous targets may begin with &quot;__&quot;
only:</p>
<pre class="literal-block">
__ http://www.python.org
</pre>
<p>The reference name of the reference is not used to match the reference
to its target.  Instead, the order of anonymous hyperlink references
and targets within the document is significant: the first anonymous
reference will link to the first anonymous target.  The number of
anonymous hyperlink references in a document must match the number of
anonymous targets.  For readability, it is recommended that targets be
kept close to references.  Take care when editing text containing
anonymous references; adding, removing, and rearranging references
require attention to the order of corresponding targets.</p>
</div>
</div>
<div class="section" id="directives">
<h4><a class="toc-backref" href="#id53" name="directives">Directives</a></h4>
<p>Doctree elements: depend on the directive.</p>
<p>Directives are an extension mechanism for reStructuredText, a way of
adding support for new constructs without adding new syntax.  All
standard directives (those implemented and registered in the reference
reStructuredText parser) are described in the <a class="reference" href="directives.html">reStructuredText
Directives</a> document, and are always available.  Any other directives
are domain-specific, and may require special action to make them
available when processing the document.</p>
<p>For example, here's how an image may be placed:</p>
<pre class="literal-block">
.. image:: mylogo.jpeg
</pre>
<p>A figure (a graphic with a caption) may placed like this:</p>
<pre class="literal-block">
.. figure:: larch.png

   The larch.
</pre>
<p>An admonition (note, caution, etc.) contains other body elements:</p>
<pre class="literal-block">
.. note:: This is a paragraph

   - Here is a bullet list.
</pre>
<p>Directives are indicated by an explicit markup start (&quot;.. &quot;) followed
by the directive type, two colons, and whitespace (together called the
&quot;directive marker&quot;).  Directive types are case-insensitive single
words (alphanumerics plus internal hyphens, underscores, and periods;
no whitespace).  Two colons are used after the directive type for
these reasons:</p>
<ul>
<li><p class="first">To avoid clashes with common comment text like:</p>
<pre class="literal-block">
.. Danger: modify at your own risk!
</pre>
</li>
<li><p class="first">If an implementation of reStructuredText does not recognize a
directive (i.e., the directive-handler is not installed), the entire
directive block (including the directive itself) will be treated as
a literal block, and a level-3 (error) system message generated.
Thus &quot;::&quot; is a natural choice.</p>
</li>
</ul>
<p>The directive block is consists of any text on the first line of the
directive after the directive marker, and any subsequent indented
text.  The interpretation of the directive block is up to the
directive code.  There are three logical parts to the directive block:</p>
<ol class="arabic simple">
<li>Directive arguments.</li>
<li>Directive options.</li>
<li>Directive content.</li>
</ol>
<p>Individual directives can employ any combination of these parts.
Directive arguments can be filesystem paths, URLs, title text, etc.
Directive options are indicated using <a class="reference" href="#field-lists">field lists</a>; the field names
and contents are directive-specific.  Arguments and options must form
a contiguous block beginning on the first or second line of the
directive; a blank line indicates the beginning of the directive
content block.  If either arguments and/or options are employed by the
directive, a blank line must separate them from the directive content.
The &quot;figure&quot; directive employs all three parts:</p>
<pre class="literal-block">
.. figure:: larch.png
   :scale: 50

   The larch.
</pre>
<p>Simple directives may not require any content.  If a directive that
does not employ a content block is followed by indented text anyway,
it is an error.  If a block quote should immediately follow a
directive, use an empty comment in-between (see <a class="reference" href="#comments">Comments</a> below).</p>
<p>Actions taken in response to directives and the interpretation of text
in the directive content block or subsequent text block(s) are
directive-dependent.  See <a class="reference" href="directives.html">reStructuredText Directives</a> for details.</p>
<p>Directives are meant for the arbitrary processing of their contents,
which can be transformed into something possibly unrelated to the
original text.  It may also be possible for directives to be used as
pragmas, to modify the behavior of the parser, such as to experiment
with alternate syntax.  There is no parser support for this
functionality at present; if a reasonable need for pragma directives
is found, they may be supported.</p>
<p>Directives do not generate &quot;directive&quot; elements; they are a <em>parser
construct</em> only, and have no intrinsic meaning outside of
reStructuredText.  Instead, the parser will transform recognized
directives into (possibly specialized) document elements.  Unknown
directives will trigger level-3 (error) system messages.</p>
<p>Syntax diagram:</p>
<pre class="literal-block">
+-------+-------------------------------+
| &quot;.. &quot; | directive type &quot;::&quot; directive |
+-------+ block                         |
        |                               |
        +-------------------------------+
</pre>
</div>
<div class="section" id="substitution-definitions">
<h4><a class="toc-backref" href="#id54" name="substitution-definitions">Substitution Definitions</a></h4>
<p>Doctree element: substitution_definition.</p>
<p>Substitution definitions are indicated by an explicit markup start
(&quot;.. &quot;) followed by a vertical bar, the substitution text, another
vertical bar, whitespace, and the definition block.  Substitution text
may not begin or end with whitespace.  A substitution definition block
contains an embedded inline-compatible directive (without the leading
&quot;.. &quot;), such as an image.  For example:</p>
<pre class="literal-block">
The |biohazard| symbol must be used on containers used to
dispose of medical waste.

.. |biohazard| image:: biohazard.png
</pre>
<p>It is an error for a substitution definition block to directly or
indirectly contain a circular substitution reference.</p>
<p><a class="reference" href="#substitution-references">Substitution references</a> are replaced in-line by the processed
contents of the corresponding definition (linked by matching
substitution text).  Matches are case-sensitive but forgiving; if no
exact match is found, a case-insensitive comparison is attempted.</p>
<p>Substitution definitions allow the power and flexibility of
block-level <a class="reference" href="#directives">directives</a> to be shared by inline text.  They are a way
to include arbitrarily complex inline structures within text, while
keeping the details out of the flow of text.  They are the equivalent
of SGML/XML's named entities or programming language macros.</p>
<p>Without the substitution mechanism, every time someone wants an
application-specific new inline structure, they would have to petition
for a syntax change.  In combination with existing directive syntax,
any inline structure can be coded without new syntax (except possibly
a new directive).</p>
<p>Syntax diagram:</p>
<pre class="literal-block">
+-------+-----------------------------------------------------+
| &quot;.. &quot; | &quot;|&quot; substitution text &quot;| &quot; directive type &quot;::&quot; data |
+-------+ directive block                                     |
        |                                                     |
        +-----------------------------------------------------+
</pre>
<p>Following are some use cases for the substitution mechanism.  Please
note that most of the embedded directives shown are examples only and
have not been implemented.</p>
<dl>
<dt>Objects</dt>
<dd><p class="first">Substitution references may be used to associate ambiguous text
with a unique object identifier.</p>
<p>For example, many sites may wish to implement an inline &quot;user&quot;
directive:</p>
<pre class="literal-block">
|Michael| and |Jon| are our widget-wranglers.

.. |Michael| user:: mjones
.. |Jon|     user:: jhl
</pre>
<p>Depending on the needs of the site, this may be used to index the
document for later searching, to hyperlink the inline text in
various ways (mailto, homepage, mouseover Javascript with profile
and contact information, etc.), or to customize presentation of
the text (include username in the inline text, include an icon
image with a link next to the text, make the text bold or a
different color, etc.).</p>
<p>The same approach can be used in documents which frequently refer
to a particular type of objects with unique identifiers but
ambiguous common names.  Movies, albums, books, photos, court
cases, and laws are possible.  For example:</p>
<pre class="literal-block">
|The Transparent Society| offers a fascinating alternate view
on privacy issues.

.. |The Transparent Society| book:: isbn=0738201448
</pre>
<p>Classes or functions, in contexts where the module or class names
are unclear and/or interpreted text cannot be used, are another
possibility:</p>
<pre class="last literal-block">
4XSLT has the convenience method |runString|, so you don't
have to mess with DOM objects if all you want is the
transformed output.

.. |runString| function:: module=xml.xslt class=Processor
</pre>
</dd>
<dt>Images</dt>
<dd><p class="first">Images are a common use for substitution references:</p>
<pre class="literal-block">
West led the |H| 3, covered by dummy's |H| Q, East's |H| K,
and trumped in hand with the |S| 2.

.. |H| image:: /images/heart.png
   :height: 11
   :width: 11
.. |S| image:: /images/spade.png
   :height: 11
   :width: 11

* |Red light| means stop.
* |Green light| means go.
* |Yellow light| means go really fast.

.. |Red light|    image:: red_light.png
.. |Green light|  image:: green_light.png
.. |Yellow light| image:: yellow_light.png

|-&gt;&lt;-| is the official symbol of POEE_.

.. |-&gt;&lt;-| image:: discord.png
.. _POEE: http://www.poee.org/
</pre>
<p class="last">The &quot;image&quot; directive has been implemented.</p>
</dd>
<dt>Styles <a class="footnote-reference" href="#id15" id="id14" name="id14"><sup>7</sup></a></dt>
<dd><p class="first">Substitution references may be used to associate inline text with
an externally defined presentation style:</p>
<pre class="literal-block">
Even |the text in Texas| is big.

.. |the text in Texas| style:: big
</pre>
<p>The style name may be meaningful in the context of some particular
output format (CSS class name for HTML output, LaTeX style name
for LaTeX, etc), or may be ignored for other output formats (such
as plaintext).</p>
<!-- @@@ This needs to be rethought & rewritten or removed:

Interpreted text is unsuitable for this purpose because the set
of style names cannot be predefined - it is the domain of the
content author, not the author of the parser and output
formatter - and there is no way to associate a style name
argument with an interpreted text style role.  Also, it may be
desirable to use the same mechanism for styling blocks::

    .. style:: motto
       At Bob's Underwear Shop, we'll do anything to get in
       your pants.

    .. style:: disclaimer
       All rights reversed.  Reprint what you like. -->
<table class="last footnote" frame="void" id="id15" rules="none">
<colgroup><col class="label" /><col /></colgroup>
<tbody valign="top">
<tr><td class="label"><a class="fn-backref" href="#id14" name="id15">[7]</a></td><td>There may be sufficient need for a &quot;style&quot; mechanism to
warrant simpler syntax such as an extension to the interpreted
text role syntax.  The substitution mechanism is cumbersome for
simple text styling.</td></tr>
</tbody>
</table>
</dd>
<dt>Templates</dt>
<dd><p class="first">Inline markup may be used for later processing by a template
engine.  For example, a <a class="reference" href="http://www.zope.com/">Zope</a> author might write:</p>
<pre class="literal-block">
Welcome back, |name|!

.. |name| tal:: replace user/getUserName
</pre>
<p>After processing, this ZPT output would result:</p>
<pre class="literal-block">
Welcome back,
&lt;span tal:replace=&quot;user/getUserName&quot;&gt;name&lt;/span&gt;!
</pre>
<p class="last">Zope would then transform this to something like &quot;Welcome back,
David!&quot; during a session with an actual user.</p>
</dd>
<dt>Replacement text</dt>
<dd><p class="first">The substitution mechanism may be used for simple macro
substitution.  This may be appropriate when the replacement text
is repeated many times throughout one or more documents,
especially if it may need to change later.  A short example is
unavoidably contrived:</p>
<pre class="literal-block">
|RST| is a little annoying to type over and over, especially
when writing about |RST| itself, and spelling out the
bicapitalized word |RST| every time isn't really necessary for
|RST| source readability.

.. |RST| replace:: reStructuredText_
.. _reStructuredText: http://docutils.sourceforge.net/rst.html
</pre>
<p>Substitution is also appropriate when the replacement text cannot
be represented using other inline constructs, or is obtrusively
long:</p>
<pre class="last literal-block">
But still, that's nothing compared to a name like
|j2ee-cas|__.

.. |j2ee-cas| replace::
   the Java `TM`:super: 2 Platform, Enterprise Edition Client
   Access Services
__ http://developer.java.sun.com/developer/earlyAccess/
   j2eecas/
</pre>
</dd>
</dl>
</div>
<div class="section" id="comments">
<h4><a class="toc-backref" href="#id55" name="comments">Comments</a></h4>
<p>Doctree element: comment.</p>
<p>Arbitrary indented text may follow the explicit markup start and will
be processed as a comment element.  No further processing is done on
the comment block text; a comment contains a single &quot;text blob&quot;.
Depending on the output formatter, comments may be removed from the
processed output.  The only restriction on comments is that they not
use the same syntax as any of the other explicit markup constructs:
substitution definitions, directives, footnotes, citations, or
hyperlink targets.  To ensure that none of the other explicit markup
constructs is recognized, leave the &quot;..&quot; on a line by itself:</p>
<pre class="literal-block">
.. This is a comment
..
   _so: is this!
..
   [and] this!
..
   this:: too!
..
   |even| this:: !
</pre>
<p>A explicit markup start followed by a blank line and nothing else
(apart from whitespace) is an &quot;empty comment&quot;.  It serves to terminate
a preceding construct, and does <strong>not</strong> consume any indented text
following.  To have a block quote follow a list or any indented
construct, insert an unindented empty comment in-between.</p>
<p>Syntax diagram:</p>
<pre class="literal-block">
+-------+----------------------+
| &quot;.. &quot; | comment              |
+-------+ block                |
        |                      |
        +----------------------+
</pre>
</div>
</div>
</div>
<div class="section" id="implicit-hyperlink-targets">
<h2><a class="toc-backref" href="#id56" name="implicit-hyperlink-targets">Implicit Hyperlink Targets</a></h2>
<p>Implicit hyperlink targets are generated by section titles, footnotes,
and citations, and may also be generated by extension constructs.
Implicit hyperlink targets otherwise behave identically to explicit
<a class="reference" href="#hyperlink-targets">hyperlink targets</a>.</p>
<p>Problems of ambiguity due to conflicting duplicate implicit and
explicit reference names are avoided by following this procedure:</p>
<ol class="arabic simple">
<li><a class="reference" href="#explicit-hyperlink-targets">Explicit hyperlink targets</a> override any implicit targets having
the same reference name.  The implicit hyperlink targets are
removed, and level-1 (info) system messages are inserted.</li>
<li>Duplicate implicit hyperlink targets are removed, and level-1
(info) system messages inserted.  For example, if two or more
sections have the same title (such as &quot;Introduction&quot; subsections of
a rigidly-structured document), there will be duplicate implicit
hyperlink targets.</li>
<li>Duplicate explicit hyperlink targets are removed, and level-2
(warning) system messages are inserted.  Exception: duplicate
<a class="reference" href="#external-hyperlink-targets">external hyperlink targets</a> (identical hyperlink names and
referenced URIs) do not conflict, and are not removed.</li>
</ol>
<p>System messages are inserted where target links have been removed.
See &quot;Error Handling&quot; in <a class="reference" href="http://docutils.sourceforge.net/spec/pep-0258.txt">PEP 258</a>.</p>
<p>The parser must return a set of <em>unique</em> hyperlink targets.  The
calling software (such as the <a class="reference" href="http://docutils.sourceforge.net/">Docutils</a>) can warn of unresolvable
links, giving reasons for the messages.</p>
</div>
<div class="section" id="inline-markup">
<h2><a class="toc-backref" href="#id57" name="inline-markup">Inline Markup</a></h2>
<p>In reStructuredText, inline markup applies to words or phrases within
a text block.  The same whitespace and punctuation that serves to
delimit words in written text is used to delimit the inline markup
syntax constructs.  The text within inline markup may not begin or end
with whitespace.  Arbitrary <a class="reference" href="#character-level-inline-markup">character-level inline markup</a> is
supported although not encouraged.  Inline markup cannot be nested.</p>
<p>There are nine inline markup constructs.  Five of the constructs use
identical start-strings and end-strings to indicate the markup:</p>
<ul class="simple">
<li><a class="reference" href="#emphasis">emphasis</a>: &quot;*&quot;</li>
<li><a class="reference" href="#strong-emphasis">strong emphasis</a>: &quot;**&quot;</li>
<li><a class="reference" href="#interpreted-text">interpreted text</a>: &quot;`&quot;</li>
<li><a class="reference" href="#inline-literals">inline literals</a>: &quot;``&quot;</li>
<li><a class="reference" href="#substitution-references">substitution references</a>: &quot;|&quot;</li>
</ul>
<p>Three constructs use different start-strings and end-strings:</p>
<ul class="simple">
<li><a class="reference" href="#inline-internal-targets">inline internal targets</a>: &quot;_`&quot; and &quot;`&quot;</li>
<li><a class="reference" href="#footnote-references">footnote references</a>: &quot;[&quot; and &quot;]_&quot;</li>
<li><a class="reference" href="#hyperlink-references">hyperlink references</a>: &quot;`&quot; and &quot;`_&quot; (phrases), or just a
trailing &quot;_&quot; (single words)</li>
</ul>
<p><a class="reference" href="#standalone-hyperlinks">Standalone hyperlinks</a> are recognized implicitly, and use no extra
markup.</p>
<p>The inline markup start-string and end-string recognition rules are as
follows.  If any of the conditions are not met, the start-string or
end-string will not be recognized or processed.</p>
<ol class="arabic">
<li><p class="first">Inline markup start-strings must start a text block or be
immediately preceded by whitespace or one of:</p>
<pre class="literal-block">
' &quot; ( [ { &lt; - / :
</pre>
</li>
<li><p class="first">Inline markup start-strings must be immediately followed by
non-whitespace.</p>
</li>
<li><p class="first">Inline markup end-strings must be immediately preceded by
non-whitespace.</p>
</li>
<li><p class="first">Inline markup end-strings must end a text block or be immediately
followed by whitespace or one of:</p>
<pre class="literal-block">
' &quot; ) ] } &gt; - / : . , ; ! ? \
</pre>
</li>
<li><p class="first">If an inline markup start-string is immediately preceded by a
single or double quote, &quot;(&quot;, &quot;[&quot;, &quot;{&quot;, or &quot;&lt;&quot;, it must not be
immediately followed by the corresponding single or double quote,
&quot;)&quot;, &quot;]&quot;, &quot;}&quot;, or &quot;&gt;&quot;.</p>
</li>
<li><p class="first">An inline markup end-string must be separated by at least one
character from the start-string.</p>
</li>
<li><p class="first">An unescaped backslash preceding a start-string or end-string will
disable markup recognition, except for the end-string of <a class="reference" href="#inline-literals">inline
literals</a>.  See <a class="reference" href="#escaping-mechanism">Escaping Mechanism</a> above for details.</p>
</li>
</ol>
<p>For example, none of the following are recognized as containing inline
markup start-strings:</p>
<ul class="simple">
<li>asterisks: * &quot;*&quot; '*' (*) (* [*] {*} 1*x BOM32_*</li>
<li>double asterisks: **  a**b O(N**2) etc.</li>
<li>backquotes: ` `` etc.</li>
<li>underscores: _ __ __init__ __init__() etc.</li>
<li>vertical bars: | || etc.</li>
</ul>
<p>It may be desirable to use inline literals for some of these anyhow,
especially if they represent code snippets.  It's a judgment call.</p>
<p>These cases <em>do</em> require either literal-quoting or escaping to avoid
misinterpretation:</p>
<pre class="literal-block">
*4, class_, *args, **kwargs, `TeX-quoted', *ML, *.txt
</pre>
<p>The inline markup recognition rules were devised intentionally to
allow 90% of non-markup uses of &quot;*&quot;, &quot;`&quot;, &quot;_&quot;, and &quot;|&quot; <em>without</em>
resorting to backslashes.  For 9 of the remaining 10%, use inline
literals or literal blocks:</p>
<pre class="literal-block">
&quot;``\*``&quot; -&gt; &quot;\*&quot; (possibly in another font or quoted)
</pre>
<p>Only those who understand the escaping and inline markup rules should
attempt the remaining 1%.  ;-)</p>
<p>Inline markup delimiter characters are used for multiple constructs,
so to avoid ambiguity there must be a specific recognition order for
each character.  The inline markup recognition order is as follows:</p>
<ul class="simple">
<li>Asterisks: <a class="reference" href="#strong-emphasis">Strong emphasis</a> (&quot;**&quot;) is recognized before <a class="reference" href="#emphasis">emphasis</a>
(&quot;*&quot;).</li>
<li>Backquotes: <a class="reference" href="#inline-literals">Inline literals</a> (&quot;``&quot;), <a class="reference" href="#inline-internal-targets">inline internal targets</a>
(leading &quot;_`&quot;, trailing &quot;`&quot;), are mutually independent, and are
recognized before phrase <a class="reference" href="#hyperlink-references">hyperlink references</a> (leading &quot;`&quot;,
trailing &quot;`_&quot;) and <a class="reference" href="#interpreted-text">interpreted text</a> (&quot;`&quot;).</li>
<li>Trailing underscores: Footnote references (&quot;[&quot; + label + &quot;]_&quot;) and
simple <a class="reference" href="#hyperlink-references">hyperlink references</a> (name + trailing &quot;_&quot;) are mutually
independent.</li>
<li>Vertical bars: <a class="reference" href="#substitution-references">Substitution references</a> (&quot;|&quot;) are independently
recognized.</li>
<li><a class="reference" href="#standalone-hyperlinks">Standalone hyperlinks</a> are the last to be recognized.</li>
</ul>
<div class="section" id="character-level-inline-markup">
<h3><a class="toc-backref" href="#id58" name="character-level-inline-markup">Character-Level Inline Markup</a></h3>
<p>It is possible to mark up individual characters within a word with
backslash escapes (see <a class="reference" href="#escaping-mechanism">Escaping Mechanism</a> above).  Backslash
escapes can be used to allow arbitrary text to immediately follow
inline markup:</p>
<pre class="literal-block">
Python ``list``\s use square bracket syntax.
</pre>
<p>The backslash will disappear from the processed document.  The word
&quot;list&quot; will appear as inline literal text, and the letter &quot;s&quot; will
immediately follow it as normal text, with no space in-between.</p>
<p>Arbitrary text may immediately precede inline markup using
backslash-escaped whitespace:</p>
<pre class="literal-block">
Possible in *re*\ ``Structured``\ *Text*, though not encouraged.
</pre>
<p>The backslashes and spaces separating &quot;re&quot;, &quot;Structured&quot;, and &quot;Text&quot;
above will disappear from the processed document.</p>
<div class="caution">
<p class="admonition-title">Caution!</p>
The use of backslash-escapes for character-level inline markup is
not encouraged.  Such use is ugly and detrimental to the
unprocessed document's readability.  Please use this feature
sparingly and only where absolutely necessary.</div>
</div>
<div class="section" id="emphasis">
<h3><a class="toc-backref" href="#id59" name="emphasis">Emphasis</a></h3>
<p>Doctree element: emphasis.</p>
<p>Start-string = end-string = &quot;*&quot;.</p>
<p>Text enclosed by single asterisk characters is emphasized:</p>
<pre class="literal-block">
This is *emphasized text*.
</pre>
<p>Emphasized text is typically displayed in italics.</p>
</div>
<div class="section" id="strong-emphasis">
<h3><a class="toc-backref" href="#id60" name="strong-emphasis">Strong Emphasis</a></h3>
<p>Doctree element: strong.</p>
<p>Start-string = end-string = &quot;**&quot;.</p>
<p>Text enclosed by double-asterisks is emphasized strongly:</p>
<pre class="literal-block">
This is **strong text**.
</pre>
<p>Strongly emphasized text is typically displayed in boldface.</p>
</div>
<div class="section" id="interpreted-text">
<h3><a class="toc-backref" href="#id61" name="interpreted-text">Interpreted Text</a></h3>
<p>Doctree element: depends on the explicit or implicit role and
processing.</p>
<p>Start-string = end-string = &quot;`&quot;.</p>
<p>Interpreted text is text that is meant to be related, indexed, linked,
summarized, or otherwise processed, but the text itself is typically
left alone.  Interpreted text is enclosed by single backquote
characters:</p>
<pre class="literal-block">
This is `interpreted text`.
</pre>
<p>The &quot;role&quot; of the interpreted text determines how the text is
interpreted.  The role may be inferred implicitly (as above; the
&quot;default role&quot; is used) or indicated explicitly, using a role marker.
A role marker consists of a colon, the role name, and another colon.
A role name is a single word consisting of alphanumerics plus internal
hyphens, underscores, and periods; no whitespace or other characters
are allowed.  A role marker is either a prefix or a suffix to the
interpreted text, whichever reads better; it's up to the author:</p>
<pre class="literal-block">
:role:`interpreted text`

`interpreted text`:role:
</pre>
<p>Interpreted text allows extensions to the available inline descriptive
markup constructs.  To <a class="reference" href="#emphasis">emphasis</a>, <a class="reference" href="#strong-emphasis">strong emphasis</a>, <a class="reference" href="#inline-literals">inline
literals</a>, and <a class="reference" href="#hyperlink-references">hyperlink references</a>, we can add &quot;title reference&quot;,
&quot;index entry&quot;, &quot;acronym&quot;, &quot;class&quot;, &quot;red&quot;, &quot;blinking&quot; or anything else
we want.  Only pre-determined roles are recognized; unknown roles will
generate errors.  A core set of standard roles is implemented in the
reference parser; see <a class="reference" href="interpreted.html">reStructuredText Interpreted Text Roles</a> for
individual descriptions.  In addition, applications may support
specialized roles.</p>
</div>
<div class="section" id="inline-literals">
<h3><a class="toc-backref" href="#id62" name="inline-literals">Inline Literals</a></h3>
<p>Doctree element: literal.</p>
<p>Start-string = end-string = &quot;``&quot;.</p>
<p>Text enclosed by double-backquotes is treated as inline literals:</p>
<pre class="literal-block">
This text is an example of ``inline literals``.
</pre>
<p>Inline literals may contain any characters except two adjacent
backquotes in an end-string context (according to the recognition
rules above).  No markup interpretation (including backslash-escape
interpretation) is done within inline literals.</p>
<p>Line breaks are <em>not</em> preserved in inline literals.  Although a
reStructuredText parser will preserve runs of spaces in its output,
the final representation of the processed document is dependent on the
output formatter, thus the preservation of whitespace cannot be
guaranteed.  If the preservation of line breaks and/or other
whitespace is important, <a class="reference" href="#literal-blocks">literal blocks</a> should be used.</p>
<p>Inline literals are useful for short code snippets.  For example:</p>
<pre class="literal-block">
The regular expression ``[+-]?(\d+(\.\d*)?|\.\d+)`` matches
floating-point numbers (without exponents).
</pre>
</div>
<div class="section" id="hyperlink-references">
<h3><a class="toc-backref" href="#id63" name="hyperlink-references">Hyperlink References</a></h3>
<p>Doctree element: reference.</p>
<ul class="simple">
<li>Named hyperlink references:<ul>
<li>Start-string = &quot;&quot; (empty string), end-string = &quot;_&quot;.</li>
<li>Start-string = &quot;`&quot;, end-string = &quot;`_&quot;.  (Phrase references.)</li>
</ul>
</li>
<li>Anonymous hyperlink references:<ul>
<li>Start-string = &quot;&quot; (empty string), end-string = &quot;__&quot;.</li>
<li>Start-string = &quot;`&quot;, end-string = &quot;`__&quot;.  (Phrase references.)</li>
</ul>
</li>
</ul>
<p>Hyperlink references are indicated by a trailing underscore, &quot;_&quot;,
except for <a class="reference" href="#standalone-hyperlinks">standalone hyperlinks</a> which are recognized
independently.  The underscore can be thought of as a right-pointing
arrow.  The trailing underscores point away from hyperlink references,
and the leading underscores point toward <a class="reference" href="#hyperlink-targets">hyperlink targets</a>.</p>
<p>Hyperlinks consist of two parts.  In the text body, there is a source
link, a reference name with a trailing underscore (or two underscores
for <a class="reference" href="#anonymous-hyperlinks">anonymous hyperlinks</a>):</p>
<pre class="literal-block">
See the Python_ home page for info.
</pre>
<p>A target link with a matching reference name must exist somewhere else
in the document.  See <a class="reference" href="#hyperlink-targets">Hyperlink Targets</a> for a full description).</p>
<p><a class="reference" href="#anonymous-hyperlinks">Anonymous hyperlinks</a> (which see) do not use reference names to
match references to targets, but otherwise behave similarly to named
hyperlinks.</p>
<div class="section" id="embedded-uris">
<h4><a class="toc-backref" href="#id64" name="embedded-uris">Embedded URIs</a></h4>
<p>A hyperlink reference may directly embed a target URI inline, within
angle brackets (&quot;&lt;...&gt;&quot;) as follows:</p>
<pre class="literal-block">
See the `Python home page &lt;http://www.python.org&gt;`_ for info.
</pre>
<p>This is exactly equivalent to:</p>
<pre class="literal-block">
See the `Python home page`_ for info.

.. _Python home page: http://www.python.org
</pre>
<p>The bracketed URI must be preceded by whitespace and be the last text
before the end string.  With a single trailing underscore, the
reference is named and the same target URI may be referred to again.</p>
<p>With two trailing underscores, the reference and target are both
anonymous, and the target cannot be referred to again.  These are
&quot;one-off&quot; hyperlinks.  For example:</p>
<pre class="literal-block">
`RFC 2396 &lt;http://www.rfc-editor.org/rfc/rfc2396.txt&gt;`__ and `RFC
2732 &lt;http://www.rfc-editor.org/rfc/rfc2732.txt&gt;`__ together
define the syntax of URIs.
</pre>
<p>Equivalent to:</p>
<pre class="literal-block">
`RFC 2396`__ and `RFC 2732`__ together define the syntax of URIs.

__ http://www.rfc-editor.org/rfc/rfc2396.txt
__ http://www.rfc-editor.org/rfc/rfc2732.txt
</pre>
<p>If reference text happens to end with angle-bracketed text that is
<em>not</em> a URI, the open-angle-bracket needs to be backslash-escaped.
For example, here is a reference to a title describing a tag:</p>
<pre class="literal-block">
See `HTML Element: \&lt;a&gt;`_ below.
</pre>
<p>The reference text may also be omitted, in which case the URI will be
duplicated for use as the reference text.  This is useful for relative
URIs where the address or file name is also the desired reference
text:</p>
<pre class="literal-block">
See `&lt;a_named_relative_link&gt;`_ or `&lt;an_anonymous_relative_link&gt;`__
for details.
</pre>
<div class="caution">
<p class="admonition-title">Caution!</p>
This construct offers easy authoring and maintenance of hyperlinks
at the expense of general readability.  Inline URIs, especially
long ones, inevitably interrupt the natural flow of text.  For
documents meant to be read in source form, the use of independent
block-level <a class="reference" href="#hyperlink-targets">hyperlink targets</a> is <strong>strongly recommended</strong>.  The
embedded URI construct is most suited to documents intended <em>only</em>
to be read in processed form.</div>
</div>
</div>
<div class="section" id="inline-internal-targets">
<h3><a class="toc-backref" href="#id65" name="inline-internal-targets">Inline Internal Targets</a></h3>
<p>Doctree element: target.</p>
<p>Start-string = &quot;_`&quot;, end-string = &quot;`&quot;.</p>
<p>Inline internal targets are the equivalent of explicit <a class="reference" href="#internal-hyperlink-targets">internal
hyperlink targets</a>, but may appear within running text.  The syntax
begins with an underscore and a backquote, is followed by a hyperlink
name or phrase, and ends with a backquote.  Inline internal targets
may not be anonymous.</p>
<p>For example, the following paragraph contains a hyperlink target named
&quot;Norwegian Blue&quot;:</p>
<pre class="literal-block">
Oh yes, the _`Norwegian Blue`.  What's, um, what's wrong with it?
</pre>
<p>See <a class="reference" href="#implicit-hyperlink-targets">Implicit Hyperlink Targets</a> for the resolution of duplicate
reference names.</p>
</div>
<div class="section" id="footnote-references">
<h3><a class="toc-backref" href="#id66" name="footnote-references">Footnote References</a></h3>
<p>Doctree element: footnote_reference.</p>
<p>Start-string = &quot;[&quot;, end-string = &quot;]_&quot;.</p>
<p>Each footnote reference consists of a square-bracketed label followed
by a trailing underscore.  Footnote labels are one of:</p>
<ul class="simple">
<li>one or more digits (i.e., a number),</li>
<li>a single &quot;#&quot; (denoting <a class="reference" href="#auto-numbered-footnotes">auto-numbered footnotes</a>),</li>
<li>a &quot;#&quot; followed by a simple reference name (an <a class="reference" href="#autonumber-labels">autonumber label</a>),
or</li>
<li>a single &quot;*&quot; (denoting <a class="reference" href="#auto-symbol-footnotes">auto-symbol footnotes</a>).</li>
</ul>
<p>For example:</p>
<pre class="literal-block">
Please RTFM [1]_.

.. [1] Read The Fine Manual
</pre>
</div>
<div class="section" id="citation-references">
<h3><a class="toc-backref" href="#id67" name="citation-references">Citation References</a></h3>
<p>Doctree element: citation_reference.</p>
<p>Start-string = &quot;[&quot;, end-string = &quot;]_&quot;.</p>
<p>Each citation reference consists of a square-bracketed label followed
by a trailing underscore.  Citation labels are simple <a class="reference" href="#reference-names">reference
names</a> (case-insensitive single words, consisting of alphanumerics
plus internal hyphens, underscores, and periods; no whitespace).</p>
<p>For example:</p>
<pre class="literal-block">
Here is a citation reference: [CIT2002]_.
</pre>
<p>See <a class="reference" href="#citations">Citations</a> for the citation itself.</p>
</div>
<div class="section" id="substitution-references">
<h3><a class="toc-backref" href="#id68" name="substitution-references">Substitution References</a></h3>
<p>Doctree element: substitution_reference, reference.</p>
<p>Start-string = &quot;|&quot;, end-string = &quot;|&quot; (optionally followed by &quot;_&quot; or
&quot;__&quot;).</p>
<p>Vertical bars are used to bracket the substitution reference text.  A
substitution reference may also be a hyperlink reference by appending
a &quot;_&quot; (named) or &quot;__&quot; (anonymous) suffix; the substitution text is
used for the reference text in the named case.</p>
<p>The processing system replaces substitution references with the
processed contents of the corresponding <a class="reference" href="#substitution-definitions">substitution definitions</a>
(which see for the definition of &quot;correspond&quot;).  Substitution
definitions produce inline-compatible elements.</p>
<p>Examples:</p>
<pre class="literal-block">
This is a simple |substitution reference|.  It will be replaced by
the processing system.

This is a combination |substitution and hyperlink reference|_.  In
addition to being replaced, the replacement text or element will
refer to the &quot;substitution and hyperlink reference&quot; target.
</pre>
</div>
<div class="section" id="standalone-hyperlinks">
<h3><a class="toc-backref" href="#id69" name="standalone-hyperlinks">Standalone Hyperlinks</a></h3>
<p>Doctree element: reference.</p>
<p>Start-string = end-string = &quot;&quot; (empty string).</p>
<p>A URI (absolute URI <a class="footnote-reference" href="#uri" id="id16" name="id16"><sup>8</sup></a> or standalone email address) within a text
block is treated as a general external hyperlink with the URI itself
as the link's text.  For example:</p>
<pre class="literal-block">
See http://www.python.org for info.
</pre>
<p>would be marked up in HTML as:</p>
<pre class="literal-block">
See &lt;a href=&quot;http://www.python.org&quot;&gt;http://www.python.org&lt;/a&gt; for
info.
</pre>
<p>Two forms of URI are recognized:</p>
<ol class="arabic">
<li><p class="first">Absolute URIs.  These consist of a scheme, a colon (&quot;:&quot;), and a
scheme-specific part whose interpretation depends on the scheme.</p>
<p>The scheme is the name of the protocol, such as &quot;http&quot;, &quot;ftp&quot;,
&quot;mailto&quot;, or &quot;telnet&quot;.  The scheme consists of an initial letter,
followed by letters, numbers, and/or &quot;+&quot;, &quot;-&quot;, &quot;.&quot;.  Recognition is
limited to known schemes, per the <a class="reference" href="http://www.iana.org/assignments/uri-schemes">Official IANA Registry of URI
Schemes</a> and the W3C's <a class="reference" href="http://www.w3.org/Addressing/schemes.html">Retired Index of WWW Addressing Schemes</a>.</p>
<p>The scheme-specific part of the resource identifier may be either
hierarchical or opaque:</p>
<ul>
<li><p class="first">Hierarchical identifiers begin with one or two slashes and may
use slashes to separate hierarchical components of the path.
Examples are web pages and FTP sites:</p>
<pre class="literal-block">
http://www.python.org

ftp://ftp.python.org/pub/python
</pre>
</li>
<li><p class="first">Opaque identifiers do not begin with slashes.  Examples are
email addresses and newsgroups:</p>
<pre class="literal-block">
mailto:someone&#64;somewhere.com

news:comp.lang.python
</pre>
</li>
</ul>
<p>With queries, fragments, and %-escape sequences, URIs can become
quite complicated.  A reStructuredText parser must be able to
recognize any absolute URI, as defined in <a class="reference" href="http://www.rfc-editor.org/rfc/rfc2396.txt">RFC2396</a> and <a class="reference" href="http://www.rfc-editor.org/rfc/rfc2732.txt">RFC2732</a>.</p>
</li>
<li><p class="first">Standalone email addresses, which are treated as if they were
absolute URIs with a &quot;mailto:&quot; scheme.  Example:</p>
<pre class="literal-block">
someone&#64;somewhere.com
</pre>
</li>
</ol>
<p>Punctuation at the end of a URI is not considered part of the URI.
Backslashes may be used in URIs to escape markup characters,
specifically asterisks (&quot;*&quot;) and underscores (&quot;_&quot;) which are vaid URI
characters (see <a class="reference" href="#escaping-mechanism">Escaping Mechanism</a> above).</p>
<table class="footnote" frame="void" id="uri" rules="none">
<colgroup><col class="label" /><col /></colgroup>
<tbody valign="top">
<tr><td class="label"><a class="fn-backref" href="#id16" name="uri">[8]</a></td><td>Uniform Resource Identifier.  URIs are a general form of
URLs (Uniform Resource Locators).  For the syntax of URIs see
<a class="reference" href="http://www.rfc-editor.org/rfc/rfc2396.txt">RFC2396</a> and <a class="reference" href="http://www.rfc-editor.org/rfc/rfc2732.txt">RFC2732</a>.</td></tr>
</tbody>
</table>
</div>
</div>
</div>
<div class="section" id="error-handling">
<h1><a class="toc-backref" href="#id70" name="error-handling">Error Handling</a></h1>
<p>Doctree element: system_message, problematic.</p>
<p>Markup errors are handled according to the specification in <a class="reference" href="http://docutils.sourceforge.net/spec/pep-0258.txt">PEP
258</a>.</p>
<!-- Local Variables:
mode: indented-text
indent-tabs-mode: nil
sentence-end-double-space: t
fill-column: 70
End: -->
</div>
</div>
<hr class="footer" />
<div class="footer">
<a class="reference" href="reStructuredText.txt">View document source</a>.
Generated on: 2003-12-30 04:52 UTC.
Generated by <a class="reference" href="http://docutils.sourceforge.net/">Docutils</a> from <a class="reference" href="http://docutils.sourceforge.net/rst.html">reStructuredText</a> source.
</div>
</body>
</html>
