---
title: "Bjarne Stroustrup Talk at UMich Notes"
date: "2011-11-10"
---

```
Bjarne Stroustrop
2011年 11月 09日 星期三 17:18:36 EST
-------------------------------------------------------------------------------

Multi-paradigm is not good enough
Light-weight abstraction
    - software infrastructure
    - resource constrained

No one size fits all
    - 1st to market
    - If program fails, people die
    - 50% overhead implies the need for another $50M server farm

What we want
-------------------------------------------------------------------------------
Easy to understand

- Modularity
- No resource leaks
- Thread safe
- Efficient
- Portable

Ghastly style

ugly -> cin>>val

Bad style is the #1 problem in real-world C++ code
    - bad code *BREEDS* more bad code
    - Many are self-taught
        - advice from decades old books/novices

Mars lander
-------------------------------------------------------------------------------

Using *UNITS*

Speed sp1 = 100m / 9.8s // very fast for a human
...
Acell acc
...

Using operator ""s, operator ""m, operator ""kg -- Elegant!

Keep interfaces strongly typed
    - avoid very general types
        - int, double, ...
        - Object....

Checking of trivial types finds trivial errors

void f(const char* p) {
    f = fopen(p, "r");
        ....
    fclose(f);
}

(*The number of bugs you have in your problem is proportional to the amount and
complexity of the code you have got.*)

RAII - resource acquisition is initialization

~File_handle() { fclose(p) } // destructor

RAII lowers the time you use resources compared to other strategy
    - manually
    - finalizer
    - garbage collection, etc...

Not all resources are scoped

Most uses of scoped resource allocation is no exception-proof

std::shared_ptr releases its object at when the last shared_ptr is destroyed
std::unique-ptr is the same

Gadget g {n}; // No naked 'new' s!

-------------------------------------------------------------------------------
Range-checks on containers, no more overflows

Resource handles and pointers "smart pointers" address most memory leak
problems
-------------------------------------------------------------------------------
Use data types that integrate this into their behavior:
    std::vector, std::ostreamm, std::thread, ...

Moving large objects out of a function

Move the Matrix out
    "steal the representation"

Use the Move Constructor in X11
    class Matrix {
        //
        ..
    }

New X11
Not array -- because array is a chunk of memory

- no naked pointers
- no naked new or delete
    - keep arrays out of interfaces (prefer containers)
    - pointers are implementation-level details
    - use unique_ptr and shared_pointer
- return objects "by-value" (using move rather than copy)


Vector vs List
To answer this---
Know:
    - complexity theory
    - data structs.
    - machine architecture
     - *ran out of memory before list's advantage could show itself*
- Amount of memory used differ dramatically
- Memory access is relatively slow
- Implications

We *NEVER* hit the asymptote!

* Compactness
* Generic Code

Algorithms vs."Code"

Need to get to a more algorithmic version of code
-> gather example

A.K.A. C++ is becoming more like python

Low-level != efficient
-------------------------------------------------------------------------------

Don't lower your level of abstraction without good reason
Low-level implies
    more code
    more bugs
    harder to understand and maintain

Inheritance
    - When the domain concepts are hierarchical
    - When there is a need for run-time selection among hierarchically ordered
      alternatives

Type-Safe Concurrency

auto --> gets type of initializer

async() - pass arguments and return result
auto res1 = async(f, some_fec);
cout << res1.get();
get return value when you want it

-------------------------------------------------------------------------------
tldr;
C++ Style
Practice type-rich programming
    - focus on interfaces
    - simple classes are cheap - use lots
    - avoid over-general interfaces
Use compact data structures
    - by default, use std;:vector
Have a general strategy for error handling
    - By default, us exceptions and RAII
Prefer algorithms to "random code"
Rely on type-safe concurrency
Build and use libraries
    - By default, start with the ISO C++ standard library

Q&A
- What languages do you feel have features you would like to see in C++?
- Threads & Concurrency now in ISO std C++
    - shipped in MS/GNU/CLANG compilers

"Not a science fiction tour -- all shipped"
```
