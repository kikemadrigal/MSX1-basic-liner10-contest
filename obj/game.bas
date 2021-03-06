10color1,11,8:screen1,1,0:width32:definta-z:keyoff:ts=&h3800:l=1:es=192:ey=190:sp=0:s0=0:s1=1:s2=2:s3=3:v=5
20s$="1C18183C3E1838281C18183C3C1818143818183C7C181C143818183C3C1818280000000018187EBD000000425A5A7E3C":forc=0to48:vpokets+c,VAL("&h"+MID$(s$,l,2)):l=l+2:next
30 locate 0,10: print "Grab the objects before they hit the ground":if inkey$="" then goto 30 else cls:x=100:y=144:p=0:ey=190
40fori=0to31:locatei,4:printchr$(215):locatei,20:printchr$(215):next:fori=0to20:locate0,i:printchr$(215):locate32,i:printchr$(215):next:play"l10o4g"
50k=stick(0):ifk=3thenx=x+8:sp=s0:swaps0,s1:elseifk=7thenx=x-8:sp=s2:swaps2,s3
60ify>160thenplay"l10o4gc":goto30elseifx<ex*8+8andx+8>ex*8andy<ey*8+8and8+y>ey*8thenp=p+1:play"l10o8gc":ea=0:locate5,21:print"Points:"p
70ey=ey+ev:ifey>(y/8)+2thenex=rnd(1)*(30-2)+2:ey=6:es=es+1:ev=1:ec=0:ea=1:putsprite1,(ex*8,2*8),13,4:ifes>215thenes=192
80locateex,ey-1:printchr$(32):ifea=1thenlocateex,ey:printchr$(es):t=base(5)+((y/8)+2)*32+(x/8)+1:ifvpeek(t)<>215theny=y+8
90putsprite0,(x,y),9,sp:goto50
