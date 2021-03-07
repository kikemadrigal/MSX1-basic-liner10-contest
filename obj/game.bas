10color1,11,13:screen1,1,0:width32:definta-z:keyoff:ts=&h3800:l=1:es=192:ex=15:ey=7:ev=1:sp=0:s0=0:s1=1:s2=2:s3=3:r=em:em=2:f=0:putsprite1,(ex*8,1),4,4:ea=1
20s$="1C18183C3E1838281C18183C3C1818143818183C7C181C143818183C3C1818280000000018187EBD000000425A5A7E3C":forc=0to48:vpokets+c,VAL("&h"+MID$(s$,l,2)):l=l+2:next
30 locate 0,10: print "Objective: Get to level 20, to get poniter capture the objects before they hit the ground ":if inkey$="" then goto 30 else cls:x=100:y=144:ey=6:p=0:time=0:s=10-int(time/60)
40ifev>2thenev=1elser=em:locate1,21:print"Points:"p"catch:"r"level:"f:iff=0thenfori=0to31:locatei,2:printchr$(215):locatei,20:printchr$(215):next:fori=0to20:locate0,i:printchr$(215):locate32,i:printchr$(215):next:play"l10o4g"
50k=stick(0):ifk=3thenx=x+8:sp=s0:swaps0,s1:elseifk=7thenx=x-8:sp=s2:swaps2,s3
60ify>160thenplay"l10o4gc":fori=0to100:color,,8:f=0:ev=1:color,,13:next:goto30elseifx<ex*8+8andx+8>ex*8andy<ey*8+8and8+y>ey*8andea=1thenp=p+1:r=r-1:play"l10o8gc":ea=0:time=0:locate1,21:print"Points:"p"catch:"r"level:"f
70s=10-int(time/60):locate1,22:prints:ey=ey+ev:ifey>20thenex=rnd(1)*(30-2)+2:ey=6:es=es+1:ea=1:putsprite1,(ex*8,1),4,4:ifes>215thenes=192
80putsprite0,(x,y),9,sp:locateex,ey-ev:printchr$(32):ifea=1thenlocateex,ey:printchr$(es):t=base(5)+((y/8)+2)*32+(x/8)+1:ifvpeek(t)<>215theny=y+8
90 if f=20 then cls: locate 0,10: print "Congratulations, you've reached the end of the game" else if r=0 then f=f+1:ev=ev+1:locate 1,21:print "Points:"p"catch:"r"level:"f:goto 40 else goto 50
