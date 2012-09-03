;;Solution to problem 4.20 from Structure and Interpretation of Computer Programs

(define (make-let bindings body)
  (cons 'let (cons bindings body)))
(define (letrec-vars exp) 
  (let ((bindings (cadr exp)))
    (map car bindings)))
(define (letrec-exps exp)
  (let ((bindings (cadr exp)))
    (map cadr bindings)))
(define (make-set var val)
  (list 'set! var val))
(define (letrec-body exp)
  (cddr exp))
(define (letrec->let exp)
  (define (make-initial-bindings vars)
    (if (null? vars)
	'()
	(cons (list (car vars) ''*unassigned) (make-initial-bindings (cdr vars)))))
  (define (make-set-exps vars exps)
    (if (null? vars)
	'()
	(cons (make-set (car vars) (car exps))
	      (make-set-exps (cdr vars) (cdr exps)))))
  (let ((vars (letrec-vars exp))(exps (letrec-exps exp)))
    (make-let (make-initial-bindings vars) (append (make-set-exps vars exps) (letrec-body exp)))))

(letrec ((evn? (lambda (n)
	      (if (= 0 n)
		  true
		  (od? (- n 1)))))
      (od? (lambda (n)
	     (if (= n 0)
		 false
		 (evn? (- n 1))))))
  (evn? 5))
