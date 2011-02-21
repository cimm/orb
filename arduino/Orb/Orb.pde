// Accepts a one char input from a serial connection
// G or R means green or red on, g or r means green or red off

int ledPin = 13;

void setup() {
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);     
}

void loop() {
  if (Serial.available() > 0) {
    char value = Serial.read();
    if (value == 'G') {
      digitalWrite(ledPin, HIGH); 
    } else {
      digitalWrite(ledPin, LOW); 
    }
     Serial.println(value);
  }
  delay(1000);
}
