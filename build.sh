#!/usr/bin/env bash

# Accepts MAKEOPTS.

set -euo pipefail
declare -r projectDir="$(dirname "$(realpath "$0")")"
. "$projectDir/common.sh"

echo
msg "Building Cppop."
"$cppopProjectDir/build.sh"

echo
msg "Installing the Cppop Haskell bits."
"$cppopProjectDir/install-haskell.sh"

echo
msg "Generating bindings."
run mkdir -p "$projectDir/lang/hs/src/Foreign/Cppop/Generated"
run cd "$projectDir/lang/hs"
run cabal configure
run cabal build qtah-generator
run dist/build/qtah-generator/qtah-generator \
    --gen-cpp "$projectDir/lang/cpp" \
    --gen-hs "$projectDir/lang/hs/src/Foreign/Cppop/Generated/Qtah.hs"

"$projectDir/tools/listener-gen.sh"

echo
msg "Building the C++ library."
if ! [[ -d $buildDir ]]; then
    run mkdir "$buildDir"
fi
run cd "$buildDir"
run qmake "$projectDir/lang/cpp/qtah.pro"
run make ${MAKEOPTS:-}

echo
msg "Building the Haskell bindings."
run cd "$projectDir/lang/hs"
run cabal configure
run cabal build
