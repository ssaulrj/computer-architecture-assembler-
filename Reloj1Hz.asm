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
	Ldi E,0xFF
	Out DDRB,E

principal:
	Ldi mar,0x00
	out Portb,mar
	Rcall Tiempo_1seg
	Ldi mar, 0b00000001
	out Portb,mar
	Rcall Tiempo_1seg
	rjmp Principal

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


