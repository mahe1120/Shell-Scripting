#!/bin/bash

NUMBER=$1

if[ $NUMBER -gt 10 ]
then
    echo "Given number is greater than $NUMBER"
else
    echo "Given number is less than $NUMBER"
fi
