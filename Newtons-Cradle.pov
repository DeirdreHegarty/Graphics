 #version 3.7;
 #include "colors.inc"    // The include files contain
 #include "stones.inc"    // pre-defined scene elements
 #include "textures.inc"  // pre-defined scene elements
 #include "shapes.inc"
 #include "glass.inc"
 #include "metals.inc"
 #include "woods.inc"
global_settings{ assumed_gamma 1.0 }

//************************** sky *************************
plane{<0,1,0>,1 hollow
    texture{ pigment{ bozo turbulence 0.92
                     color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.8]
                                 [0.50 rgb <0.20, 0.20, 1.0>*0.8]
                                 [0.70 rgb <1,1,1>]
                                 [0.85 rgb <0.25,0.25,0.25>]
                                 [1.0 rgb <0.5,0.5,0.5>]}
                    scale<1,1,1.5>*2.5  translate< 0,0,0>
                   }
            finish {ambient 1 diffuse 0} }
    scale 10000
}
background{
    ForestGreen
}


light_source { 
 <2, 4, -3> color White
}

camera {
  location <8, 0, -22>
  look_at  <8, 0, 0>
}

//****************** Kinetic Spheres ********************

// First kinetic sphere
#declare firstSphere = union{
    
    cylinder {
      <0, 0, 0>,    // Center of one end
      <0, 8, -2>,   // Center of other end
      .05           // Radius
      texture { Rusty_Iron scale 4 }
    }
    cylinder {
      <0, 0, 0>,    // Center of one end
      <0, 8, 2>,    // Center of other end
      .05           // Radius
      texture { Rusty_Iron scale 4 }
    }
    sphere {
      <0, 0, 0>, 2
      texture {
        Aluminum scale 4
      }
    }
}

#declare lastSphere = union{
    
    cylinder {
      <16, 0, 0>,   // Center of one end
      <16, 8, -2>,  // Center of other end
      .05           // Radius
      texture { Rusty_Iron scale 4 }
    }
    cylinder {
      <16, 0, 0>,   // Center of one end
      <16, 8, 2>,   // Center of other end
      .05           // Radius
      texture { Rusty_Iron scale 4 }
    }
    sphere {
      <16, 0, 0>, 2
      texture {
        Aluminum scale 4
      }
    }
}

union{
    //******* rendering spheres *********
    #declare i = 4;
    #while(i<16)
        sphere {
          <i, 0, 0>, 2
          texture {
            Aluminum scale 4
          }
        }
        #declare i = i + 4;
    #end

    //***** Wires for spheres**********
    #declare j = 4;
    #while(j<16)
        cylinder {
          <j, 0, 0>,    // Center of one end
          <j, 8, -2>,   // Center of other end
          .05           // Radius
          texture { Rusty_Iron scale 4 }
        }
        cylinder {
          <j, 0, 0>,    // Center of one end
          <j, 8, 2>,    // Center of other end
          .05           // Radius
          texture { Rusty_Iron scale 4 }
        }
        #declare j = j + 4;
    #end
}

//***************** Front bars *************************
// vertical bar on LHS
union{
    cylinder {
      <-2.5, -4, -2>,   // Center of one end
      <-2.5, 8, -2>,    // Center of other end
      .25               // Radius
      texture { Aluminum scale 4 }
    }
    sphere {
      <-2.5, 8, -2>, .25
      texture { Aluminum scale 4 }
    }

    // vertical bar on RHS
    cylinder {
      <18.5, -4, -2>,   // Center of one end
      <18.5, 8, -2>,    // Center of other end
      .25               // Radius
      texture { Aluminum scale 4 }
    }
    sphere {
      <18.5, 8, -2>, .25
      texture { Aluminum scale 4 }
    }

    // top bar
    cylinder {
      <-2.5, 8, -2>,    // Center of one end
      <18.5, 8, -2>,    // Center of other end
      .25               // Radius
      texture { Aluminum scale 4 }
    }
}
//******************* Back bars ************************
union{
    // vertical bar on LHS
    cylinder {
      <-2.5, -4, 2>,    // Center of one end
      <-2.5, 8, 2>,     // Center of other end
      .25               // Radius
      texture { Aluminum scale 4 }
    }
    sphere {
      <-2.5, 8, 2>, .25
      texture { Aluminum scale 4 }
    }

    // vertical bar on RHS
    cylinder {
      <18.5, -4, 2>,    // Center of one end
      <18.5, 8, 2>,     // Center of other end
      .25               // Radius
      texture { Aluminum scale 4 }
    }
    sphere {
      <18.5, 8, 2>, .25
      texture { Aluminum scale 4 }
    }

    // top bar
    cylinder {
      <-2.5, 8, 2>,     // Center of one end
      <18.5, 8, 2>,     // Center of other end
      .25               // Radius
      texture { Aluminum scale 4 }
    }
}

//******************* Bottom box *********************
box {
    < -3.5, -6, -2.5>, // Near lower left corner
    < 19.5, -4, 2.5>   // Far upper right corner
    texture {
      T_Wood4     
      scale 4       // Scale by the same amount in all
                    // directions
    }
}

//****************** Mak'em swing ********************

#declare Amplitude = 40 ;// in degrees  -  in Grad

object { firstSphere

 translate<0,-8,0>
 rotate< 0, 0, (Amplitude*sin(clock*2))*(Amplitude*sin(clock*2)<0)>
 translate -<0,-8,0>
}
object { lastSphere

 translate <-16,-8,0>
 rotate< 0, 0, (Amplitude*sin(clock*2))*(Amplitude*sin(clock*2)>0) >
 translate -<-16,-8,0>
}
