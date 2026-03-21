(defsystem "reblocks-ui2-sse-tests"
  :author "John Morrison <jm@symbolic-simulation.com>>"
  :license "Unlicense"
  :homepage "https://jmorrison/reblocks-ui2-sse/"
  :class :package-inferred-system
  :description "Provides tests for reblocks-ui2-sse."
  :source-control (:git "https://github.com/jmorrison/reblocks-ui2-sse")
  :bug-tracker "https://github.com/jmorrison/reblocks-ui2-sse/issues"
  :pathname "t"
  :depends-on ("reblocks-ui2-sse-tests/core")
  :perform (test-op (op c)
                    (unless (symbol-call :rove :run c)
                      (error "Tests failed"))))
