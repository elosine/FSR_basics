(
//From Arduino Patch FSR_data
//An Example of parcing serial data from string
~kbs = {Bus.control(s)}!10;
~arduino = ArduinoSMS("/dev/tty.usbserial-AE015LGU", 115200);
)
(
~arduino.action = { |msg|
	var msgs, vals imin, imax;
	imin = 300.0;
	imax = 800.0;
	msgs = msg.asString.split($;);
	vals = Array.newClear(msgs.size);
	msgs.do{ |data|
		var datasplit;
		datasplit = data.split($:);
		if(datasplit[0]=="An0",{an0 = datasplit[1].asInteger});
		if(datasplit[0]=="An1",{an1 = datasplit[1].asInteger});
		if(datasplit[0]=="vl0",{vl0 = datasplit[1].asInteger; /*"vl0-".post; vl0.postln*/});
		if(datasplit[0]=="vl1",{vl1 = datasplit[1].asInteger; /*"vl1-".post; vl1.postln*/});
		if(datasplit[0]=="ac0",{ac0 = datasplit[1].asInteger; /*"ac0-".post; ac0.postln*/});
		if(datasplit[0]=="ac1",{ac1 = datasplit[1].asInteger; /*"ac1-".post; ac1.postln*/});
		if(datasplit[0]=="iv0",{iv0 = datasplit[1].asInteger; /*"iv0-".post; iv0.postln*/});
		if(datasplit[0]=="iv1",{iv1 = datasplit[1].asInteger; /*"iv1-".post; iv1.postln*/});

		~kbs[0].set(an0.linlin(300.0, 800.0, 1, 0.00001));
		~an1b.set(an1.linlin(0.0, 900.0, 100.0, 800.0));
		~vl0b.set(vl0);
		~vl1b.set(vl1);
		~ac0b.set(ac0);
		~ac1b.set(ac1);
		~iv0b.set(iv0);
		~iv1b.set(iv1);
	};

};
)

~arduino.close;

(
SynthDef(\siney, {
	Out.ar(0, SinOsc.ar(\freq.kr(300, 0.025))*\amp.kr(1.0, 0.025));
}).add;
)

a=Synth(\siney);

a.map(\amp, ~an0b, \freq, ~an1b );
a.free;

~an0b.getn
~an0b.get({arg value; a = value; ("after the server responds a is set to:" + a).postln;});
