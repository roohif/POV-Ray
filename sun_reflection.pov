#version 3.7;

        
global_settings {
    assumed_gamma 1.0
    max_trace_level 100
    ambient_light rgb <1, 1, 0.6>
}

//Files with predefined colors and textures
#include "colors.inc"

#local sun_angle = 5;
#local sun_distance = 200;

#local sun_height = sun_distance * tan(radians(sun_angle));
#local sun_radius = sun_distance * tan(0.01); // approx half a degree in radians

#declare Target = <0, sun_height, sun_distance>;
#declare Observer = <0, 0.020, 0>;
     
sky_sphere {

	pigment { wood color_map { // sun sky
		[0.05 color rgb <1.0, 1.0, 0.75> * 5] // this index is size of sun
		[0.055 color rgb <1,1,.9>] // this one starts the fade out edge of sun
		[0.15 color rgb <.8,.9,1>]
		[0.25 color rgb <.6,.7,.9>]
		[1.00 color rgb <.3,.6,.9>]
	} rotate <-sun_angle, 0, 0> } // places sun (raise or lower x for altitude, y for left/right)

	pigment {gradient y color_map { // horizon sky
		[-0.1 color rgbf <0.6, 0.6, 0.8, 0.1>]
		[0.05 color rgbf <0.6, 0.6, 0.80, 0.1>] // this index is size of sun
		[0.15 color rgbf <0.5, 0.7, 1.0, 0.33>]
		[0.25 color rgbf <.6,.7,.9,.5>]
		[1.00 color rgbf <.3,.6,.7,1>]
	} rotate <0.5, 0, 0> } // Rotates it so we still have light BELOW eye level
}     
     
light_source {
	<0, sun_distance * tan(radians(sun_angle)), sun_distance> color 1
}

                
#declare FlatEarth = plane {
	y, 0
}

# declare GlobeEarth = sphere {
	<0, 0, 0>, 6371
	translate <0, -6371, 0>
}	

object { GlobeEarth 
	texture {
		pigment { color Blue }
	finish { reflection { 0.8 } ambient 0.0 diffuse 0.0 }
	normal { bumps 0.1 turbulence 1 scale 0.002 }
	}
}


#declare SkyPigment = rgb <0.3, 0.6, 0.9>;
 
////////////////////////////////////////////////////////////

                                        
camera {
    location Observer + <0, 0, 0>
    look_at Target * <1, 0, 1>
    up <0, 9, 0>
    right <16, 0, 0>
    angle 60
}
 
//Set a background color
background { color SkyPigment }
