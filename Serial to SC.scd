s.boot;
(
//From Arduino Patch FSR_data
//An Example of parcing serial data from string
~kbs = {Bus.control(s)}!10;
~ino = ArduinoSMS("/dev/tty.usbserial-AE015LGU", 115200);
SynthDef(\siney, {Out.ar(0, SinOsc.ar(\freq.kr(0, 0.05).linexp(0.0,1.0,200,2500))*\amp.kr(1.0, 0.002))}).add;
~pro = NetAddr("127.0.0.1", 12321);
)
(
~ino.action = { |msg|
	var msgs, vals, imin, imax;
	imin = 300.0;
	imax = 800.0;
	msgs = msg.asString.split($;);
	vals = 0.0!msgs.size;
	msgs.do{ |data ix|
		var datasplit;
		datasplit = data.split($:);
		if(datasplit[0]=="An0",{
			vals[0] = datasplit[1].asInteger;
			~pro.sendMsg( "/fsr", 0, vals[0].linlin(imin, imax, 0.0, 1.0) )
		});
		if(datasplit[0]=="An1",{vals[1] = datasplit[1].asInteger});
		if(datasplit[0]=="vl0",{vals[2] = datasplit[1].asInteger});
		if(datasplit[0]=="vl1",{vals[3] = datasplit[1].asInteger});
		if(datasplit[0]=="ac0",{vals[4] = datasplit[1].asInteger});
		if(datasplit[0]=="ac1",{vals[5] = datasplit[1].asInteger});
		if(datasplit[0]=="iv0",{vals[6] = datasplit[1].asInteger});
		if(datasplit[0]=="iv1",{vals[7] = datasplit[1].asInteger});

		vals.do{|it ix|
			~kbs[ix].set(it.linlin(imin, imax, 0.0, 1.0).asFloat);
		};
	}
}
)

(
a=Synth(\siney);
a.map(\freq, ~kbs[0] );
)
a.free;
~ino.close;
