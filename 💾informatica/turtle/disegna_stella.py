import turtle as t

t.speed(0)
t.penup()
t.pencolor("red")
t.fillcolor("yellow")

def disegna_stella(lato):
    #t.goto(t.xcor()-lato/2, t.ycor()+lato/2)
    t.pendown()
    t.begin_fill()
    for _ in range(5):
        t.forward(lato)
        t.right(144)
    t.end_fill()
    t.penup()

def disegna_fiocco6(lato):
    t.pensize(5)
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
    t.penup()

disegna_fiocco6(100)
t.goto(100, 0)
disegna_stella(100)


t.done()
