(uiop:define-package #:reblocks-ui2-sse-examples/simple
  (:use #:cl)
  (:import-from #:reblocks-ui2-sse
                #:in-thread
                #:ui2-sse
                #:ui2-sse-widget)
  (:import-from #:reblocks/widget
                #:update
                #:render
                #:defwidget)
  (:import-from #:reblocks/app
                #:defapp)
  (:import-from #:reblocks/routes
                #:page)
  (:shadowing-import-from #:40ants-routes/defroutes
                #:get))

(in-package #:reblocks-ui2-sse-examples/simple)

(defapp simple-demo
  :prefix "/"
  :routes ((page ("/")
             (make-instance 'ui2-sse-widget))
	   (get ("/ui2-sse" :name "ui2-sse")
		(list 200
		      (list :content-type "text/event-stream")
		      (format t "~s~%" (list :ui2-sse :route))))
	   (get ("/foo" :name "foo")
		(clack-sse:serve-sse 'clack-sse-demo::server-sent-events-handler)
		)
	   )
  )


(defun run (&key (port 8080))
  (reblocks/server:start :port port))
