#version 3.7;

        
global_settings {
    assumed_gamma 1.0
    max_trace_level 100
    ambient_light rgb <1, 1, 1>
}

//Files with predefined colors and textures
#include "colors.inc"
                
#declare Target = <0, 0, 21.740>;
#declare Observer = <0, 0.002, 0>;
    
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
	finish { reflection { 1.0 } ambient 0.0 diffuse 0.0 }
	normal { bumps 0.1 turbulence 1 scale 0.0002 }
	}
}


// This is the MOUNTAIN!  
box {
	<1, 1, 1>, <0, 0, 0>
	
	pigment { image_map {
                jpeg "matheson.jpg"
	            map_type 0
	        }
        }
        
    translate Target + <-0.5, 0, 0>
    scale <20, 20 / 3, 1>
}


#declare SkyPigment = rgb <184 / 256, 205 / 256, 235 / 256>;
 
////////////////////////////////////////////////////////////

                                        
light_source { <0, 1, 0> color White parallel point_at Target }

camera {
    location Observer + <0, 0, -3>
    look_at Target
    up <0, 9, 0>
    right <16, 0, 0>
    angle 60
}
 
//Set a background color
background { color SkyPigment }
