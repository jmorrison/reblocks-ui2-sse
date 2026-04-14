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

;;;; Begin test scaffolding

;; (ql:quickload '(:clouseau :cl-advice :clim-debugger))

#+NIL (trace clack-sse:serve-sse)
#-NIL (cl-advice:define-advisory-functions (clack-sse:serve-sse :next-arg fn) (fcn)
	(:before
	 (clouseau:inspect (list :before :serve-sse fcn))))


#+NIL (trace clack-sse-demo::server-sent-events-handler)
#-NIL (cl-advice:define-advisory-functions (clack-sse-demo::server-sent-events-handler :next-arg fn) (fcn)
	(:before
	 (clouseau:inspect (list :before :server-sent-events-handler fcn hunchentoot:*header-stream*))))

#+NIL (trace sse-server:send-event!)
#-NIL (cl-advice:define-advisory-functions (sse-server:send-event! :next-arg fn) (ostream event data &key id retry fields)
	(:before
	 (clouseau:inspect (list :before :send-event! ostream event data id retry fields))
	 (clim-debugger:debugger (make-condition 'warning) t))
	((:after foo-after)
	 (clouseau:inspect (list :after :send-event! ostream event data id retry fields))
	 (clim-debugger:debugger (make-condition 'warning) t)))

;;;; End test scaffolding

(defun foo (env output-stream)
  #-NIL (clouseau:inspect (list :foo env output-stream))
  ;; (sb-ext:quit)
  (loop with counter = 0
        repeat 100
        do 
        #+NIL (sleep 2)
        ;; Without sse-server module
        #+NIL (format output-stream "event:my-custom-event~%data:Hello World! ~d~%~%" (incf counter))
        ;; With sse-server module
	#-NIL
        (sse-server:send-event! output-stream 
                                "my-custom-event"
                                (format nil "Hello World! ~d" (incf counter)))
        (finish-output output-stream)))

(defapp simple-demo
    :prefix "/"
    :routes ((page ("/")
		   (make-instance 'ui2-sse-widget))
	     (40ants-routes/defroutes:get ("/events" :name "events" :route-class reblocks-ui2-sse::ui2-sse-route)
					  (setf (hunchentoot:content-type*) "text/event-stream; charset=utf-8")
					  (format t "get 1 !!!~%")
					  )
	     #+NIL
	     (get ("/events" :name "events")
		  #+NIL (list 200
			      (list :content-type "text/event-stream")
			      (format t "get ~s~%" (list :ui2-sse :route)))
		  #+NIL (clack-sse:serve-sse 'clack-sse-demo::server-sent-events-handler)
		  #+NIL (progn
			  (setf (hunchentoot:content-type*) "text/event-stream; charset=utf-8")
			  (clack-sse:serve-sse 'foo)))))


(defun run (&key (port 8080))
  (reblocks/server:start :port port))
