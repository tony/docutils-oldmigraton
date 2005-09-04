;; Authors: Martin Blais <blais@furius.ca>
;; Date: $Date: 2005/04/01 23:19:41 $
;; Copyright: This module has been placed in the public domain.
;;
;; Regression tests for rest-adjust-section-title.
;; 
;; Run this with::
;;
;;    emacs --script tests-adjust-section.el
;;

;; Define tests.
(setq rest-adjust-section-tests 
  '(
;;------------------------------------------------------------------------------
(nodec-first-simple-1
"
Some Title@

"
"
============
 Some Title
============

"
)

;;------------------------------------------------------------------------------
(nodec-first-simple-2
"
Some Title
@
"
"
============
 Some Title
============

"
)

;;------------------------------------------------------------------------------
(nodec-first-simple-3
"
Some Tit@le

"
"
============
 Some Title
============

"
)

;;------------------------------------------------------------------------------
(nodec-first-simple-4
"
@Some Title

"
"
Some Title
==========

")


;;------------------------------------------------------------------------------
(nodec-first-simple-others
"
Some Title@

Other Title
-----------

Other Title2
~~~~~~~~~~~~

"
"
============
 Some Title
============

Other Title
-----------

Other Title2
~~~~~~~~~~~~

"
)


;;------------------------------------------------------------------------------
(nodec-first-toggle
"
Some Title@

"
"
Some Title
==========

"
(t))

;;------------------------------------------------------------------------------
(nodec-first-forced
"
   Some Title@

"
"
================
   Some Title
================

"
)

;;------------------------------------------------------------------------------
(nodec-first-forced
"
   Some Title@

"
"
Some Title
==========

"
(t))

;;------------------------------------------------------------------------------
(nodec-simple
"
Previous Title
--------------

Some Title@

"
"
Previous Title
--------------

Some Title
----------

"
)

;;------------------------------------------------------------------------------
(nodec-simple-neg
"
Previous Title
--------------

Some Title@

Next Title
~~~~~~~~~~

"
"
Previous Title
--------------

Some Title
~~~~~~~~~~

Next Title
~~~~~~~~~~

"
)

;;------------------------------------------------------------------------------
(nodec-simple-toggle
"
Previous Title
--------------

Some Title@

"
"
Previous Title
--------------

------------
 Some Title
------------

"
(t))

;;------------------------------------------------------------------------------
(nodec-simple-force-toggle
"
Previous Title
--------------

  Some Title@

"
"
Previous Title
--------------

Some Title
----------

"
(t))


;;------------------------------------------------------------------------------
(nodec-simple-forced
"
Previous Title
--------------

   Some Title@

"
"
Previous Title
--------------

---------------
   Some Title
---------------

"
)

;;------------------------------------------------------------------------------
(nodec-neg
"
Previous Title
--------------

Some Title@

Next Title
~~~~~~~~~~
"
"
Previous Title
--------------

Some Title
~~~~~~~~~~

Next Title
~~~~~~~~~~
"
(-1))

;;------------------------------------------------------------------------------
(incomplete-simple-1
"
Previous Title@
----------
"
"
Previous Title
--------------
"
)

;;------------------------------------------------------------------------------
(incomplete-simple-2
"
Previous Title
----------@
"
"
Previous Title
--------------
"
)

;;------------------------------------------------------------------------------
(incomplete-simple-3
"
Previous Title
-@
"
"
Previous Title
--------------
"
)

;;------------------------------------------------------------------------------
(incomplete-simple-too-long
"
Previous Title
------------------@
"
"
Previous Title
--------------
"
)

;;------------------------------------------------------------------------------
(incomplete-simple-uo
"
----------------
 Previous Title
----------@
"
"
----------------
 Previous Title
----------------
"
)

;;------------------------------------------------------------------------------
(incomplete-partial-overline
"
----------@
 Previous Title
----------------
"
"
----------------
 Previous Title
----------------
"
)

;;------------------------------------------------------------------------------
(incomplete-both
"
----------
 Previous Title@
-----
"
"
----------------
 Previous Title
----------------
"
)

;;------------------------------------------------------------------------------
(incomplete-toggle
"
Previous Title
----------@
"
"
----------------
 Previous Title
----------------
"
(t))

;;------------------------------------------------------------------------------
(incomplete-toggle-2
"
----------------
 Previous Title@
--------
"
"
Previous Title
--------------
"
(t))

;;------------------------------------------------------------------------------
(incomplete-toggle-overline
"
--------@
 Previous Title
----------------
"
"
Previous Title
--------------
"
(t))

;;------------------------------------------------------------------------------
(complete-simple
"
================
 Document Title
================

SubTitle
--------

My Title@
--------

After Title
~~~~~~~~~~~

"
"
================
 Document Title
================

SubTitle
--------

My Title
~~~~~~~~

After Title
~~~~~~~~~~~

"
)

;;------------------------------------------------------------------------------
(complete-simple-neg
"
================
 Document Title
================

SubTitle
--------

My Title@
--------

After Title
~~~~~~~~~~~

"
"
================
 Document Title
================

SubTitle
--------

==========
 My Title
==========

After Title
~~~~~~~~~~~

"
(-1))

;;------------------------------------------------------------------------------
(complete-simple-suggestion-down
"
================
 Document Title
================

SubTitle
========

My Title@
========

"
"
================
 Document Title
================

SubTitle
========

My Title
--------

"
)

;;------------------------------------------------------------------------------
(complete-simple-boundary-down
"
================
 Document Title
================

SubTitle
========

My Title@
--------

"
"
================
 Document Title
================

SubTitle
--------

==========
 My Title
==========

"
)

;;------------------------------------------------------------------------------
(complete-simple-suggestion-up
"
================
 Document Title
================

SubTitle
========

==========
 My Title
==========

"
"
================
 Document Title
================

SubTitle
========

My Title
--------

"
(-1))

;;------------------------------------------------------------------------------
(complete-simple-boundary-up
"
================
 Document Title
================

SubTitle
========

My Title@
--------
"
"
================
 Document Title
================

SubTitle
========

==========
 My Title
==========

"
(-1))

;;------------------------------------------------------------------------------
(complete-toggle-1
"
SubTitle@
~~~~~~~~

"
"
~~~~~~~~~~
 SubTitle
~~~~~~~~~~

"
(t))

;;------------------------------------------------------------------------------
(complete-toggle-2
"
~~~~~~~~~~
 SubTitle@
~~~~~~~~~~

"
"
SubTitle
~~~~~~~~

"
(t))

;;------------------------------------------------------------------------------
(at-file-beginning
"
Document Title@

"
"
================
 Document Title@
================

"
)


;;------------------------------------------------------------------------------
(at-file-ending
"

Document Title@
"
"

================
 Document Title@
================
"
)

;;------------------------------------------------------------------------------
(at-file-ending-2
"

Document Title@"
"

================
 Document Title@
================"
)

;;
;; Old tests, kept for convenience only.  These should be redundant now, but you
;; can never have too much tests...
;;


;;------------------------------------------------------------------------------
(old-with-previous-text
"
Some Title
**********

Subtitle@

"
"
Some Title
**********

Subtitle
********

")

;;------------------------------------------------------------------------------
(old-with-suggested-new-text
"
Some Title
==========

Subtitle
--------

Subtitle2@

"
"
Some Title
==========

Subtitle
--------

Subtitle2
~~~~~~~~~

"
(nil nil))

;;------------------------------------------------------------------------------
(old-with-previous-text-rotating
"
Some Title
==========

Subtitle
--------

Subtitle2@

"
"
Some Title
==========

Subtitle
--------

Subtitle2
=========

"
(nil nil nil))

;;------------------------------------------------------------------------------
(old-start-indented
"
   Some Title@

"
"
================
   Some Title
================

")

;;------------------------------------------------------------------------------
(old-switch-from-nothing
"
Some Title@

"
"
============
 Some Title
============

" (t))

;;------------------------------------------------------------------------------
(old-switch-from-over-and-under
"
============
 Some Title@
============
"
"
Some Title
==========

" (t))

;;------------------------------------------------------------------------------
(old-incomplete-over-and-under
"
============
  Some Title@
============
"
"
==============
  Some Title
==============

")

;;------------------------------------------------------------------------------
(old-cycle-over-and-under
"
===========
   Notes
===========
   
----------------------
  Specific Questions@
----------------------

"
"
===========
   Notes
===========
   
======================
  Specific Questions
======================

")

))


;; Main program.  Evaluate this to run the tests.
;; (setq debug-on-error t)

;; Import the module from the file in the parent directory directly.
(add-to-list 'load-path ".")
(load "tests-runner.el")
(add-to-list 'load-path "..")
(load "restructuredtext.el")

(progn
  (regression-test-compare-expect-buffer
   "Test interactive adjustment of sections."
   rest-adjust-section-tests
   (lambda ()
     (call-interactively 'rest-adjust-section-title))
   t))

