# This is Professor Henderson's solution, I ended up looking it up to properly finish the activity #

file=$1

## The second argument is an (extended) regular
##  expression for the column names we want.
expr=$2

## Here is where we do the work
if [ ! -f "$file" ]; then
  # This line echos to stderr rather than stdout 
  echo "Could not find file $file." > /dev/stderr
else
  # get column numbers whose names match expr
  cols=$(
   <"$file" head -n1 |
    tr , \\n |   
    grep -n -E "$expr" |
    cut -f1 -d: |
    paste -s -d, -
  )

  # cut those columns out
  <"$file" cut -f"$cols" -d,
fi