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
1 ' c=clumna para ir haciendo pokes en las posiciones indicadas por ts'
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


1 ' Inicialización sistema y sprites / System initialization & sprites'
10 screen 1,1,0:width 32:defint a-z:color 1,15,9:key off: s$="1C18183C3E183828 1C18183C3C181814 3818183C7C181C14 3818183C3C181828":ts=&h3800:l=1:for c=0 to 32:vpoke ts+c,VAL("&h"+MID$(s$,l,2)):l=l+2:next
1 ' Menú de bienvenida, inicialización variables / Welcome menu, variable initialization'
20 locate 8,10: print "!Presione una tecla":if inkey$="" then goto 20 else cls:x=16:y=144:s(0)=0:sp=0:s0=0:s1=1:s2=2:s3=3:ex=31:ey=19:es=192:ev=1
1 ' Dibujar pantalla del juego / Draw game screen
30 for i=0 to 31:locate i,0:print chr$(215):locate i,20:print chr$(215):next:for i=0 to 20:locate 0,i: print chr$(215):locate 32, i: print chr$(215):next:play"l10o4g":gosub 90
1 ' Sistema de input & physics'
40 k=stick(0):if pj=0 then oldy=y:if k=3 then x=x+8:sp=s0:swap s0,s1:else if k=7 then x=x-8:sp=s2:swap s2,s3:else if k=1 and pj=0 then pj=1
1 ' Sistema de salto /jump system'
50 if pj=1 and y=oldy-24 then pj=2 else if pj=1 then y=y-8 else if pj=2 then y=y+8:if y=oldy then pj=0
1 ' Physics player & colision'
60 if ex<x/8 and pc=0 then p=p+1:pc=1:play "l10o8gc":gosub 90 else c= base(5)+((y/8)+1)*32+(x/8)+1: if vpeek(c)>=192 then :play "l10o1c": goto 20:gosub 90
1  'fisica bloque enemigo / physical enemy block
70 ex=ex-ev:if ex<0 then ex=31:es=es+1:ec=ec+1:play "l10o4g":locate 0,19:print chr$(32):pc=0:if ec=10 then ev=ev+1:ec=0:if es>224 then es=192
1 ' Render system'
80 putsprite 0,(x,y),9,sp:ob$=chr$(es): for i=0 to ev: ob$=ob$+chr$(32):next:locate ex,ey:print ob$:goto 40
1 ' GUI'
90 locate 5,21:print "Speed:"ev" Ponits: "p:return
















1 ' ------------------------------------'
1 '             Enrity manager          '
1 ' ------------------------------------'















1 ' ------------------------------------'
1 '             Map manager             '
1 ' ------------------------------------'











1 ' ------------------------------------'
1 '       Systema de input              '
1 ' ------------------------------------'

1 ' ------------------------------------'
1 '       Systema de colisiones         '
1 ' ------------------------------------'




1 ''1 ' ------------------------------------'
1 '       Systema de colisiones         '
1 ' ------------------------------------'






1 ''1 ' ------------------------------------'
1 '       Systema de render         '
1 ' ------------------------------------'










1 ' ------------------------------------'
1 '       AI system         '
1 ' ------------------------------------'