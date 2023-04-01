#!/bin/sh

if [[ "${CONFIGURATION}" =~ "Debug" ]]; then
  if [ "${PODS_ROOT+x}" ] && [ -x "${PODS_ROOT}/SwiftLint/swiftlint" ]; then
    echo "SwiftLint pod: $(${PODS_ROOT}/SwiftLint/swiftlint --version)"
    ${PODS_ROOT}/SwiftLint/swiftlint --config swiftlint.yml --quiet
  elif which swiftlint >/dev/null; then
      echo "SwiftLint core: $(swiftlint --version)"
    swiftlint --config swiftlint.yml --quiet
  else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
  fi
fi
