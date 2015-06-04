#|
This file is a part of Overwatch
(c) 2015 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.radiance.overwatch)

(defvar *watchers* (make-hash-table :test 'eql))

(defun watcher (type)
  (or (gethash type *watchers*)
      (setf (gethash type *watchers*)
            (make-instance type))))

(defun list-watchers ()
  (loop for watcher being the hash-values of *watchers*
        collect watcher))


(defclass watcher ()
  ())

(defgeneric metric (watcher))

(defgeneric range (watcher))

(defgeneric value (watcher))

(defgeneric reset (watcher)
  (:method ((watcher watcher)) NIL))

(defclass count-watcher (watcher)
  ())

(defmethod metric ((watcher count-watcher))
  "N")

(defmethod range ((watcher count-watcher))
  '(integer 0))

(defclass percent-watcher (watcher)
  ())

(defmethod metric ((watcher count-watcher))
  "%")

(defmethod range ((watcher percent-watcher))
  '(float 0.0 100.0))


;;; Radiance related watchers

(defclass request-watcher (count-watcher)
  ((value :initform 0 :accessor value)))

(defmethod reset ((watcher request-watcher))
  (setf (value watcher) 0))

(define-trigger radiance:request ()
  (incf (value (watcher 'request-watcher))))


(defclass session-watcher (count-watcher)
  ())

(defmethod value ((watcher session-watcher))
  (length (session:list)))


(defclass user-watcher (count-watcher)
  ())

(defmethod value ((watcher user-watcher))
  (length (user:list)))


(defclass uptime-watcher (count-watcher)
  ())

(defmethod value ((watcher uptime-watcher))
  (- (get-universal-time)
     radiance:*startup-time*))

;;; Runtime related watchers

(defclass thread-watcher (count-watcher)
  ())

(defmethod value ((watcher thread-watcher))
  (length (bt:all-threads)))


(defclass heap-watcher (percent-watcher)
  ())

(defmethod value ((watcher heap-watcher))
  #+sbcl (float
          (/ (sb-kernel:dynamic-usage)
             (sb-ext:dynamic-space-size)))
  #-sbcl 0)
