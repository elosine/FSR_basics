//An Example of parcing serial data from string

//create a control bus to store serial data
~an0b = Bus.control(s);

SerialPort.devices; //Get list of Serial devices

~arduino = ArduinoSMS("/dev/tty.usbserial-A100eFB5", 115200); //create a reader for your arduino, get the exact name from the listing above

//A function to run and parce the incomming string
//This function runs each time a message from the serial port is received
(
~arduino.action = { |msg|
	var msgs, an0=0;
	//We are taking the message in as a string and parcing it
	msgs = msg.asString.split($;);//split data set by the semi-colon and make a string for each message
	//msgs.postln;
	msgs.do{ |data|
		var datasplit;
		datasplit = data.split($:); //split the string into label and data by the colon delimiter
		//datasplit.postln;
		if(datasplit[0]=="An0",{an0 = datasplit[1].asInteger; /*"an0-".post; an0.postln*/}); //use if statement to find a particular label
		~an0b.set(an0.linlin(0.0, 900.0, 0.0, 1.0)); //set the control bus with the incomming data
	};
};
)

//Test synth
(
SynthDef(\siney, {
	Out.ar(0, SinOsc.ar(\freq.kr(300, 0.025))*\amp.kr(1.0, 0.025));
}).add;
)

a=Synth(\siney);

//map argument to the control bus that holds the incomming serial data from arduino
a.map(\freq, ~an0b );
a.free;
