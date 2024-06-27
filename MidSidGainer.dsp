declare name 		"MidSideGainer";
declare version 	"0.5";
declare author 		"Schmitty2005";
declare license 	"BSD";
declare copyright 	"(c)Schmitty 2024";

import("stdfaust.lib");

drypanpot(x) 	= sqrt(c)*x, sqrt(1-c)*x
			with {
				c=(nentry("[1]Original Pan[style:knob]",-20,-90,90,1)-90.0)/-180.0;
			};

wetpanpot(y) 	= sqrt(d)*y, sqrt(1-d)*y
			with {
				d=(nentry("[1]Image Pan[style:knob]",20,-90,90,1)-90.0)/-180.0;
			};
//@TODO Needs linear2db fix on gain knobs.
midgain = vslider("Mid Gain", 1, 1, 6, 0.1);
sidegain = hslider("Side Gain", 1,1, 6, 0.1);

splitToMidSide = (_,_ <: _,_,_,_ :(((_,_):> _ ) * midgain, ((_, _ * -1):>_) * sidegain));
sideToMid = _,_ <: _,_,_,_ :> ((_,_*-1):>_),((_,_):>_);

process = splitToMidSide : sideToMid;
