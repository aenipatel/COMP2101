#!/bin/bash
#
# this script demonstrates doing arithmetic

# Task 1: Remove the assignments of numbers to the first and second number variables. Use one or more read commands to get 3 numbers from the user.
# Task 2: Change the output to only show:
#    the sum of the 3 numbers with a label
#    the product of the 3 numbers with a label
echo "Please enter three value"
read -r num1 num2 num3


sum=$((num1 + num2 + num3))
product=$((num1 * num2 * num3))


cat <<EOF
$num1 plus $num2 plus $num3 is $sum
Product of $num1, $num2 and $num3 is $product
EOF
