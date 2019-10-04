extern byte val;
extern byte width;
extern byte ascii;

extern "C" { 
  void decode_morse();
  void goaggies();
}

//
// function to read a 2-digit decimal value from user
//
byte read2DigitValue()
{
  byte inch; int val;
  Serial.println("Enter a 2-digit decimal value:");
  while (!Serial.available()) delay(100);
  inch = Serial.read();
  val = (inch - '0') * 10;
  while (!Serial.available()) delay(100);
  inch = Serial.read();
  val += (inch - '0');
  Serial.print("The value entered is ");
  Serial.println(val,DEC);
  return (byte) val;
}

void flashGoAggies() 
{
  Serial.println("Testing GoAggies...");
  int repeat = read2DigitValue();
  for(int i = 0; i < repeat; i++){
    goaggies();    
  }//end for
  // Add you code here
  Serial.println("Finished testing GoAggies..");
  // You will call the GoAggies() function from assembly file GoAggies.S
}

void decodeMorse(const String & string, char message[])
{
  // Write your code below.
  // string contains the input binary string separated by single spaces
  // message contains the decoded English characters and numbers    
  // You will call the assembly function decode_morse()
  int k = 0;
  int counter = 0;
  val = 0; //value save to function
  width = 0; //length of the parse
  Serial.println("decodeMorse(param1, param2) is being called...");
  for(int i = 0; i <= string.length(); i++){
    if(string[i] != ' ' && string[i]!= '\0'){ 
      width++;
      val = val*2+(string[i] - '0');
    }//end if
    else{
      Serial.println(val);
      Serial.println(width);
      decode_morse();
      Serial.println(ascii);
      message[k] = ascii;
      k++;
      val = 0;
      width = 0;
      counter++;
    }//end else
  }

  message[k] = '\0';  
}



void decodeMorse() 
{
  Serial.println("Input a Morse code string (separate the code for characters by a space):");

  while (!Serial.available()) delay(100);
  String string = Serial.readString();

  Serial.print("The Morse code string is: ");
  Serial.println(string);

  //String string = "01 "; // "01 1000";
  char message[100];

  decodeMorse(string, message);

  if(strlen(message) > 0) {
    Serial.print("The decoded message is: ");
    Serial.println(message);
  } else {
    Serial.print("Failure in decoding the input Morse code\n");
  }  
}

void setup() {
  //
  // Initialize serial communications
  //
  Serial.begin(9600);

  flashGoAggies();

  decodeMorse();
  
}

void loop() {
  // put your main code here, to run repeatedly:
  delay(20000); // 20,000 millisecs == 20 seconds
  Serial.println("*");
}
