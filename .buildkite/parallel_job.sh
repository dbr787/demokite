#!/bin/bash

echo "This is parallel job $((BUILDKITE_PARALLEL_JOB+1)) of $BUILDKITE_PARALLEL_JOB_COUNT"

echo -e "\033[1;35mThis is parallel job $((BUILDKITE_PARALLEL_JOB+1)) of $BUILDKITE_PARALLEL_JOB_COUNT\033[0m"
