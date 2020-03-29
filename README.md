# Programming Languages

by **University of Washington**

[This course](https://www.coursera.org/learn/programming-languages) is an introduction to the basic concepts of programming languages, with a strong emphasis on **functional programming**. The course uses the languages ML, Racket, and Ruby as vehicles for teaching the concepts, but the real intent is to teach enough about how any language “fits together” to make you more effective programming in any language -- and in learning new ones.

This course is neither particularly theoretical nor just about programming specifics -- it will give you a framework for understanding how to use language constructs effectively and how to design correct and elegant programs. By using different languages, you will learn to think more deeply than in terms of the particular syntax of one language. The emphasis on functional programming is essential for learning how to write robust, reusable, composable, and elegant programs. Indeed, many of the most important ideas in modern languages have their roots in functional programming. Get ready to learn a fresh and beautiful way to look at software and how to have fun building it.

The course assumes some prior experience with programming, as described in more detail in the first module.

The course is divided into three Coursera courses: [Part A](https://www.coursera.org/learn/programming-languages), [Part B](https://www.coursera.org/learn/programming-languages-part-b), and [Part C](https://www.coursera.org/learn/programming-languages-part-c).  As explained in more detail in the first module of Part A, the overall course is a substantial amount of challenging material, so the three-part format provides two intermediate milestones and opportunities for a pause before continuing.  The three parts are designed to be completed in order and set up to motivate you to continue through to the end of Part C.  The three parts are not quite equal in length: Part A is almost as substantial as Part B and Part C combined.

--------

### Certificates

| Part | online                                         	                      | Offline Copy   	                              |
|---	 |---	                                                                    |---	                                          |
|  A	 | https://www.coursera.org/share/a0459180241db9b6754f25ddec9c21ec | [⬇️here](./certs/Coursera\ K33GW5XAC4FU.pdf/)  |
|  B	 | https://www.coursera.org/share/e7cb80791124a0a6d466e0fa1750fc7d | [⬇️here](./certs/Coursera\ T4CR3Q6NVYHN.pdf/)  |
|  C 	 | https://www.coursera.org/share/c050d51d1cb6d122bfaec26c0a700218 | [⬇️here](./certs/Coursera\ KLQGCC5LTLTR.pef/)	|

--------

## Introduction

This repo contains all my work for this course. All the code base, quiz questions, screenshot, and images, are taken from, unless specified, [Programming Languages on Coursera](https://www.coursera.org/learn/programming-languages). The course is also avilable on [washington.edu](https://courses.cs.washington.edu/courses/cse341/16sp/).

## What I want to say

**VERBOSE CONTENT WARNING: YOU CAN JUMP TO THE NEXT SECTION IF YOU WANT**

Here I released these solutions, which are **only for your reference purpose**. It may help you to save some time. And I hope you don't copy any part of the code (the programming assignments are fairly easy if you read the instructions carefully), see the quiz solutions before you start your own adventure.

Currently, this repo has 3 major parts you may be interested in and I will give a list here.

## Homework Assignments and Exams

- Part A: ML and Functional Pragramming

  - [X] [Week 2 - Homework 1 - ML Functions, Tuples, Lists, and More](./PartA/section1/hw1/): 100.3/100
  - [X] [Week 3 -  Homework 2 - Datatypes, Pattern Matching, Tail Recursion, and More](./PartA/section2/hw2/): 99/100
  - [X] [Week 4 -  Homework 3 - First-Class Functions and Closures](./PartA/section3/hw3): 100/100
  - [X] Week 5 -  Part A - Exam

- Part B: Racket and Dynamically Typed Language

  - [X] [Week 1 - Homework 4 - Racket, Delaying Evaluation, Memoization, Macros](./PartB/section5/hw4): 97/100 
  > _something incorrect in (list-nth-mod) function;_ 
  [cute dog from the auto-grader](https://drive.google.com/file/d/0B5sUgbs6aDNpSWhSZzVtcktDaTA/view?pref=2&pli=1)
  - [X] [Week 2 - Homework 5 - Structs, Implementing Languages, Static vs. Dynamic Typing](./PartB/section6/hw5): 99/100 
  > *ifeq: resulting expression evaluates to e3 if e1 and e2 evaluate to equal integers ('(ifeq (int 5) (int 5) (int 0) (int 1)) should result in MUPL that evaluates to (int 0) but resulted in (mlet "_x" (int 5) (mlet "_y" (int 5) (int 1)))) [incorrect answer];*
  - [X] Week 3 - Section Quiz

- Part C: Ruby and Object-Oriented Language

  - [X] [Week 1 - Homework 6 - Ruby, Object-Oriented Programming, Subclassing](./PartC/section8/hw6) 100/100
  - [X] [Week 2 - Homework 7 - Program Decomposition, Mixins, Subtyping, and More](./PartC/section9/hw7) 99/100 [69/70 for Ruby && 30/30 for SML] 
  > Ruby output: *intersect_methods(Line#intersect): Line.new(5.0,0.0).intersect(LineSegment.new(1.0,5.0,2.0,2.0)) should equal Point.new(1.0,5.0) (actual: NoPoints.new) [incorrect answer]
  
  > Because the auto-grader gave a score above 60, here is the link to a message from a very cute dog: https://drive.google.com/file/d/0B5sUgbs6aDNpSXBkMVZmelJJX1U/view?pref=2&pli=1*
  - [X] Week 3 - Final Exam
