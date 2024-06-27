declare name 		"PitchDoublerProto";
declare version 	"0.5";
declare author 		"Schmitty2005";
declare license 	"BSD";
declare copyright 	"(c)Schmitty 2024";

import("stdfaust.lib");

p1panpot(x) 	= sqrt(c)*x, sqrt(1-c)*x
			with {
				c=(nentry("[1]Pitch Up Pan[style:knob]",-20,-90,90,1)-90.0)/-180.0;
			};

p2panpot(y) 	= sqrt(d)*y, sqrt(1-d)*y
			with {
				d=(nentry("[1]IPitch Down Pan[style:knob]",20,-90,90,1)-90.0)/-180.0;
			};

pitch1 = hslider("Pitch Up", 0.5, 0, 12, 0.01);
pitch2 = hslider("Pitch Down", 0.5, 0, 12, 0.01) *-1;
window =  hslider("Window", 128, 0,2048, 16);
crossf =  hslider("CrossFade", 32, 0, 2048, 16);
process = _,_ : ef.transpose(window, crossf, pitch1), ef.transpose(window, crossf, pitch2): p1panpot, p2panpot : _,_,_,_:>_,_;
