(define (problem lunar-lockout1)
    (:domain lunar-lockout)
    
    (:objects
        Red Horange Hyellow Hgreen Hblue Hpurple - spacecraft
        C1 C2 C3 C4 C5 - coord
    )

    (:init
        ; Grid definition

        (= (movements) 0)

        (adjacent C1 C2)
        (next C1 C2) (next C1 C3) (next C1 C4) (next C1 C5)
        
        (adjacent C2 C3)
        (next C2 C3) (next C2 C4) (next C2 C5)
        
        (adjacent C3 C4)
        (next C3 C4) (next C3 C5)
        
        (adjacent C4 C5)
        (next C4 C5)

        ; Problem custom definition

        ;(at Red C5 C2)

        ;(at Horange C1 C1)
        ;(at Hyellow C4 C5)
        ;(at Hgreen C1 C3)
        ;(at Hpurple C1 C5)

        (at Red C5 C5)

        (at Horange C1 C1)
        (at Hgreen C1 C3)
        (at Hpurple C1 C5)
        (at Hyellow C3 C1)
        (at Hblue C5 C1)
    )

    (:goal (at Red C3 C3))

    (:metric minimize (movements))
)