#include <OneWire.h>

// OneWire DS18S20, DS18B20, DS1822 Temperature Example
//
// http://www.pjrc.com/teensy/td_libs_OneWire.html
//
// The DallasTemperature library can do all this work for you!
// http://milesburton.com/Dallas_Temperature_Control_Library

OneWire  ds(10);  // on pin 10

void setup(void) {
  Serial.begin(9600);
}

void loop(void) {
 int i=0;
 int ds_status;
 byte scr_pad[8];
byte addr[8]= {0,0,0,0,0,0,0,0};

   ds.reset();
   delay(500);
 
 ds_status = ds.search(addr);
 if(ds_status){
   Serial.println("Device found");
   for( i = 0; i < 8; i++){ 
     Serial.print( addr[i], HEX);
     }
 
  ds.reset();
  ds.select(addr);
   ds.write(0x44);
   delay(2);
   ds.reset();
   ds.select(addr);
   
   Serial.println("");
   ds.write(0xBE); //Read Scratchpad
   for( i=0 ; i< 10; i++) 
     {
       scr_pad[i] = ds.read();
     }
     
   //print out  
   for( i=0 ; i< 10; i++) 
     {
      Serial.print(scr_pad[i], HEX);
     }  
   Serial.println("");  
   Serial.print("Temp LSB byte: "); Serial.print(float(scr_pad[0]), DEC);Serial.print(scr_pad[0], HEX);
   Serial.println("");
   Serial.print("Temp MSB byte: "); Serial.print(scr_pad[1], DEC);
   Serial.println("");
 }
 
 
 if(!ds_status) {
 Serial.println("Device not found");
 Serial.println(addr[0], HEX);
 Serial.print("ds_status: False = "); Serial.println(ds_status);
 delay(10000);
 }
 ds.reset();
 ds_status=0;
 
 delay(500);
 
 if(Serial.available()){Serial.println("Tavaraa tuubissa"); Serial.flush();}

}
