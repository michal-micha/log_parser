---
title: 1. Script Structure
status: Pending
date: 2020-08-30
---

## Context and Problem Statement

Implemented "log_parser" Ruby script is supposed to load file containing logs, count number of total and unique views, sort them (per page) and print both lists.
We need to choose the best structure of "log_parser" script and define possible layers of abstractions needed.

## Considered Options

* Keep whole logic inside "log_parser" script and use private methods for specific actions
* Extract main responsibilities of "log_parser" script to Validator, Extractor, PrintFormatter

## Decision Outcome

Extract main responsibilities of "log_parser" script to Validator, Extractor, PrintFormatter

## Pros and Cons of the Options

### Keep whole logic inside "log_parser" script and use private methods for specific actions

* Good, because logic needed to implement that task is not very complex (at least its first planned iteration), so we might be able
 to hold whole logic in single file and for it to still be understandable
* Good, because application's source code would be more limited and its structure easier to understand and test (running single spec would be required)
* Bad, because script won't have Single Responsibility 
* Bad, because in case we'd like to introduce more and more features at some point the class will have been to large and it'd require logic extraction
* Bad, because we wouldn't be able to test dependencies in isolation (eg. validation of the file without its effect on extraction step) 

### Extract main responsibilities of "log_parser" script to Validator, Extractor, PrintFormatter

* Good, because we can use Dependency Injection and test services in isolation
* Good, because services with logic would comply (or to some extent comply) to Single Responsibility Principle - and not hold unnecessary logic
* Good, because we'd started dividing application structure, so it'd make it much more easy in case we'd like to extend its features 
* Good, if we were to use Zeitwerk for autoloading, after creating of directories we'd already have part of our work done
* Bad, because it requires more work
* Bad, because each service needs to be tested separately and some repetition is introduced
