
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
1 ' x=coordenada x de 0 a 255'
1 ' y=coordenada y de 0 a 192'
1 ' sp=sprite player a renderizar
1 ' s0,s1,s2 y s3=variables para hacer la animación de movimeinto'

1 '----objeto /enemigo----'
1 'ex=coordenada x objeto para locate de 0 a 31'
1 'ey=coordenada y objeto para locate de 0 a 31'
1 'es: enemigo sprite'
1 'ev=velocidad de caida del objeto'
1 'ec=enemigos a capturar'
1 'em=enemigos máximos a capturar'
1 'f=fase'
1 'ea=enemigo activo, puede ser dibujado'

1 ' Inicialización sistema, icialización de variables globales
10 color 1,11,13:screen 1,1,0:width 32:defint a-z:key off:ts=&h3800:l=1:sp=0:s0=0:s1=1:s2=2:s3=3:ex=15:ey=4:es=192:ev=0:ec=em:em=2:ea=1:f=0
1 'Definición de sprites: 0 player derecha, 1 player derecha movimiento, 2 player izquierda, 3 player izquierda movimeinto,4. enemigo 1,5.enemigo 2' 
1 'Pintamos al personaje que está arriba'
20 s$="1C18183C3E183828 1C18183C3C181814 3818183C7C181C14 3818183C3C181828 0000000018187EBD 000000425A5A7E3C":for c=0 to 48:vpoke ts+c,VAL("&h"+MID$(s$,l,2)):l=l+2:next:putsprite 1,(ex*8,1),4,4

1 ' Inicio juego, mensaje de bienvenida, ponemos la posición del personaje, de los objetos que caen y del tiempo
30 locate 0,10: print "Objective: Get to level 20, capture the objects, watch out for holes !":if inkey$="" then goto 30 else cls:x=100:y=144:ey=4:p=0:time=0:s=10-int(time/60):f=0:ev=0


1 'Inicio cambi0 de fase, solo pasaremos por esta línea si se ha llegado a 0 los objetos cogidos
40 ev=ev+1:if ev>2 then ev=0 else ec=em:locate 1,21:print "Points:"p"catch:"ec"level:"f:if f=0 then  for i=0 to 31:locate i,2:print chr$(215):locate i,20:print chr$(215):next:for i=0 to 20:locate 0,i: print chr$(215):locate 32, i: print chr$(215):next:play"l10o4g"

1' Main loop
1 'Sistema de input & physics & main loop, cambiamos el sprite si se mueve'
1 '50 tr= base(5)+((y/8)+1)*32+(x/8)+2:tl= base(5)+((y/8)+1)*32+(x/8):k=stick(0):if k=3 and vpeek(tr)<192 then x=x+8:sp=s0:swap s0,s1:else if k=7 and vpeek(tl)<192 then x=x-8:sp=s2:swap s2,s3
50 k=stick(0):if k=3 then x=x+8:sp=s0:swap s0,s1:else if k=7 then x=x-8:sp=s2:swap s2,s3
1 'Si el player se ha caido:'
1 '     hacemos un sonido'
1 '     Ponmeos una animación'
1 '     Volvemos a empezar (linea 30)
1 'Si no se ha caido:
1 '     Si hay una colision con el objeto que cae y el objeto está activo
1 '         Aumentamos la puntuación'
1 '         Disminuimos los que nos quedan por coger'
1 '         Reiniciamos el contador de tiempo'
1 '         Hacemos un sonido'
1 '         Mostramos la información actualizada'
1 '         Borramos el sprite colisionado'
60 if y>160 then play "l10o4gc":for i=0 to 100: color,,8:color,,13:next:goto 30 else if x<ex*8 + 8 and  x+8 > ex*8 and y<ey*8+8  and ea=1 then p=p+1:ec=ec-1: time=0:play "l10o8gc":ea=0:locate 1,21:print "Points:"p"catch:"ec"level:"f:locate ex,ey: print chr$(32)
1 'Vamos aumentando en la vauable enemigo coordenada y la  del paquete para que baje'
1 'Si la posición del objeto es mayor que 20 es que el objeto está en el suelo, entonces: 
1 '     1. Ponemos el paquete arriba y le cambiamos el sprite, le ponemos al objeto activado para que se dibuje
1 '     2. Mostramos al personaje de arriba en la nueva posición'
70 ey=ey+ev:if ey>20 then ex=rnd(1)*(30-2)+2:ey=4:es=rnd(1)*(215-192)+192:ea=1:putsprite 1,(ex*8,1),4,4:goto 50
1 'En cada pasada pintamos el tiempo'
1 'Pintamos al player
1 'Comprobamos el suelo, si el suelo no es el tile del suelo hacemos que caiga'
80 s=10-int(time/60):locate 1,22:print s:putsprite 0,(x,y),9,sp:if ea=1 then locate ex,ey-ev: print chr$(32):locate ex,ey:print chr$(es): t= base(5)+((y/8)+2)*32+(x/8)+1: if vpeek(t)<>215 then y=y+8 
1 'Si los segundos llegan a 0 empezamos (linea 30)'
1 'Si los segundo no llegan a 0'
1 '     Si la fase llega a 20 final'
1 '         Mostramos mensaje de ganador'
1 '     Si la fase llega al final / 0'
1 '         Si los que faltan por coger son 0 es que hay un cambio de fase/nivel'
1 '             Aumentamos la fase'
1 '             Vamos a la linea de cambio de fase (linea 40)'
1 '     Si la fase no llega al final '
1 '         Vamos al main loop (linea 50)'
90 if s<=0 then play "l10o4gc":goto 30 else if f=20 then cls: locate 0,10: print "Congratulations, you've reached the end of the game!" else if ec=0 then f=f+1:locate 1,21:print "Points:"p"catch:"ec"level:"f:goto 40 else goto 50
