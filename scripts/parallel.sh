#!/bin/bash

trap killgroup SIGINT

killgroup(){
  kill 0
}

for command in "$@"
do
    eval $command &
done

wait
