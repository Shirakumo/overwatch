#|
This file is a part of Overwatch
(c) 2015 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
Author: Nicolas Hafner <shinmera@tymoon.eu>
|#


(asdf:defsystem overwatch
  :class "radiance:module"
  :defsystem-depends-on (:radiance) 
  :author "Nicolas Hafner"
  :description "Simple monitoring for Radiance."
  :version "0.0.1" 
  :license "Artistic" 
  :homepage "https://Shirakumo.github.io/overwatch/"
  :bug-tracker "https://github.com/Shirakumo/overwatch/issues"
  :source-control (:git "https://github.com/Shirakumo/overwatch.git")
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
