.include "m328Pdef.inc"
.def T=R22
.def mar=R23
.def E=R24
.org 0x0000
rjmp stack

stack:
	Ldi T, High(RAMEND)
	out SPH, T
	Ldi T, Low(RAMEND)
	out SPL, T

puertos:
	Ldi E,0xFF //Puerto B como salidas F=1111 1=salidas 0= entradas
	Out DDRB,E
	Ldi E, 0x0F //Puerto C como 4 entradas y 4 salidas
	out DDRC,E
	Ldi E, 0xFE //Puero D como D=11111110 ENTRADA
	out DDRD,E

	Ldi R26,0x00 // REFERENCIA SUMA LOCAL
	Ldi R25,0x10 //REFERENCIA QUE ES MAYOR A 0X0F

principal:
	Ldi mar,0X00
otra1:
    Ldi R26,0x00
	cp mar,R26
	BREQ N0
	inc R26
	cp mar,R26
	BREQ N1
	inc R26
	cp mar,R26
	BREQ N2
	inc R26
	cp mar,R26
	BREQ N3
	inc R26
	cp mar,R26
	BREQ N4
	inc R26
	cp mar,R26
	BREQ N5
	inc R26
	cp mar,R26
	BREQ N6
	inc R26
	cp mar,R26
	BREQ N7
	inc R26
	cp mar,R26
	BREQ N8
	inc R26
	cp mar,R26
	BREQ N9
	inc R26
	cp mar,R26
	BREQ NA
	inc R26
	cp mar,R26
	BREQ NB
	inc R26
	cp mar,R26
	BREQ NC
	inc R26
	cp mar,R26
	BREQ ND
	inc R26
	cp mar,R26
	BREQ NE
	inc R26
	cp mar,R26
	BREQ NF
	
otra:	
    out Portc,mar
	in T,pind
	add mar,T
	Rcall Tiempo_1seg
	cp mar,R25MA N
	BREQ principal
	Rjmp otra1

N0:
Ldi E, 0XC0
out portb, E
rjmp otra
N1: 
Ldi E, 0XF9
out portb, E
rjmp otra
N2: 
Ldi E, 0XA4
out portb, E
rjmp otra
N3: 
Ldi E, 0XB0
out portb, E
rjmp otra
N4: 
Ldi E, 0X99
out portb, E
rjmp otra
N5: 
Ldi E, 0X92
out portb, E
rjmp otra
N6: 
Ldi E, 0X82
out portb, E
rjmp otra
N7: 
Ldi E, 0XF8
out portb, E
rjmp otra
N8: 
Ldi E, 0X80
out portb, E
rjmp otra
N9: 
Ldi E, 0X90
out portb, E
rjmp otra
NA: 
Ldi E, 0X88
out portb, E
rjmp otra
NB:
Ldi E, 0X83
out portb, E
rjmp otra
NC:
Ldi E, 0XC6
out portb, E
rjmp otra
ND:
Ldi E, 0XA1
out portb, E
rjmp otra
NE: 
Ldi E, 0X86
out portb, E
rjmp otra
NF: 
Ldi E, 0X8E
out portb, E
rjmp otra

Tiempo_1seg:
		  ldi  R17, $09
WGLOOP0:  ldi  R18, $BC
WGLOOP1:  ldi  R19, $C4
WGLOOP2:  dec  R19
          brne WGLOOP2
          dec  R18
          brne WGLOOP1
          dec  R17
          brne WGLOOP0
	nop
	Ret
