(define (domain lunar-lockout)
    (:requirements :strips :typing :adl :equality :fluents)

    (:types
        coord - number
        spacecraft - object
    )

    (:functions
        (movements)
    )

    (:predicates
        (at ?s - spacecraft ?x ?y - coord)
        (next ?x ?y - coord)
        (adjacent ?x ?y - coord)
    )

    (:action move-up
        :parameters (?ship ?block - spacecraft ?x1 ?x2 ?xtarget ?y - coord)

        :precondition (and
            (adjacent ?x2 ?xtarget)                       ; Target x is adjacent to the block spacecraft
            (at ?ship ?x1 ?y) (at ?block ?x2 ?y)          ; Both spacecrafts are at the given positions
            (next ?x2 ?x1) (not (adjacent ?x2 ?x1))       ; The ship is below, but not adjacent
            (forall (?obstacle - spacecraft ?x3 - coord)  ; There are no obstacles between the spacecraft and the block one
                (not (and
                    (at ?obstacle ?x3 ?y)                 ; 
                    (not (next ?x1 ?x3))                  ; 
                    (not (= ?x1 ?x3))                     ;
                    (next ?x2 ?x3)                        ;
                ))
            )
        )

        :effect (and
            (not (at ?ship ?x1 ?y))
            (at ?ship ?xtarget ?y)
            (increase (movements) 1)
        )
    )

    (:action move-down
        :parameters (?ship ?block - spacecraft ?x1 ?x2 ?xtarget ?y - coord)

        :precondition (and
            (adjacent ?xtarget ?x2)                       ; Target x is adjacent to the block spacecraft
            (at ?ship ?x1 ?y) (at ?block ?x2 ?y)          ; Both spacecrafts are at the given positions
            (next ?x1 ?x2) (not (adjacent ?x1 ?x2))       ; The ship is below, but not adjacent
            (forall (?obstacle - spacecraft ?x3 - coord)  ; There are no obstacles between the spacecraft and the block one
                (not (and
                    (at ?obstacle ?x3 ?y)                 ; 
                    (not (next ?x3 ?x1))                  ;
                    (not (= ?x1 ?x3))                     ;
                    (next ?x3 ?x2)                        ;
                ))
            )
        )

        :effect (and
            (not (at ?ship ?x1 ?y))
            (at ?ship ?xtarget ?y)
            (increase (movements) 1)
        )
    )

    (:action move-left
        :parameters (?ship ?block - spacecraft ?x ?y1 ?y2 ?ytarget - coord)

        :precondition (and
            (adjacent ?y2 ?ytarget)                       ; Target x is adjacent to the block spacecraft
            (at ?ship ?x ?y1) (at ?block ?x ?y2)          ; Both spacecrafts are at the given positions
            (next ?y2 ?y1) (not (adjacent ?y2 ?y1))       ; The ship is below, but not adjacent
            (forall (?obstacle - spacecraft ?y3 - coord)  ; There are no obstacles between the spacecraft and the block one
                (not (and
                    (at ?obstacle ?x ?y3)                 ; 
                    (not (next ?y1 ?y3))                  ;
                    (not (= ?y1 ?y3))                     ; 
                    (next ?y2 ?y3)                        ;
                ))
            )
        )

        :effect (and
            (not (at ?ship ?x ?y1))
            (at ?ship ?x ?ytarget)
            (increase (movements) 1)
        )
    )

    (:action move-right
        :parameters (?ship ?block - spacecraft ?x ?y1 ?y2 ?ytarget - coord)

        :precondition (and
            (adjacent ?ytarget ?y2)                       ; Target x is adjacent to the block spacecraft
            (at ?ship ?x ?y1) (at ?block ?x ?y2)          ; Both spacecrafts are at the given positions
            (next ?y1 ?y2) (not (adjacent ?y1 ?y2))       ; The ship is below, but not adjacent
            (forall (?obstacle - spacecraft ?y3 - coord)  ; There are no obstacles between the spacecraft and the block one
                (not (and
                    (at ?obstacle ?x ?y3)                 ; 
                    (not (next ?y3 ?y1))                  ;
                    (not (= ?y1 ?y3))                     ; 
                    (next ?y3 ?y2)                        ;
                ))
            )
        )

        :effect (and
            (not (at ?ship ?x ?y1))
            (at ?ship ?x ?ytarget)
            (increase (movements) 1)
        )
    )
)

