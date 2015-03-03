(
b = Buffer.read(s, "/Volumes/Ute/Freeze/204497__holadios__short-giggle.wav");
d = SoundFile.collectIntoBuffers("/Volumes/Ute/Freeze/grainEnv/" ++ "*");
e = Buffer.read(s, "/Volumes/Ute/Freeze/acjourney.aif");

SynthDef(\icy, {
	arg buf=0, envbuf = -1, pitchshift=1, winsz=0.8, overlaps=40, resettrig=0, startpos=0.0, endpos=1.0, rand=0.1, ratemin=2.0, ratemax=0.00001;
	var sig, ix, krate;
	krate = \rate.kr(1, 0.05).linlin(0.0, 1.0, ratemin, ratemax);
	ix = Phasor.kr(resettrig, ((1.0/ControlRate.ir)/(BufFrames.kr(buf)/SampleRate.ir))*krate, startpos, endpos);
	sig = Warp1.ar(1, buf, ix, pitchshift, winsz, envbuf, overlaps,rand);
	Out.ar(0, sig);
}).add;
)

x = Synth(\icy, [\buf, e, \winsz, 0.8, \overlaps, 33, \rand, 0.2])
x.set(\winsz, 0.8, \overlaps, 33, \startpos, 0, \endpos, 1, \pitchshift, 1, \envbuf, -1, \ratemin,1, \ratemax, 0.00001)
x.set(\envbuf, d[8]);

x.map(\rate, ~kbs[0]);
x.free;

