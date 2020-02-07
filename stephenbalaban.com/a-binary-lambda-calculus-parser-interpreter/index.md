---
title: "A Binary Lambda Calculus Parser / Interpreter"
date: 2020-02-07
---

https://github.com/stephenbalaban/blc

# blc

## To install

```
git clone git@github.com:stephenbalaban/blc.git && cd blc/
sudo make install
blc
blc> 0010
0010
blc> 01000110100010
0010
```

Playing with the compiler.

```
$ echo '01000110100010' | blc - foo.blc && cat foo.blc
#!/usr/bin/env blc
01000110100010`
$ ./foo.blc
0010
```

Going to make a more human readable version without de bruijn indices.

```
echo '01000110100010' | blc - - --target-language lam
#!/usr/bin/env blc
(\x.(x x) \x.x)
```

Search for random lambda expressions:

```
while :;
do
	prog=random.blc;
	(until (echo $(head -c 256 /dev/urandom  | xxd -b | awk '{ print $2, $3}' | sed 's/ //g')  | sed 's/ //g' > $prog; blc $prog &> /dev/null); do :; done);
	start=$(date +%s); steps=$(blc $prog --verbose | wc -l); end=$(date +%s); duration=$((end-start));
	if (( $steps > 2 ));
	then
		cat $prog; echo "steps $steps duration $duration";
	fi;
done
0100011111101011011100000100011100000100001010110010011101010101110011110100110111111011100001100111101001011010111010011011001011110001100010011110011010000111000111000001011001111111101111100000010011100010010101110111001111000001101101101001001001011010010110111011100111101111010000010100101111110100001100010000111000001100011001001001000001110110011111010101111110111011111100010111110010100011111101010010011111111111010001111101010010110100101100101010000000010101101100111101000111001101110100010011101101011000011111000100001100110000001101011100110111010111000111000000010011111110011110111001010110100001010101101101101010011101111001100001110110100101001011000000111111101101
steps 3 duration 1
```

I've found some interesting expressions this way, like this one that loops forever:

```
((z y) \x.(\y.x ((y \y.\z.(\a.x z)) ((\y.a a) \y.\z.x))))
01011110110000100100101110000001001011100101001111011110000010
```

## Comments

## TODO

- implement actual binary BLC (instead of ASCII 0s and 1s)
- implement 8-bit packed BLC
- would be cool to have a dense representation of the AST with some sort of
  reducer that operated on that binary structure
- implement human readable version with stateful variables, church numerals
- implement some other non-church numeral encoding, maybe IEEE 754 fp or unum?
- re-implement in C

## Notes

Implementing the Binary Lambda Calculus in Python

Following John Tromp's Lambda Calculus paper: http://tromp.github.io/cl/LC.pdf

As well as getting some tips from his implementation: https://tromp.github.io/cl/Binary_lambda_calculus.html

## Understanding the paper

To implement, we must first read the actual paper. Here are some notes
/ summarization from my reading.

I've already read through https://www.amazon.com/Introduction-Functional-Programming-Calculus-Mathematics/dp/0486478831
multiple times so I am going to read through but not discuss further the
preliminaries.

## Defining the binary lambda calculus.

### Binary Strings

Definition 1: For a binary string s and lambda term M, (s : M) denotes the list
of booleans corresponding to s, terminated with M. Thus (s : nil) is the
standard representation of string s.

#### A nil terminated string

So the string (011 : nil) = <true, <false, <false, nil>>> which represents 011.


### de Bruijn index

Instead of using variables x y z etc., we can use indices (read from right to
left) to fill in the values.

the de Bruijn index refers to how many lambda abstractions lie between the bound
variable and the lambda that binds it. For example in this arbitrary expression:


\a \b \c ((c (b a)) \x (b b))

Reading right to left we can replace the variables with a natural number based
on how many lambda abstractions are in scope before we get to the original
binding lambda.

λ λ λ ((0 (1 2)) λ (2 2))

We can confirm this with:

echo $(cat parse.Blc <(echo "\a \b \c (c (b a)) \x (b b)") | ./tromp)
000000010110011101110000111101110

Translated from the blc to de Bruijn index:

λ  λ  λ  (  (  0  (  1   2    λ  (  2    2
00 00 00 01 01 10 01 110 1110 00 01 1110 1110

λ λ λ ((0 (1 2)) λ (2 2))

When in doubt, just 0-index count back to the binding lambda.

Some more de Bruijn index examples:

indices
```
Name		| Lambda			   | de Bruijn index             | BLC encoding
----------------+----------------------------------+-----------------------------+--------------------
Identity 	| λx.x				   | λ 0			 | 0010
Self		| λx.x x			   | λ 0 0			 | 001010
True		| λx.λy.x			   | λ λ 1			 | 0000110
False		| λx.λy.y			   | λ λ 0			 | 00001010
S combinator	| λx.λy.λz.x z (y z)		   | λ λ λ ((2 0) (1 0))	 | 00000001011110100111010
Y combinator	| λf.λx.((f (x x)) λx.(f (x x)))   | λ λ ((1 (0 0)) λ (2 (0 0))) | 0000010111001101000011110011010
Omega		| \x.((x x) \x.(x x))		   | λ ((0 0) λ (0 0))		 | 000101101000011010
```
### Encoding the de Bruijn indices into a binary string

We need a way to encode de Bruijn indices lambda expressions into binary
strings. 

Definition 2: The code for a term in de Buijn indices is defined
inductively as follows:

n = 1^(n+1)0
{λM} = 00{M}
{MN} = 01{M}{N}

```
Lambda Expression		| de Bruijn index	| Binary String Encoding
--------------------------------+-----------------------+--------------------------
λx.x				| λ 0			| 0010
λx.λy.x				| λ λ 1			| 0000110
λx.λy.y				| λ λ 0			| 000010
λx.x x				| λ 0 0			| 00011010
λx.λy.λz.x z (y z)		| λ λ λ 2 0 (1 0)	| 000000011110100111010 (maybe)
λx.λa.λb.b			| λ λ λ 0		| 00000010
```

So, to do some computation with this, let's say that we wanted to Beta-reduce
the following relatively simple lambda calculus expression:

λx.λy.y (λx.x) (λx.x x)

You can clearly see that the left hand expression is an expression for "second"
while the first argument is the identity function and the second argument is
the self function. So, it should Beta-reduce to self. In de Bruijn indices:

(((λ λ 1) (λ 0)) (λ (0 0)))

((λ 0) (λ (0 0)))

(λ (0 0))

You can see that as we beta-reduce the de bruijn index expression we are
unwrapping lambdas and decrementing the remaining indexes of that expression.
You can see that 1 becomes 0 and any zeroes are removed once they're
substituted for.


or, in the binary encoding:

010000100100100100011010

So, this program is represented in 18 bits. (Again, how that binary encoding actually breaks down)

aply λ  λ  1   aply λ  0  aply λ  aply 0  0
01   00 00 110 01   00 10 01   00 01   10 10

So here's me reducing using only the blc:

01   00 00 110 01   00 10 01   00 01   10 10

00 10 01   00 01   10 10

00 01 10 10

He then goes on to define a universal computer:

E = Y (λe c s.s (λa t.t (λb.a E0 E1)))

E0 = e (λx.b(c(λz y.x <y, z>))(e (λy.c(λz.x z (y z)))))

E1 = (b (c (λz.z b))(λs.e (λx.c(λz.x (z b))) t))


E = Y (λe c s.s (λa t.t (λb.a (e (λx.b(c(λz y.x <y, z>))(e (λy.c(λz.x z (y z)))))) (b (c (λz.z b))(λs.e (λx.c(λz.x (z b))) t)))))
  = λf.((λx.x x)(λx.f (x x))) (λe c s.s (λa t.t (λb.a (e (λx.b(c(λz y.x <y, z>))(e (λy.c(λz.x z (y z)))))) (b (c (λz.z b))(λs.e (λx.c(λz.x (z b))) t)))))
