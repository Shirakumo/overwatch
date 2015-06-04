#|
This file is a part of Overwatch
(c) 2015 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.radiance.overwatch)

(defvar *recorder* NIL)
(defvar *default-watchers* '(request-watcher session-watcher user-watcher uptime-watcher thread-watcher heap-watcher))

(define-trigger db:connected ()
  (db:create 'overwatch-points '((watcher (:varchar 64)) (value :float) (time (:integer 5)))
             :indices '(watcher time)))

(define-trigger radiance:startup ()
  (dolist (watcher (or (radiance:config-tree :overwatch :watchers)
                       *default-watchers*))
    (let ((name (find-symbol (string-upcase watcher) :org.shirakumo.radiance.overwatch)))
      (when name (watcher name))))
  (unless *recorder*
    (setf *recorder*
          (bt:make-thread #'recording-loop))))

(defun recording-loop ()
  (loop while (radiance:started-p)
        do (sleep 60)
           (handler-case
               (handler-bind ((error (lambda (err)
                                       (when radiance:*debugger*
                                         (invoke-debugger err)))))
                 (record))
             (error (err)
               (v:warn :overwatch "Error during recording: ~s" err)))))

(defun record ()
  (when (db:connected-p)
    (let ((time (get-universal-time)))
      (dolist (watcher (list-watchers))
        (db:insert 'overwatch-points `((watcher ,(string (type-of watcher)))
                                       (value ,(value watcher))
                                       (time ,time)))))))
