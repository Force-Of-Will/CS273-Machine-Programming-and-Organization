;;Benjamin Longwell
;;Lab5.S
;;Initializes and sts up / displays values on the arduino
  .data
  .size segment_table, 4
  .size portb_table, 10
  .size portd_table, 10
  
segment_table:  #binary for seting input on PORTB for segment select
    .byte 0b00000010, 0b00000100, 0b00001000, 0b00010000
    ;; 0, 1, 2,3 4, 5, 6 , 7, 8 , 9
portb_table:  # list of binary sequences for setting port B to be ORed with segment table ite
    .byte  0b00000001,1,0,0,0,0,0,1,0,0
portd_table: # list of binary sequences for setting port D.
    .byte  0b00000000,0b11100100,0b10010000,0b11000000,0b01100100,0b01001000,0b00001100,0b11100000,0, 0b01100000
segmentv: .byte 1


  
  .comm segment, 1 ;; the common name for segment
  .comm digit, 1 ;; the digit into our sequences
  .global segment, digit

  

# --------
  .text
  .global setup_ports
  .global select_segment
  .global display_segment



setup_ports:  ;; routine to set the ports into output mode
  LDI r16, 0b00011111
  LDI R17, 0b11111100
  OUT 0x04, r16 ;;PORT B
  out 0x0A, R17 
  ;; set PORT B
  ;; set PORT D
  
  ret ;; of setup_ports

select_segment:;;selects the segment to light up
  LDI R19, 0 
  OUT 0x05, R19
  OUT 0x0B, R19
  LDS R18, segment
  CPI R18, 0 ;;compare the values
  BREQ SEGZERO ;;branch to specific function
  CPI R18, 1
  BREQ SEGONE
  CPI R18, 2
  BREQ SEGTWO
  JMP SEGTHREE

SEGZERO: ;;make only the first segment light up
  LDI R19, 0b00000010
  OUT 0x05, R19
  ret;
SEGONE: ;;make only the second segment light up
  LDI R19, 0b00000100
  OUT 0x05, R19
  ret;
SEGTWO: ;;make only the third segment light up
  LDI R19, 0b00001000
  OUT 0x05, R19
  ret;
SEGTHREE: ;;make only the third segment light up
  LDI R19, 0b00010000
  OUT 0x05, R19
  ret;


display_segment:  ;;  main entry point for setting the segment
  LDS R20, digit;
  CPI R20, 0;
  BREQ LIGHT0
  CPI R20, 1;
  BREQ LIGHT1
  CPI R20, 2;
  BREQ LIGHT2
  CPI R20, 3;
  BREQ LIGHT3
  CPI R20, 4;
  BREQ LIGHT4
  CPI R20, 5;
  BREQ LIGHT5
  CPI R20, 6;
  BREQ LIGHT6
  CPI R20, 7
  BREQ LIGHT7
  CPI R20, 8;
  BREQ LIGHT8
  JMP LIGHT9
LIGHT0:;;lights up 0
 LDI R22, 0b00000001
 LDI R23, 0b00000001
 ADD R19, R23
 OUT 0x05, R19
 OUT 0x0B, R22
 ret;
LIGHT1:;;lights up 1
  LDI R22, 0b11100100
  LDI R23, 0b00000001
  ADD R19, R23
  OUT 0x05, R19
  OUT 0x0B, R22
  ret;
LIGHT2:;;lights up 2
  LDI R22, 0b10010011
  out 0x0B, R22
  ret
LIGHT3:;;lights up 3
  LDI R22, 0b11000000
  OUT 0x0b, R22
  ret
LIGHT4:;;lights up 4
  LDI R22, 0b01100100
  OUT 0x0b, R22
  ret
LIGHT5:;;loghts up 5
  LDI R22, 0b01001000
  OUT 0x0b, R22
  ret
LIGHT6:;;lights up 6
  LDI R22, 0b00001000
  OUT 0x0b, R22
  ret
LIGHT7:;;lights up 7
  LDI R22, 0b11100000
  LDI R23, 0b00000001
  ADD R19, R23
  OUT 0x05, R19
  OUT 0x0b, R22
  ret
LIGHT8:;;lights up 8
  LDI R22, 0b00000000
  OUT 0x0b, R22
  ret
LIGHT9:;;lights up 9
  LDI R22, 0b01100000
  OUT 0x0b, R22
  ret
   ;; the goal is the use "digit" to and "segment" to find the values that need
   ;; to be sent to PORTB and PORT D 


    ret ;; of display_segment
    
