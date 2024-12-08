;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "ein" "20230827.325"
  "Jupyter notebook client."
  '((emacs       "26.1")
    (websocket   "1.12")
    (anaphora    "1.0.4")
    (request     "0.3.3")
    (deferred    "0.5")
    (polymode    "0.2.2")
    (dash        "2.13.0")
    (with-editor "0pre"))
  :url "https://github.com/millejoh/emacs-ipython-notebook"
  :commit "ac92eb92eac35a9542485969487e43f5318825a1"
  :revdesc "ac92eb92eac3"
  :keywords '("jupyter" "literate programming" "reproducible research"))
