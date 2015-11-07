-- Inspired by the following examples:
-- https://gist.github.com/tomgullo/186460
-- http://chimera.labs.oreilly.com/books/1234000001811/ch01.html

-- Load lines from the file name alice.txt & call the single
-- field in the record 'line'.
lines = load 'data/alice.txt' as (line);

-- tokenize splits the line into a field for each word.
-- flatten will take the collection of records returned by
-- tokenize and produce a separate record for each one,
-- calling the single field in the record word.
words = foreach lines generate flatten(TOKENIZE(line)) as word;

-- Skip blank lines.
full_words = filter words by word matches '\\w+';

-- Group them together by each word.
grouped = group full_words by word;

-- Count the words.
wordcount = foreach grouped generate COUNT(full_words), group;

-- Store the results.
store wordcount into 'data/alice_wordcount';
