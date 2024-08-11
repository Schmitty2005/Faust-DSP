declare name 		"MonoSpatilizer";
declare version 	"0.6";
declare author 		"Schmitty2005";
declare license 	"BSD";
declare copyright 	"(c)Schmitty 2024";

import("stdfaust.lib");

sampleRate = ma.SR;

minMillSec = 1;
maxMillSec = 40; // 30
oneMillSec = sampleRate / 1000;

maxd = oneMillSec * maxMillSec  ;

drypanpot(x) 	= sqrt(c)*x, sqrt(1-c)*x
			with {
				c=(nentry("[1]Original Pan[style:knob]",-20,-90,90,1)-90.0)/-180.0;
			};

wetpanpot(y) 	= sqrt(d)*y, sqrt(1-d)*y
			with {
				d=(nentry("[1]Image Pan[style:knob]",20,-90,90,1)-90.0)/-180.0;
			};

delaymsec = hslider("Delay MilliSeconds", 20, 1, maxMillSec, 1); 
lowpassFreq = hslider("LowPass Filter Freq", 8000, 20, 20000, 100);

//Stero version may not work in Windows
//process		= _,_ :> _  <: _,_ : _, de.sdelay(maxd, 128, (delaymsec * oneMillSec)): _, fi.lowpass6e(lowpassFreq):drypanpot, wetpanpot:_,_,_,_ :> _,_;

//switched to mono input
process		= _  <: _,_ : _, de.sdelay(maxd, 128, (delaymsec * oneMillSec)): _, fi.lowpass6e(lowpassFreq):drypanpot, wetpanpot:_,_,_,_ :> _,_;


