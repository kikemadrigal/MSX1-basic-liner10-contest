
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
1  '---Sprites---''
1 ' s$= cadena que contiene la definición de los sprites'
1 ' ts=direción tabla definición de sprites o sprites pattern que en modo gráfico sc1 es &h3800'
1 ' l=letra seleccionada de la cadena(variables auxiliar)'
1 ' c=clumna para ir haciendo pokes en las posiciones indicadas por ts'

1 '--Input----'
1 ' i=contador para bucles simples'
1 ' k=tecla pulsada proporcinada por stick(0) '

1 ' -----Variables player----'
1 ' x=coordenada x'
1 ' y=coordenada y'
1 ' sp=sprite player a renderizar
1 ' s0,s1,s2 y s3=variables para hacer la animación de movimeinto'
1 ' v=vida
1 '----bloque----'
1 'ex=coordenada x bloque'
1 'es: enemigo sprite'
1 ''

1 ' Inicialización sistema y variables globales
10 color 1,11,13:screen 1,1,0:width 32:defint a-z:key off:ts=&h3800:l=1:es=192:ex=15:ey=7:ev=1:sp=0:s0=0:s1=1:s2=2:s3=3:r=em:em=2:f=0:putsprite 1,(ex*8,1),4,4:ea=1
1 'Definición de sprites: 1 player derecha, 2 player derecha movimiento, 3 player izquierda, 4 player izquierda movimeinto,5. enemigo 1,6.enemigo 2' 
1 'Despues de inicializar saltamos a la línea 40'
20 s$="1C18183C3E183828 1C18183C3C181814 3818183C7C181C14 3818183C3C181828 0000000018187EBD 000000425A5A7E3C":for c=0 to 48:vpoke ts+c,VAL("&h"+MID$(s$,l,2)):l=l+2:next
1 ' Menú de bienvenida, Inicio juego
30 locate 0,10: print "Objective: Get to level 20, to get poniter capture the objects before they hit the ground! ":if inkey$="" then goto 30 else cls:x=100:y=144:ey=6:p=0:time=0:s=10-int(time/60)


1 ' Inicio si cambias de fase
40 if ev>2 then ev=1 else r=em:locate 1,21:print "Points:"p"catch:"r"level:"f:if f=0 then for i=0 to 31:locate i,2:print chr$(215):locate i,20:print chr$(215):next:for i=0 to 20:locate 0,i: print chr$(215):locate 32, i: print chr$(215):next:play"l10o4g"
1 ' Sistema de input & physics & main loop, cambiamos el sprite si se mueve'
1 '50 tr= base(5)+((y/8)+1)*32+(x/8)+2:tl= base(5)+((y/8)+1)*32+(x/8):k=stick(0):if k=3 and vpeek(tr)<192 then x=x+8:sp=s0:swap s0,s1:else if k=7 and vpeek(tl)<192 then x=x-8:sp=s2:swap s2,s3
50 k=stick(0):if k=3 then x=x+8:sp=s0:swap s0,s1:else if k=7 then x=x-8:sp=s2:swap s2,s3
1 'Phisic player & Colisión con paquete'
1 'Si el player se ha salido de la pantalla volvemos a empezar'
1 'Si no se ha salido comprobamos las colisiones con los objetos, si hay una colisión con un bloque sumamos un punto y mostramos la información'
1 '60 if y>160 then play "l10o4gc":for i=0 to 100: color,,8:f=0:ev=1.25:color,,13:next:goto 30 else if x<ex*8 + 8 and  x+8 > ex*8 and y<ey*8+8 and 8+y>ey*8 and ea=1 then p=p+1:r=r-1:play "l10o8gc":ea=0: time=0:locate 1,21:print "Points:"p"catch:"r"level:"f
60 if y>160 then play "l10o4gc":for i=0 to 100: color,,8:f=0:ev=1:color,,13:next:goto 30 else if x<ex*8 + 8 and  x+8 > ex*8 and y<ey*8+8 and 8+y>ey*8 and ea=1 then p=p+1:r=r-1:play "l10o8gc":ea=0: time=0:locate 1,21:print "Points:"p"catch:"r"level:"f
1 'Vamos aumentando en 1 la y del paquete para que baje'
1 'Si el paquete es mayor que la posición del enemigo 
1 ' 1. Creamos otro paquete 
1 ' 2. Mostramos al personaje de arriba en la posición ueva del paquete'
1 ' 3. Si el paquete es un sprite mayor que 215 lo ponemos en 192'
70 s=10-int(time/60):locate 1,22:print s :ey=ey+ev:if ey>20 then ex=rnd(1)*(30-2)+2:ey=6:es=es+1:ea=1:putsprite 1,(ex*8,1),4,4:if es>215 then es=192
1 'Pintamos el bloque que cae print "S"s"ey"ey"ev"ev"ea"ea  
1 'Comprobamos el suelo, si el suelo no es el tile del suelo hacemos que caiga'
80 putsprite 0,(x,y),9,sp:locate ex,ey-ev: print chr$(32):if ea=1 then locate ex,ey:print chr$(es): t= base(5)+((y/8)+2)*32+(x/8)+1: if vpeek(t)<>215 then y=y+8 
1 'Si los segundos llegan a 0 empezamos'
1 'Si los segundo no llegan a 0'
1 '     Si la fase llega a 20 final'
1 '         Si los que faltan por coger son 0'
1 '90 if s<=0 then goto 30 else if f=20 then cls: locate 0,10: print "Congratulations, you've reached the end of the game!" else if r=0 then f=f+1:ev=ev+0.25:locate 1,21:print "Points:"p"catch:"r"level:"f:goto 40 else goto 50
90 if f=20 then cls: locate 0,10: print "Congratulations, you've reached the end of the game!" else if r=0 then f=f+1:ev=ev+1:locate 1,21:print "Points:"p"catch:"r"level:"f:goto 40 else goto 50
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