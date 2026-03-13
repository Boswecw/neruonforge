# Change Control

## Rule
Change only one variable at a time between test runs.

## Allowed variables
- prompt wording
- protected terms structure
- style preferences wording
- input passage choice

## Do not do
- do not change multiple files at once and then judge the result
- do not swap model and prompt in the same comparison run
- do not rewrite the whole workflow after one bad output

## Reason
Single-variable changes make results comparable and keep the experiment honest.

## Practice
For each new run, note exactly what changed and why.
