#!/usr/bin/env bash

function rand(){
    min=$1
    max=$(($2-$min+1))
    num=$(date +%s%N)
    echo $(($num%$max+$min))
}

r=$(rand 1 255)
g=$(rand 1 255)
b=$(rand 1 255)

echo "<span style=\"color: rgb(${r},${g},${b});\">I'm running inside of nginx POD</span>" > /usr/share/nginx/html/index.html

nginx -g "daemon off;"