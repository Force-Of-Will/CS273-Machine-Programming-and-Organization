;;Benjamin Longwell
;;CS273 Lab3
;;FatMonitor.S
;;given input from lab3.ino (c program), determines whether someone is under, helahty or overweight

.extern delay
.data ;;variables, global marked my global keyword
.comm val, 1
.comm fat, 1
.global fat
.comm gender, 1
.global gender
.comm age, 1
.global age

.text
.global lightup

lightup: 
  ldi R18, 0b00110001
  ;;default setting val to binary 0
  LDS R18,0b00000000
  STS val, R18
  ;;storing values
  LDS R19, age
  LDS R20, gender
  LDS R21, fat
  LDI R25, 255

  CPI R20, 1 ;;1 is female, all other numbers are male
  BRNE male
  JMP female

male:
  ;;compare age to go and determine the healthiness of the person
  CPI R19, 20
  BRLT lt20m
  JMP twentyToFortyMale

twentyToFortyMale: ;;compares whether age is 20 to 40
  CPI R19, 40
  BRLT twentyToFortyFatCompare ;;generate method (20-40 fat compare)
  JMP fortyToSixtyMale

fortyToSixtyMale:
  CPI R19, 60
  BRLT fortyToSixtyFatCompare ;;generate method (40-60 fat compare)
  JMP sixtyToEightyMale

sixtyToEightyMale:
  CPI R19, 80
  BRLT sixtyToEightyFatCompare ;;generate method (60 - 80 fat compare)

lt20m: ;;(less than 20 year old male, does nothing, no lights)
  LDI R18, 0b00000000
  STS val, R18

twentyToFortyFatCompare: ;;TODO (low is <8, normal: 8-19, High 20-24, very high >=25)
  CPI R21, 8 ;;compare with low
  BRGE m8 ;;branch if value is greater than low
  jmp setLowLightOn ;;this is less than 8, go to setLowLightOn
 
m8: 
  CPI R21, 20 ;;compare with high low bound
  BRGE m20 ;;branch if value fits in high or vHigh bound
  jmp setNormLightOn ;;this is a normal weight
m20:  
  CPI R21, 25 ;;compare with vHigh >=
  BRGE m25 ;;branch ifvalue fits in vHigh bound
  JMP setHighLightOn ;;this is a High weight
m25:
  JMP setVHighLightOn ;;this is a very high weight: all other weights
  

fortyToSixtyFatCompare: ;;TODO (low is <11, normal: 11-21, High 22-27, very high >=28)
  CPI R21, 11 ;;compare with low
  BRGE m81 ;;branch if value is greater than low
  jmp setLowLightOn ;;this is less than 11, go to setLowLightOn
 
m81: 
  CPI R21, 22 ;;compare with high low bound
  BRGE m201 ;;branch if value fits in high or vHigh bound
  jmp setNormLightOn ;;this is a normal weight
m201:  
  CPI R21, 28 ;;compare with vHigh >=
  BRGE m251 ;;branch ifvalue fits in vHigh bound
  JMP setHighLightOn ;;this is a High weight
m251:
  JMP setVHighLightOn ;;this is a very high weight: all other weights

sixtyToEightyFatCompare: ;;TODO (low is <13, normal: 13-24, High 25-29, very high >=30)
  CPI R21, 13 ;;compare with low
  BRGE m82 ;;branch if value is greater than low
  jmp setLowLightOn ;;this is less than 8, go to setLowLightOn
 
m82: 
  CPI R21, 25 ;;compare with high low bound
  BRGE m202 ;;branch if value fits in high or vHigh bound
  jmp setNormLightOn ;;this is a normal weight
m202:  
  CPI R21, 30 ;;compare with vHigh >=
  BRGE m252 ;;branch ifvalue fits in vHigh bound
  JMP setHighLightOn ;;this is a High weight
m252:
  JMP setVHighLightOn ;;this is a very high weight: all other weights

;;FEMALE IMPLEMENTATION
female:
  ;;compare age to go and determine the healthiness of the person
  CPI R19, 20
  BRLT lt20f
  JMP twentyToFortyFemale

twentyToFortyFemale: ;;compares whether age is 20 to 40
  CPI R19, 40
  BRLT twentyToFortyFatComparef ;;generate method (20-40 fat compare)
  JMP fortyToSixtyFemale

fortyToSixtyFemale:
  CPI R19, 60
  BRLT fortyToSixtyFatComparef ;;generate method (40-60 fat compare)
  JMP sixtyToEightyFemale

sixtyToEightyFemale:
  CPI R19, 80
  BRLT sixtyToEightyFatComparef ;;generate method (60 - 80 fat compare)

lt20f: ;;(less than 20 year old male, does nothing, no lights)
  LDI R18, 0b00000000
  STS val, R18

twentyToFortyFatComparef: ;;(low <21, normal [21,33), High [33, 39), vHigh >=39)
  CPI R21, 21 ;;compare with low
  BRGE f2 ;;branch if value is greater than low
  jmp setLowLightOn ;;this is less than 21, go to setLowLightOn
f2: 
  CPI R21, 33 ;;compare with high low bound
  BRGE f33 ;;branch if value fits in high or vHigh bound
  jmp setNormLightOn ;;this is a normal weight
f33:  
  CPI R21, 39 ;;compare with vHigh >=
  BRGE f39 ;;branch ifvalue fits in vHigh bound
  JMP setHighLightOn ;;this is a High weight
f39:
  JMP setVHighLightOn ;;this is a very high weight: all other weights


fortyToSixtyFatComparef: ;;TODO (low is <23, normal: 23-34, High 34-40), very high >=40)
  CPI R21, 23 ;;compare with low
  BRGE f21 ;;branch if value is greater than low
  jmp setLowLightOn ;;this is less than 23, go to setLowLightOn
f21: 
  CPI R21, 34 ;;compare with high low bound
  BRGE f331 ;;branch if value fits in high or vHigh bound
  jmp setNormLightOn ;;this is a normal weight
f331:  
  CPI R21, 40 ;;compare with vHigh >=
  BRGE f391 ;;branch ifvalue fits in vHigh bound
  JMP setHighLightOn ;;this is a High weight
f391:
  JMP setVHighLightOn ;;this is a very high weight: all other weights

sixtyToEightyFatComparef: ;;TODO (low is <24, normal: 24-36), High 36-42), very high >=42)
  CPI R21, 24 ;;compare with low
  BRGE f22 ;;branch if value is greater than low
  jmp setLowLightOn ;;this is less than 22, go to setLowLightOn
f22: 
  CPI R21, 36 ;;compare with high low bound
  BRGE f332 ;;branch if value fits in high or vHigh bound
  jmp setNormLightOn ;;this is a normal weight
f332:  
  CPI R21, 42 ;;compare with vHigh >=
  BRGE f392 ;;branch ifvalue fits in vHigh bound
  JMP setHighLightOn ;;this is a High weight
f392:
  JMP setVHighLightOn ;;this is a very high weight: all other weights 

;;SETTING THE LIGHTS
setLowLightOn: ;; lights up yellow light (blinks)
  ldi    r17, 0b00100000
  out 0x04, r17
  out 0x05, r17
  call delay

  ldi r16, 0
  out 0x05, r16
  call delay
  dec r25
  CPI r25, 0
  brne setLowLightOn
  ret
  
setNormLightOn: ;; lights up green light (blinks)
  ldi    r17, 0b00010000
  out 0x04, r17
  out 0x05, r17
  call delay

  ldi r16, 0
  out 0x05, r16
  call delay
  dec r25
  CPI r25, 0
  brne setNormLightOn
  ret
  
setHighLightOn: ;;lights up Red light (blinks)
  ldi    r17, 0b00000001
  out 0x04, r17
  out 0x05, r17
  call delay

  ldi r16, 0
  out 0x05, r16
  call delay
  dec r25
  CPI r25, 0
  brne setHighLightOn
  ret
  
setVHighLightOn: ;;lights up ALL LIGHTS (no Blink)
  ldi r18, 0b00110001
  out 0x05, r18
  ret

;;F:  (0x01)  42: (0x2a)  32: (0x20) lights up green light
;;M:  (0x02)  25: (0x19)  48: (0x30) lights up all lights
;;F:  (0x01)  30: (0x1E)  21: (0x15) lights up green light
;;M:  (0x02)  23: (0x17)  17: (0x11) Lights up green light
