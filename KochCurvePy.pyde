def setup():
    size(900, 900)

def draw():
    noFill();
    a=[100,450];
    b=[800,450]
    koch(a[0],a[1], b[0],b[1], 4)

def koch(ax,ay,bx,by, nivel):
    if(nivel == 0):
        line(ax,ay,bx,by)
        return
    c=[(bx-ax)*(1/3.0)+ax,(by-ay)*(1/3.0)+ay];
    d=[(bx-ax)*(2/3.0)+ax,(by-ay)*(2/3.0)+ay];
    e=[((d[0]-c[0])*cos(PI/3) + (d[1]-c[1])*sin(PI/3))+c[0],((d[1]-c[1])*cos(PI/3) - (d[0]-c[0])*sin(PI/3))+c[1]];
    koch(ax,ay,c[0],c[1], nivel-1)
    koch(c[0],c[1], e[0], e[1], nivel-1)
    koch(e[0],e[1], d[0], d[1], nivel-1)
    koch(d[0],d[1], bx, by, nivel-1)
