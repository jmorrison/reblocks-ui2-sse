#-asdf3.1 (error "reblocks-ui2-sse requires ASDF 3.1 because for lower versions pathname does not work for package-inferred systems.")
(defsystem "reblocks-ui2-sse"
  :description "Reblocks extension allowing to add Server-Sent Events between a backend and Reblocks widgets."
  :author "John Morrison <jm@symbolic-simulation.com>"
  :license "Unlicense"
  :homepage "https:///github.com/jmorrison/reblocks-ui2-sse.git"
  :source-control (:git "https:///github.com/jmorrison/reblocks-ui2-sse")
  :bug-tracker "https://github.com/jmorrison/reblocks-ui2-sse/issues"
  :class :40ants-asdf-system
  :defsystem-depends-on ("40ants-asdf-system" "40ants-routes")
  :pathname "src"
  :depends-on ("reblocks-ui2-sse/sse-widget")
  :in-order-to ((test-op (test-op "reblocks-ui2-sse-tests"))))
