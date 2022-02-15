#!/bin/bash

for i in img/*.png
do
  echo "!["$i"]""("$i")" >> body.txt
done


cat header.txt body.txt footer.txt > index.html
