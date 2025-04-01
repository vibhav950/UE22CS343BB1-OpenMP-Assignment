#!/bin/bash

# Test outputs for test_4; This program will run ./cache_simulator test_4
# until all the diffs for core_*_output.txt match for run_1/run_2/run_3/run_4

while true; do
    ./cache_simulator test_4 &
    proc_pid=$!
    sleep 0.5

    kill -9 $proc_pid 2>/dev/null
    pkill -P $proc_pid 2>/dev/null

    for i in {1..4}; do
      diff core_0_output.txt tests/test_4/run_$i/core_0_output.txt > /dev/null
      diff0=$?

      diff core_1_output.txt tests/test_4/run_$i/core_1_output.txt > /dev/null
      diff1=$?

      diff core_2_output.txt tests/test_4/run_$i/core_2_output.txt > /dev/null
      diff2=$?

      diff core_3_output.txt tests/test_4/run_$i/core_3_output.txt > /dev/null
      diff3=$?

      if [[ $diff0 -eq 0 && $diff1 -eq 0 && $diff2 -eq 0 && $diff3 -eq 0 ]]; then
          echo "All outputs match with run_$i"
          exit 0
      fi
    done
done
