.extern delay

.text

.global goaggies

goaggies:    
  ldi R17, 0x20
  out 0x04, R17
 
  call G
  call O
  call A
  call G
  call G
  call I
  call E
  call S
  ret ;; of go aggies

G:
  call LONG
  call LONG
  call SHORT
  ret ;;of the letter g
O:   
  call LONG ;; Generate the O
  call LONG
  call LONG
  ret ;; of the letter O

A:
  call SHORT
  call LONG
  ret ;; of the letter a

I:
  call SHORT
  call SHORT
  ret ;;of the letter i
E:
  call SHORT
  ret ;;of the letter e
S:
  call SHORT
  call SHORT
  call SHORT
  ret ;;of the letter S

LONG:   
  call ON
  call WAIT
  call WAIT
  call OFF
  call WAIT
  ret ;; of routine LONG
  
SHORT:
  call ON
  call WAIT
  call OFF
  call WAIT
  ret ;; of routine SHORT
  
WAIT:   
  ldi r22, 0xa0
  ldi r23, 0x00
  ldi r24, 0x00
  ldi r25, 0x00
  call delay
  ret
  

ON:
  ldi R17, 0x20
  out 0x05, R17
  ret
  
OFF:
  ldi R17, 0x00
  out 0x05, R17
  ret
