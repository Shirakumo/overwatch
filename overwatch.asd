#|
This file is a part of Overwatch
(c) 2015 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:cl-user)
(asdf:defsystem overwatch
  :class "radiance:module"
  :defsystem-depends-on (:radiance) 
  :author "Nicolas Hafner"
  :description "Simple monitoring for Radiance."
  :version "0.0.1" 
  :license "Artistic" 
  :homepage "http://github.com/Shirakumo/overwatch"
  :components ((:file "module")
               (:file "watchers")
               (:file "record")
               (:file "admin"))
  :depends-on ((:interface :database)
               (:interface :data-model)
               (:interface :session)
               (:interface :user)
               (:interface :admin)
               :bordeaux-threads))
