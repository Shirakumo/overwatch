(asdf:defsystem overwatch
  :class "radiance:module"
  :defsystem-depends-on (:radiance) 
  :author "Yukari Hafner"
  :description "Simple monitoring for Radiance."
  :version "0.0.1" 
  :license "zlib" 
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
