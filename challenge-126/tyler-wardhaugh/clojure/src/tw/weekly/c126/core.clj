(ns tw.weekly.c126.core
  (:require [tw.weekly.c126.t1 :as t1])
  (:require [tw.weekly.c126.t2 :as t2])
  (:gen-class))

(defn -main
  "Run all tasks"
  [& _]
  (println "Task #1:")
  (t1/-main)
  (println "\nTask #2:")
  (t2/-main))
