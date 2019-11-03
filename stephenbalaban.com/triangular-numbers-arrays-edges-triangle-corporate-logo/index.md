---
title: "Fun with Triangular Numbers + Triangular Corporate Logos"
date: "2011-07-25"
---

I've always been fond of triangular numbers \[1\] and found the pattern they create beautiful.

                         .
                       .   .
                     .   .   .
                   .   .   .   .
                 .   .   .   .   .
               .   .   .   .   .   .
             .   .   .   .   .   .   .
           .   .   .   .   .   .   .   .
         .   .   .   .   .   .   .   .   .
       .   .   .   .   .   .   .   .   .   .
     .   .   .   .   .   .   .   .   .   .   .

Embedded within are many a corporate logo:

Mitsubishi, Chase, Star of David, &c. All of these logos can easily be re-created using isometric graph paper.

![Mitsubishi Triangle Logo](./images/mitsubishi-logo.png "Mitsubishi Logo")

![](./images/star-of-david.png "Star of David / Seal of Solomon")

![Chase Logo](./images/chase-logo.jpg "Chase Logo")

I wanted to find out the relationships between the dots and the possible lines drawn between them. For example. If you have T\_n, how many dots exist as a recurrence relation? How many lines can one draw between the dots for T\_n?

           o
          / \\  (T\_2 -> n\_2 = 3)
         o - o

number of dots: d\_i = d\_{i-1} + i number of lines: n\_i = n\_{i-1} + 3 \* (i - 1)

I wrote some of it up in CLISP to check it out: `;; calculates numer of edges in triangular graph (defun nlines (i) (let ((prev (- i 1))) (if (eq i 0) 0 (+ (* 3 prev) (nlines prev)))))`

;; returns number of nodes in graph (defun ndots (i) (if (eq i 0) 0 (+ (ndots (- i 1)) i)))

Now what if we looked at the triangular numbers with respect to a triangular array like Pascal's Triangle? \[2\] That is, how many operations need to take place in order to calculate the entire triangle? ; calcs number of operations for triangular arrays based on n ; nops = 6, i = 3 ; . ; / \\ ; . . (nops 3) == 6 ; / \\ / \\ ; . . . ; (defun nops (i) (if (eq i 0) 0 (let ((prev (- i 1))) (+ (nops prev) (\* 2 prev)))))

I brute-forced the limit by just putting large numbers in and found out that the ratio between the number of dots and lines approaches 1/3 as i approaches infinity and the number of dots to the number of operations (in a triangular array) approaches 1/2 as i approaches infinity.

\\lim\_{i\\to\\infty} \\frac{ndots\_I}{nlines\_i} = \\frac{1}{3}
\\lim\_{i\\to\\infty} \\frac{ndots\_I}{nops\_i} = \\frac{1}{2}

**Sources:**

http://en.wikipedia.org/wiki/Triangular\_number

http://en.wikipedia.org/wiki/Pascal's\_triangle
