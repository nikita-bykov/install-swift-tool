## How to contribute

Install once on macOS (Homebrew required)
```bash
$ make once-mac
```

Run before commit 
```bash
make build
```

Run tests in `./__test__/` (for testing parts of the logic, the real tests are run on GitHub after push/pull request)
```bash
make test-local
```

## Usage:

Step example:
```yaml
- name: Install xcbeautify
  uses: Cyberbeni/install-swift-tool@master
  with:
    url: https://github.com/Cyberbeni/xcbeautify
    branch: linux-fixes # optional
```

Full Linux example:
```yaml
jobs:
  test-linux:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout
      uses: actions/checkout@v1
    - name: Install Swift
      uses: YOCKOW/Action-setup-swift@master
    - name: Install xcbeautify
      uses: Cyberbeni/install-swift-tool@master
      with:
        url: https://github.com/Cyberbeni/xcbeautify
        branch: linux-fixes
    - name: Test
      run: |
        set -o pipefail
        swift test --enable-code-coverage | xcbeautify
    - name: Codecov
      run: |
        llvm-cov export -format="lcov" .build/debug/TypedNotificationCenterPackageTests.xctest -instr-profile .build/debug/codecov/default.profdata > info.lcov
        bash <(curl -s https://codecov.io/bash) -J 'TypedNotificationCenter' -n 'linux' -F 'linux'
      env:
        CODECOV_TOKEN: ${{ secrets.CODECOV_TOKEN }}
```
