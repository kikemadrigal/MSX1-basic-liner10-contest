10screen1,1,0:width32:definta-z:color1,15,9:keyoff:s$="1C18183C3E1838281C18183C3C1818143818183C7C181C143818183C3C181828":ts=&h3800:l=1:forc=0to32:vpokets+c,VAL("&h"+MID$(s$,l,2)):l=l+2:next
20 locate 8,10: print "Presione una tecla":if inkey$="" then goto 20 else cls:x=16:y=144:s(0)=0:sp=0:s0=0:s1=1:s2=2:s3=3:ex=31:ey=19:es=192:ev=1
30fori=0to31:locatei,0:printchr$(215):locatei,20:printchr$(215):next:fori=0to20:locate0,i:printchr$(215):locate32,i:printchr$(215):next:play"l10o4g":gosub40:goto50
40locate5,21:print"Speed:"ev"Ponits:"p:return
50k=stick(0):ifpj=0thenoldy=y:ifk=3thenx=x+8:sp=s0:swaps0,s1:elseifk=7thenx=x-8:sp=s2:swaps2,s3:elseifk=1andpj=0thenpj=1
60ifpj=1andy=oldy-24thenpj=2elseifpj=1theny=y-8elseifpj=2theny=y+8:ify=oldythenpj=0
70ifex<x/8andpc=0thenp=p+1:pc=1:play"l10o8gc":gosub40elsec=base(5)+((y/8)+1)*32+(x/8)+1:ifvpeek(c)>=192then:play"l10o1c":goto20:gosub40
80ex=ex-ev:ifex<0thenex=30:es=es+1:ec=ec+1:play"l10o4g":locate0,19:printchr$(32):pc=0:ifec=10thenev=ev+1:ec=0:bl$="":ifes>224thenes=192
90putsprite0,(x,y),9,sp:ob$=chr$(es):fori=0toev:ob$=ob$+chr$(32):next:locateex,ey:printob$:ifex=30thenfori=0toev:bl$=bl$+chr$(215):next:locate0,ey+1:printbl$
91goto50
