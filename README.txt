pass-stdout

pass-stdout is an extention to pass (https://passwordstore.org)

it works kinda like the `show` command

except it does nothing but printing to stdout
focusing on keeping stdout clean of anything else

without any optional parameters it just prints the first line
of the passfile the pass path of which you will choose

there is a `-k` option
if you use it like `-k username`
it will select the line out of not all lines
but out of only the lines starting with `username:`

there is a `-n` option
if you use it like `-n 2`
if will select the second line in file
instead of first line as it does by default
