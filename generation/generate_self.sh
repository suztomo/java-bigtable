#!/bin/bash

set -e

basedir=$(dirname "$(readlink -f "$0")")

mkdir -p target
rm -rf target/sdk-platform-java


# Step 1: Checkout the corresponding generator's branch. It remembers
# the googleapis' revision and WORKSPACE
generator_branch=$(cat "${basedir}/generator-branch" | tr -d '\n')
git clone --depth=1 --branch "${generator_branch}" https://github.com/googleapis/sdk-platform-java target/sdk-platform-java

repo_path=$(realpath "${basedir}/..")

# Step 2: Using the generator to generate Java code to this repository.
# It takes the corresponding Bazel packages. This java-bigtable uses
# Java files from the two Bazel packages.
export REPO="${repo_path}"
sh -x target/sdk-platform-java/generation/generate.sh //google/bigtable/v2 //google/bigtable/admin/v2

