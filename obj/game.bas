10color1,11,13:screen1,1,0:width32:definta-z:keyoff:ts=&h3800:l=1:sp=0:s0=0:s1=1:s2=2:s3=3:ex=15:ey=4:es=192:ev=0:ec=em:em=2:ea=1:f=0
20s$="1C18183C3E1838281C18183C3C1818143818183C7C181C143818183C3C1818280000000018187EBD000000425A5A7E3C":forc=0to48:vpokets+c,VAL("&h"+MID$(s$,l,2)):l=l+2:next:putsprite1,(ex*8,1),4,4
30 locate 0,10: print "Objective: Get to level 20, capture the objects, watch out for holes ":if inkey$="" then goto 30 else cls:x=100:y=144:ey=4:p=0:time=0:s=10-int(time/60):f=0:ev=0
40ev=ev+1:ifev>2thenev=0elseec=em:locate1,21:print"Points:"p"catch:"ec"level:"f:iff=0thenfori=0to31:locatei,2:printchr$(215):locatei,20:printchr$(215):next:fori=0to20:locate0,i:printchr$(215):locate32,i:printchr$(215):next:play"l10o4g"
50k=stick(0):ifk=3thenx=x+8:sp=s0:swaps0,s1:elseifk=7thenx=x-8:sp=s2:swaps2,s3
60ify>160thenplay"l10o4gc":fori=0to100:color,,8:color,,13:next:goto30elseifx<ex*8+8andx+8>ex*8andy<ey*8+8andea=1thenp=p+1:ec=ec-1:time=0:play"l10o8gc":ea=0:locate1,21:print"Points:"p"catch:"ec"level:"f:locateex,ey:printchr$(32)
70ey=ey+ev:ifey>20thenex=rnd(1)*(30-2)+2:ey=4:es=rnd(1)*(215-192)+192:ea=1:putsprite1,(ex*8,1),4,4:goto50
80s=10-int(time/60):locate1,22:prints:putsprite0,(x,y),9,sp:ifea=1thenlocateex,ey-ev:printchr$(32):locateex,ey:printchr$(es):t=base(5)+((y/8)+2)*32+(x/8)+1:ifvpeek(t)<>215theny=y+8
90 if s<=0 then play "l10o4gc":goto 30 else if f=20 then cls: locate 0,10: print "Congratulations, you've reached the end of the game" else if ec=0 then f=f+1:locate 1,21:print "Points:"p"catch:"ec"level:"f:goto 40 else goto 50
