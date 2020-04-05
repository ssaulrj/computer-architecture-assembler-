.include "m328Pdef.inc"
.def refx=R20
.def ref0=R21
.def ref1=R22
.def ref2=R23
.def ref3=R24
.def E=R25
.org 0x0000
rjmp stack

stack:
	Ldi refx, High(RAMEND)
	out SPH, refx
	Ldi refx, Low(RAMEND)
	out SPL, refx

puertos:
	Ldi E,0xFF //Puerto B como salidas F=1111 1=salidas 0= entradas
	Out DDRB,E
	Ldi E, 0x00 //Puerto C como 6 salidas y 2 entradas
	out DDRD,E
	Ldi R26, 0x00
		
rjmp principal
//----------------------------------------00
N00:		Ldi E, 0b10000000
			Ldi R26, 0b00000001
			out portb, E
			Rcall Tiempo_1seg
			Rcall imprimir
imprimir:   cp E, R26
			BREQ N00
			lsr E
			out portb, E
			Rcall Tiempo_1seg
			Ldi ref1, 0x00
		    in ref2, pind
			add ref1, ref2
			cp ref1, ref0
			BREQ imprimir
			rjmp principal

//----------------------------------------01
N01:		Ldi E, 0b00000001
			Ldi R26, 0b10000000
			out portb, E
			Rcall Tiempo_1seg
			Rcall imprimir2
imprimir2:  cp E, R26
			BREQ N01
			lsl E
			out portb, E
			Rcall Tiempo_1seg
			Ldi ref0, 0x00
		    in ref2, pind
			add ref0, ref2
			cp ref0, ref1
			BREQ imprimir2
			rjmp principal

principal:
	Ldi ref0,0x00 // REFERENCIA A 00 IZQUIERDA A DERECHA
	Ldi ref1,0x01 //REFERENCIA A 01 DERECHA A IZQUIERDA
	Ldi ref2,0x02 //REFERENCIA A 10 DE LADOS AL CENTRO
	Ldi ref3,0x03 //REFERENCIA A 11 DEL CENTRO A LOS LADOS
    Ldi E, 0x00
    in R26, pind
	add E, R26 //E2 liberado 
	cp E,ref0  
	BREQ N00   //En 00
	cp E,ref1
	BREQ N01   //En 01
	cp E,ref2
	BREQ N10 //En 10
	cp E,ref3
	BREQ N11  //En 11 
	nop
	rjmp principal

//----------------------------------------10
N10:		Ldi E, 0b10000001
		//	Ldi R26, 0b00011000
			out portb, E
			Rcall Tiempo_1seg
		    rjmp xxx2
a:			Ldi E, 0b01000010
			out portb,E
			rcall Tiempo_1seg
			rjmp xxx3	
b:			Ldi E, 0b00100100
			out portb,E
			rcall Tiempo_1seg
			rjmp xxx4
c:			Ldi E, 0b00011000
			out portb,E
			rcall Tiempo_1seg
			rjmp N10 

xxx2:        Ldi ref0, 0x00
		    in ref1, pind
			add ref0, ref1
			cp ref0, ref2
			breq a
			rjmp principal
xxx3:        Ldi ref0, 0x00
		    in ref1, pind
			add ref0, ref1
			cp ref0, ref2
			breq b
			rjmp principal
xxx4:        Ldi ref0, 0x00
		    in ref1, pind
			add ref0, ref1
			cp ref0, ref2
			breq c
			rjmp principal

brincox:    rjmp principal
//----------------------------------------11
N11:		Ldi E, 0b00011000
			//Ldi R26, 0b10000001
			out portb, E
			Rcall Tiempo_1seg
			rjmp xx1 
d:			Ldi E, 0b00100100
			out portb,E
			rcall Tiempo_1seg
			rjmp xx2
ee:			Ldi E, 0b01000010
			out portb,E
			rcall Tiempo_1seg
			rjmp xx3
f:			Ldi E, 0b10000001
			out portb,E
			rcall Tiempo_1seg
			rjmp N11 

xx1: 	    Ldi ref0, 0x00
		    in ref1, pind
		    add ref0, ref1
		    cp ref0, ref3
		    breq d
		    rcall brincox
xx2: 	    Ldi ref0, 0x00
		    in ref1, pind
		    add ref0, ref1
		    cp ref0, ref3
		    breq ee
		    rcall brincox
xx3: 	    Ldi ref0, 0x00
		    in ref1, pind
		    add ref0, ref1
		    cp ref0, ref3
		    breq f
		    rcall brincox
//----------------------------------------END
Tiempo_1seg:
;    delay loop generator 
;     200000 cycles:
; ----------------------------- 
; delaying 199998 cycles:
          ldi  R17, $06
WGLOOP0:  ldi  R18, $37
WGLOOP1:  ldi  R19, $C9
WGLOOP2:  dec  R19
          brne WGLOOP2
          dec  R18
          brne WGLOOP1
          dec  R17
          brne WGLOOP0
; ----------------------------- 
; delaying 2 cycles:
          nop
          nop
	Ret


