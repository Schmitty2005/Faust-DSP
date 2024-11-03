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
				d=(nentry("[1]Pitch Down Pan[style:knob]",20,-90,90,1)-90.0)/-180.0;
			};
        
 p3panpot(z) 	= sqrt(e)*z, sqrt(1-e)*z
			with {
				e=(nentry("[1]Dry Pan[style:knob]",20,-90,90,1)-90.0)/-180.0;
			};
//@TODO Adding Delay will reduce beats in transposed signal
//@TODO Add Dry  / Wet Mix knob!
//@TODO Permanently set Window and Crossfade

modlfo = os.lf_saw(0.25);
modflo = modflow * 0.4; // 0.00 to 0.40
modlfoneg = modlfo * -1;      

pitch1 = hslider("Cents", 0.2, 0, 10, 1);
pitch2 = pitch1 * -1;
//pitch1 = hslider("Pitch Up", 0.2, 0, 12, 0.01);
//pitch2 = hslider("Pitch Down", 0.2, 0, 12, 0.01) *-1;
window =  hslider("Window", 128, 0,2048, 16);
crossf =  hslider("CrossFade", 32, 0, 2048, 16);

process  = _,_ : (_<:_,_), _: _,_,_ : ef.transpose(window, crossf, (pitch1 *0.0100)), ef.transpose(window, crossf, (pitch2*0.0100 )), _ : p1panpot, p2panpot, p3panpot : _,_,_,_,_,_ :> _,_;


//process  = _,_ : (_<:_,_), _: _,_,_ : ef.transpose(window, crossf, (pitch1 + modlfo)), ef.transpose(window, crossf, (pitch2 + modlfo)), _ : p1panpot, p2panpot, p3panpot : _,_,_,_,_,_ :> _,_;

//process  = _,_ : (_<:_,_), _: _,_,_ : ef.transpose(window, crossf, pitch1*modlfo), ef.transpose(window, crossf, pitch2*modlfoneg), _ : p1panpot, p2panpot, p3panpot : _,_,_,_,_,_ :> _,_;
////process = _,_ : ef.transpose(window, crossf, pitch1), ef.transpose(window, crossf, pitch2): p1panpot, p2panpot : _,_,_,_:>_,_;

/*
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
				d=(nentry("[1]Pitch Down Pan[style:knob]",20,-90,90,1)-90.0)/-180.0;
			};
        
 p3panpot(z) 	= sqrt(e)*z, sqrt(1-e)*z
			with {
				e=(nentry("[1]Dry Pan[style:knob]",20,-90,90,1)-90.0)/-180.0;
			};


modlfo = 1 ;//os.lf_saw(0.0025);
//modflo = modflow * 0.1; // 0.00 to 0.40
//modlfoneg = modlfo * -1;      

pitch1 = hslider("Cents", 0.2, 0, 10, 1);
pitch2 = pitch1 * -1;
//pitch1 = hslider("Pitch Up", 0.2, 0, 12, 0.01);
//pitch2 = hslider("Pitch Down", 0.2, 0, 12, 0.01) *-1;
window =  hslider("Window", 128, 0,2048, 16);
crossf =  hslider("CrossFade", 32, 0, 2048, 16);
//

process  = _,_ : (_<:_,_), _: _,_,_ : ef.transpose(window, crossf, (pitch1 *0.0100)), ef.transpose(window, crossf, (pitch2*0.0100 )), _ : p1panpot, p2panpot, p3panpot : _,_,_,_,_,_ :> _,_;

//process  = _,_ : (_<:_,_), _: _,_,_ : ef.transpose(window, crossf, (pitch1 + modlfo)), ef.transpose(window, crossf, (pitch2 + modlfo)), _ : p1panpot, p2panpot, p3panpot : _,_,_,_,_,_ :> _,_;

//process  = _,_ : (_<:_,_), _: _,_,_ : ef.transpose(window, crossf, pitch1*modlfo), ef.transpose(window, crossf, pitch2*modlfoneg), _ : p1panpot, p2panpot, p3panpot : _,_,_,_,_,_ :> _,_;
////process = _,_ : ef.transpose(window, crossf, pitch1), ef.transpose(window, crossf, pitch2): p1panpot, p2panpot : _,_,_,_:>_,_;


*/
