<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#orgheadline3">1. Forks</a>
<ul>
<li><a href="#orgheadline2">1.1. Examples</a>
<ul>
<li><a href="#orgheadline1">1.1.1. Average</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#orgheadline7">2. Hooks</a>
<ul>
<li><a href="#orgheadline6">2.1. Examples</a>
<ul>
<li><a href="#orgheadline4">2.1.1. Integer?</a></li>
<li><a href="#orgheadline5">2.1.2. Line</a></li>
</ul>
</li>
</ul>
</li>
</ul>
</div>
</div>

This module provides two ways of defining new functions from others: *hooks* and *forks*,
taken from the J Programming language. Both define new functions from others by chaining
them together without arguments, and can allow for succinct and clear definitions with
little conceptual overhead. Before we begin, let's define two terms: Dyad/dyadic and
monad/monadic. A dyadic function, called a dyad, is a function which takes two arguments.
A monadic function, sometimes called a monad, is a function which only takes one.
In addition to these functions and their variants, we also provide several definition
forms for ease of use: `define/fork`, `define/hook1`, `define/hook2`, `define/hook`.

# Forks<a id="orgheadline3"></a>

Forks are useful for higher-order descriptions of functions which are best understood and
described "as themselves", without `(lambda (x) (... x ...)` or other conceptual overhead.
I.e., the average of a group of numbers is best described as its sum divided by its amount
or length.

A fork is a train of 3 functions, where `f` and `h` are monadic and `g` is
dyadic, such that for any argument `y`:

-   **Infix:** `(f g h) y` ⇒ `(f y) g (h y)`
-   **Prefix:** `((f g h) y)` ⇒ `(g (f y) (h y))`

i.e, `y` is *forked* between `f` and `h`, then combined with `g`. It takes one function
and an arbitrary number of other functions. Then applies the list of arbitrary functions
to a singular argument, and combines result with the head function. 

## Examples<a id="orgheadline2"></a>

### Average<a id="orgheadline1"></a>

The average of any given numbers (here, in a list) is the sum of those numbers divided by
the amount of numbers.
`(define/fork average (/ sum length))`.
While we could easily define forks to use a standard infix notation such that
`(define/fork average (sum / length))` is valid, prefix will be more familiar and
consistent with Racket lisp programming.

# Hooks<a id="orgheadline7"></a>

Hooks are useful for describing functions like lines in a natural manner similar to how we
write them in mathematics.

A monadic hook is a train of functions where `f` is dyadic and `g` is monadic, such that for an
argument `y`:

-   **Infix:** `(f g) y` ⇒ `y f (g y)`
-   **Prefix:** `((f g) y)` ⇒ `(f y (g y))`

This takes an argument and applies function `f` to argument `y` and the result of applying
`g` to `y`.
A dyadic hook is a train of functions where `f` is dyadic and `g` is monadic, such that
for any argument `y` and `z`:

-   **Infix:** `y (f g) z` ⇒ `y f (g z)`
-   **Prefix:** `((f g) y z)` ⇒ `(f y (g z))`

A dyadic hook may currently accept any number of arguments by applying `g` to all of them,
then passing the original arguments and the transformed arguments to `f`. via
`define/hook`.<sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup>

## Examples<a id="orgheadline6"></a>

### Integer?<a id="orgheadline4"></a>

A function called `integer?` takes one argument and returns true or false depending on
whether the number given is an integer. A number is an integer if it is equal to calling
`floor` on it. `Floor` is a function which gives the highest integer less than or equal to
its argument.
`Number → Boolean`
`(define/hook integer? (= floor))`
`(integer? 3.5)` ⇒ `#f`
`(integer? 3)` ⇒ `#t`

### Line<a id="orgheadline5"></a>

A line is a function which takes *two* arguments representing x and y values on a plane,
and determines whether they are in some given relation (=, ≠, ≤, &ge;, <, >) to a y-value. We
define one such line: `y = x + 3` Where a point (x, y) is on the line if and only if it's
y-value is equal to its x-value plus three.
`(define/hook2 line (= (λ (x) (+ x 3)))`
`(line? 3 4)` &rArr; `#f`
`(line? 7 4)` ⇒ `#t`

<div id="footnotes">
<h2 class="footnotes">Footnotes: </h2>
<div id="text-footnotes">

<div class="footdef"><sup><a id="fn.1" class="footnum" href="#fnr.1">1</a></sup> <div class="footpara">Still trying to figure out how to create a variadic hook such that `((hook f g
h i ...) a b c d ...)` ⇒ `(f a (g b (h c (i d))))` which might be better than the current
model, or not.</div></div>


</div>
</div>
