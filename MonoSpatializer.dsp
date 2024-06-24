declare name 		"MonoSpatilizer";
declare version 	"0.5";
declare author 		"Schmitty2005";
declare license 	"BSD";
declare copyright 	"(c)Schmitty 2024";

import("stdfaust.lib");

sampleRate = ma.SR;
maxd = ma.SR / 1000 ;

drypanpot(x) 	= sqrt(c)*x, sqrt(1-c)*x
			with {
				c=(nentry("[1]Original Pan[style:knob]",-20,-90,90,1)-90.0)/-180.0;
			};

wetpanpot(y) 	= sqrt(d)*y, sqrt(1-d)*y
			with {
				d=(nentry("[1]Image Pan[style:knob]",20,-90,90,1)-90.0)/-180.0;
			};

delaysmp = hslider("Delay in Samples", 480, 0, 2000, 2); //needs conversion to milliSeconds
lowpassFreq = hslider("LowPass Filter Freq", 8000, 20, 20000, 100);

process		= _,_ :> _  <: _,_ : _, de.sdelay(maxd, 128, delaysmp): _, fi.lowpass6e(lowpassFreq):drypanpot, wetpanpot:_,_,_,_ :> _,_;
