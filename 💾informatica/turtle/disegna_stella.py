import turtle as t

def disegna_stella(lato):
    t.speed(0)
    t.penup()
    t.goto(0, 0)
    t.pendown()
    t.begin_fill()
    for _ in range(5):
        t.forward(lato)
        t.right(144)
    t.end_fill()

def disegna_fiocco6(lato):
    t.speed(0)
    t.penup()
    t.pensize(5)
    t.pencolor("red")
    t.fillcolor("yellow")
    t.goto(-lato/2, lato/2)
    t.pendown()
    t.begin_fill()
    for _ in range(3):
        t.forward(lato)
        t.right(360/3)
    t.end_fill()
    t.penup()
    t.goto(-lato/2, -lato/8)
    t.pendown()
    t.begin_fill()
    for _ in range(3):
        t.forward(lato)
        t.left(360/3)
    t.end_fill()

disegna_fiocco6(200)


t.done()
