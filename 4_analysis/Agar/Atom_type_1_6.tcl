package require topotools                                                                                                  
mol new "Graphene_Agar_water.psf" type psf                                                                                 
mol addfile 2500_2999.dcd type dcd first 0 last -1 step 1 waitfor -1                                   
pbc wrap -center com -centersel "fragment 0" -compound fragment -all                                                        
                                                                                                                           
set outfile [open "Atom_type_1_6.data" w]                                                                                      
set g [atomselect top "fragment 0 and name C3"]                                                                            
set g_serial [$g get serial]                                                                                               
set total [molinfo top get numframes]                                                                                           
puts $outfile "frame serial Poly"                                                                                           
                                                                                                                           
for {set i 0} {$i <= $total} {incr i} {      
	animate goto $i                    
	foreach serial $g_serial {                                                                                               
	                                                                                                                         
		set n_Poly    0                                                                                                       
		set n_H2O     0                                                                                                       
		set n_dH2O    0                                                                                                      
		                                                                                                                     
		set dis 3.5                                                                                                          
		                                                                                                                     
		set Poly_flag    0                                                                                                         
		set H2O_flag     0                                                                                                       
		set dH2O_flag    0                                                                                                   
		                                                                                                                     
		set g_atom [atomselect top "serial $serial"]                                                                                
		set y [$g_atom get y]                                                                                                  

		set Poly    [atomselect top "(within ${dis} of serial ${serial}) and (fragment 9537 to 9556)"]         		 

		set  n_Poly    [llength [$Poly    get serial]]

		if {${n_Poly}     > 0} {set Poly_flag    1}   
		
		puts $outfile "$i $serial $Poly_flag"  		
		$g_atom delete                                                                                                       
		$Poly    delete                                                                                                   

	}                                                                                                                        
}                                                                                                                          
$g delete                                                                                                                  
close $outfile                                                                                                             
# exit
