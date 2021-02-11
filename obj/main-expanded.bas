1 '         patrones sprites'
1 '14336 / &h3800 ******************'
1 '         Colores tiles'
1 '8192 / &h2000  ******************'
1 '         Atributos sprite'
1 '6912 / &h1b00  ******************'
1 '         mapa de tiles'
1 '6144 / &h1800  ******************'
1 '         patrones tiles'
1 '0              ******************'

1 'inicialización'
1 '***********************
1 '  variables globales'
1 '***********************
1 ' s$= cadena que contiene la definición de los sprites'
1 ' ts=direción tabla definición de sprites o sprites pattern que en modo gráfico sc1 es &h3800'
1 ' l=letra seleccionada de la cadena(variables auxiliar)'
1 ' f y c para ir haciendo pokes en las posiciones indicadas por ts'
1 ' i=contador para bucles simples'
1 ' k=tecla pulsada proporcinada por stick(0) '
1 'Variables player'
1 ' x coordenada x'
1 ' y coordenada y'
1 ' oldy se utiliza para guardar la posición del player en el momento del salto
1 ' pc para contar y cuando''
1 ' pj player jump para saltar'
1 ' pc se utiliza como bandere, solo se sumará un punto al player (variable p) si ha llegado al borde izquierdo'
1 ' de la pantalla el enemigo, entonces pc vale 0 y se le puede sumar un punto si la ex(coordenada enemigo x)<x del player'
1 ' s0 y s1=sprite player right se combinarán con swap valor1,valor2 para que tenga el valor e los sprites 0 y 1 que son los de la derecha'
1 ' p2 y s3=sprite player left se combinarán con swap valor1,valor2 para que tenga el valor e los sprites 2 y 3 que son los de la izquierda'
5 screen 1,1,0:width 32:defint a-z:color 1,15,9:key off
1 ' player derecha'
1 ' DATA 1C,18,18,3C,3E,18,38,28
1 ' 00011100 =&h1C
1 ' 00011000
1 ' 00011000
1 ' 00111100
1 ' 00111110
1 ' 00011000
1 ' 00111000
1 ' 00101100
1 ' player derecha andando'
1 ' DATA 1C,18,18,3C,3C,18,18,14
1 ' player izquierda'
1 ' DATA 38,18,18,3C,7C,18,1C,14
1 ' player izquierda andando'
1 ' DATA 38,18,18,3C,3C,18,18,28


10 s$="1C18183C3E183828 1C18183C3C181814 3818183C7C181C14 3818183C3C181828"
1 'sp=patrones sprite tabla (14336)'
20 ts=&h3800
1 'letra seleccionada del string' 
25 l=1
1 'f=fila c=columna'
30 'for f=0 to 1
    40 for c=0 to 32
        50 vpoke ts+c,VAL("&h"+MID$(s$,l,2))
        60 l=l+2
    70 next
80 'next
 1'90 putsprite 0,(x,y),9,sp
 1'100 putsprite 1,(x,y),9,sp
 1'110 putsprite 2,(x,y),9,sp
 1'120 putsprite 3,(x,y),9,sp
1 '90 ta=&h1b00
1 '100 for i=0 to 4*4 step 4
1 '    1 ' su posición en el eje X'
1 '    110 vpoke ta+i, 0
1 '    1 'su posición en el eje Y'
1 '    120 vpoke ta+i+1, 8*i
1 '    1 'número de sprite que hay en la zona de definición de la VRAM a partir de la posición VRAM  ts=#3800:'
1 '    130 vpoke ta+i+2, i
1 '    1 ' la definición del color, solo se puede utilizar un solo color'
1 '    140 vpoke ta+i+3, 1
1 '150 next


160 locate 8,10: print "!Presione una tecla":if inkey$="" then goto 160 else cls
170 x=16:y=144:s(0)=0:sp=0:s0=0:s1=1:s2=2:s3=3:ex=31:ey=19:es=192:ev=1



    
1 'Marco horizontal'
180 for i=0 to 31: locate i, 0: print chr$(215):locate i, 20: print chr$(215)
    1 'Marco vertical'
    190 if i<20 then locate 0,i: print chr$(215):locate 32, i: print chr$(215)
195 next

196 play "l10o4g":gosub 600

1 ' Sistema de input & physics'
200 k=stick(0):if pj=0 then oldy=y
210 if k=2 then x=x+8:if pj=0 then pj=1
220 if k=3 then x=x+8:sp=s0:swap s0,s1
230 if k=7 then x=x-8:sp=s2:swap s2,s3
240 if k=8 then x=x-8:if pj=0 then pj=1
250 if k=1 then :if pj=0 then pj=1
1 'El player se está elevando'
260 if pj=1 then y=y-8
1 'El player ha llegado a la posición maxima de salto'
270 if pj=1 and y=oldy-24 then pj=2
1 'El player está baando'
280 if pj=2 then y=y+8:if y=oldy then pj=0

1 ' physics player & colision'
1 'Si la posición eje x del enemigo es menor que la del player es que lo ha esquivado'
1 'pc=player contador es una bandera para que no esté sumando hasta que el enemigo llegue al lado izquierdo'
300 if ex<x/8 and pc=0 then p=p+1:pc=1:play "l10o8gc"
310 c= base(5)+((y/8)+1)*32+(x/8)+1: if vpeek(c)>=192 then :play "l10o1c": goto 160:gosub 600

1  'fisica bloque enemigo 
500 ex=ex-ev:if ex<0 then ex=31:es=es+1:ec=ec+1:play "l10o4g":locate 0,19:print chr$(32):pc=0
503 if ec=10 then ev=ev+4:ec=0
510 if es>224 then es=192

1 'render'
511 putsprite 0,(x,y),9,sp
515 ob$=chr$(es): for i=0 to ev: ob$=ob$+chr$(32):next
520 locate ex,ey:print ob$
550 goto 200

1 'GUI'
600 locate 5,21:print "Speed:"ev" Ponits: "p" c: "vpeek(c)
1 '530 locate 5,21:print "ex:"ex*8" ey: "ey*8
1 '540 locate 5,22:print "tx:"x/8" ty: "y/8" x "x" y "y" ponit: "point (x+8,y)
610 locate 5,22:print "tx:"(x)+16" ty: "(y)+8" ponit: "point ((x)+4,(y)+4)
620 return


