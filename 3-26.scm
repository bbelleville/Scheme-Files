;;; This is excercise 3.26
;;; Brian Belleville
;;; 10 April 2012

(define (make-tree-item key data)
  (cons (cons key data) (cons '() '())))
(define (left-link tree-item)
  (cadr tree-item))
(define (right-link tree-item)
  (cddr tree-item))
(define (set-left-link! tree-item new-link)
  (set-car! (cdr tree-item) new-link))
(define (set-right-link! tree-item new-link)
  (set-cdr! (cdr tree-item) new-link))
(define (data tree-item)
  (cdar tree-item))
(define (keyval tree-item)
  (caar tree-item))
(define (set-data! tree-item new-data)
  (set-cdr! (car tree-item) new-data))
(define (make-table)
  (list '*table*))
(define (assoc key tree-item)
  (cond ((< key (keyval tree-item))
	 (if (null? (left-link tree-item))
	     (cons #f tree-item)
	     (assoc key (left-link tree-item))))
	((> key (keyval tree-item))
	 (if (null? (right-link tree-item))
	     (cons #f tree-item)
	     (assoc key (right-link tree-item))))
	(else (cons #t  tree-item))))
(define (lookup key table)
  (if (null? (cdr table))
      #f
      (let ((ret (assoc key (cdr table))))
	(if (car ret)
	    (data (cdr ret))
	    #f))))
(define (insert! key value table)
  (if (null? (cdr table))
      (set-cdr! table (make-tree-item key value))
      (let ((parrent (cdr (assoc key (cdr table)))))
	(cond ((equal? key (keyval parrent))
	       (set-data! parrent value))
	      ((< key (keyval parrent))
	       (set-left-link! parrent (make-tree-item key value)))
	      (else (set-right-link! parrent (make-tree-item key value)))))))

  
	
