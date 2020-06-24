#!/bin/sh -x
count=0
while true
do
  count=$(( 1 + ${count} ))
  sleep 100
  curl https://test-php.sebastian-colomar.com/ -I | grep 'HTTP/2 200'
  out="${?}"
  test ${out} -eq 0 && break
done
