declare name 		"VintageDelay";
declare version 	"0.5";
declare author 		"Schmitty2005";
declare license 	"BSD";
declare copyright 	"(c)Schmitty 2024";

import("stdfaust.lib");

sampleRate = ma.SR;

minMillSec = 1;
maxMillSec = 6000; // 30
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
            
lfoMod = hslider ("LFO Modulation", 6, 0, 12, 0.01);
delayMod = os.lf_triangle(lfoMod) * hslider("Modulation Amount", 1, 0, 1, 0.01);
delaymsec = hslider("Delay MilliSeconds", 20, 1, maxMillSec, 1) * oneMillSec; 
lowpassFreq = hslider("LowPass Filter Freq", 8000, 20, 20000, 100);
process = _,_ : de.sdelay(96000, 1024, delaymsec *  delayMod ),_:fi.lowpass(3, 8000),_* 1;

