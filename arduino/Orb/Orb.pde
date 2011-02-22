// Accepts a one char input from a serial connection
// G or R means green or red on, g or r means green or red off

int greenPin = 10;
int redPin = 12;

void setup() {
  Serial.begin(9600);
  pinMode(greenPin, OUTPUT);
  pinMode(redPin, OUTPUT);
}

void loop() {
  if (Serial.available() > 0) {
    char input = Serial.read();
    if (input == 'G') {
      digitalWrite(greenPin, HIGH);
      digitalWrite(redPin, LOW);
    } else {
      digitalWrite(greenPin, LOW);
      digitalWrite(redPin, HIGH);
    }
  }
  delay(1000);
}
