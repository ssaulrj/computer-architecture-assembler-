.include "m328Pdef.inc"
.def ref1=R22
.def E=R23
.org 0x0000
rjmp stack

stack:
	Ldi ref1, High(RAMEND)
	out SPH, ref1
	Ldi ref1, Low(RAMEND)
	out SPL, ref1

Puertos:
	LDI E,0xFF
	out DDRB,E
	out DDRD,E

Principal:
	Rcall Inicializador
	Rcall Letrero
	Rcall Letrero2

pierde:
	Rjmp pierde

Inicializador:
	Ldi R20,0b00001111
	Rcall Control
	Ldi R20,0b00111100
	Rcall Control
	Ldi R20,0b00000001
	Rcall Control
	Ret


Letrero:
	Ldi R20,0x85
	Rcall Control
	Ldi R21, 'U'
	Rcall Fuera
	Ldi R21,'P'
	Rcall Fuera
	Ldi R21,'I'
	Rcall Fuera
	Ldi R21,'I'
	Rcall Fuera
	Ldi R21,'T'
	Rcall Fuera
	Ldi R21,'A'g
	Rcall Fuera
  Ret

Letrero2:
	Ldi R20,0xC0
	Rcall Control
	
	Ldi R21, 0b11110101
	Rcall Fuera
	Ldi R21,' '
	Rcall Fuera
	Ldi R21,' '
	Rcall Fuera
	Ldi R21,'P'
	Rcall Fuera
	Ldi R21,'A'
	Rcall Fuera
	Ldi R21,'T'
	Rcall Fuera
	Ldi R21,'Y'
	Rcall Fuera
	Ldi R21,' '
	Rcall Fuera
	Ldi R21,'Y'
	Rcall Fuera
	Ldi R21,' '
	Rcall Fuera
	Ldi R21,'S'
	Rcall Fuera
	Ldi R21,'A'
	Rcall Fuera
	Ldi R21,'U'
	Rcall Fuera
	Ldi R21,'L'
	Rcall Fuera
  Ret

Control:
	out Portb,R20
	Rcall Pausa_10ms
	Ldi E,0b00000000
	out Portd,E
	Rcall Pausa_10ms
	SBI Portd,5      //E=1, RS=0
	nop
	Rcall Pausa_10ms
	CBI Portd,5      //E=0, RS=0
	Rcall Pausa_10ms
	Ret


Fuera:
	out Portb,R21

	Rcall Pausa_10ms
	Ldi E,0b00000000
	out Portd,E
	Rcall Pausa_10ms
	SBI Portd,4        //RS=1
	nop
	SBI Portd,5        //E=1
	nop
	Rcall Pausa_10ms
	CBI Portd,5        //E=0
	Rcall Pausa_10ms
	Ldi E,0b00000000
	out Portd,E
	//CBI Portd,4
  Ret


Pausa_10ms:
;    delay loop generator 
;     1000 cycles:
; ----------------------------- 
; delaying 999 cycles:
          ldi  R17, $03
WGLOOP0:  ldi  R18, $6E
WGLOOP1:  dec  R18
          brne WGLOOP1
          dec  R17
          brne WGLOOP0
; ----------------------------- 
; delaying 1 cycle:
          nop
Ret
