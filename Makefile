#
# Building and testing Common Lisp implementation of reblocks-ui2-sse
#

SBCL=/usr/bin/sbcl --dynamic-space-size 4gb --control-stack-size 20

#
# Testing targets
#

#
# Open http://localhost:9999
# but ad-blockers in Firefox preclude
# working
#

test-sse:
	$(SBCL) \
            --eval "(ql:quickload '(:clouseau :clim-debugger :cl-advice :log4cl :sse-demo :clack-sse :clack-handler-hunchentoot :clack-sse-demo :reblocks-ui2-sse))" \
            --load examples/simple.lisp \
            --eval '(reblocks-ui2-sse-examples/simple::run)'

#
# Just to test the reblocks-ui2 demo
#

test-reblocks-demo: # $(PREBID_JS)
	$(SBCL) \
         --eval "(ql:quickload '(:clack-handler-hunchentoot :40ants-routes :40ants-logging :reblocks-ui2 :reblocks-ui2-demo))" \
         --eval "(reblocks-ui2-demo/server:start)"

