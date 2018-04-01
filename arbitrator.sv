
module arbitrator(AHBIF.AHBMa am0,AHBIF.AHBSa as0,
    AHBIF.AHBMa am1,AHBIF.AHBSa as1,
    AHBIF.AHBMa am2,AHBIF.AHBSa as2,
    AHBIF.AHBMa am3,AHBIF.AHBSa as3,
    AHBIF.AHBMa am4,AHBIF.AHBSa as4,
    AHBIF.AHBMa am5,AHBIF.AHBSa as5,
    AHBIF.AHBMa am6,AHBIF.AHBSa as6,
    AHBIF.AHBMa am7,AHBIF.AHBSa as7,
    AHBIF.AHBMa amtb,AHBIF.AHBSa astb);


logic [7:0] grandSet;

always @(posedge amtb.HCLK)
begin

end


always @(*)
begin
			

			
			
			


grandSet = {am7.mHGRANT,am6.mHGRANT,am5.mHGRANT,am4.mHGRANT,am3.mHGRANT,am2.mHGRANT,am1.mHGRANT,am0.mHGRANT};

case(1'b1)
grandSet[0]:begin
	am0.mHRDATA   = astb.HRDATA;
	//as1.HRDATA=astb.mHRDATA;
	//as1.HWDATA=astb.mHWDATA;
	//as1.HWIRTE=astb.mHWIRTE;
	amtb.mHRDATA = as0.HRDATA;
	astb.HADDR = am0.mHADDR;
	astb.HWRITE = am0.mHWRITE;
	astb.HSEL = 1;
	astb.HWDATA = am0.mHWDATA;
	astb.HTRANS = am0.mHTRANS;
	end

grandSet[1]:begin
	am1.mHRDATA   = astb.HRDATA;
	//as1.HRDATA=astb.mHRDATA;
	//as1.HWDATA=astb.mHWDATA;
	//as1.HWIRTE=astb.mHWIRTE;
	amtb.mHRDATA = as1.HRDATA;
	astb.HADDR = am1.mHADDR;
	astb.HWRITE = am1.mHWRITE;
	astb.HSEL = 1;
	astb.HWDATA = am1.mHWDATA;
	astb.HTRANS = am1.mHTRANS;	
	end

grandSet[2]:begin
	am2.mHRDATA   = astb.HRDATA;
	//as1.HRDATA=astb.mHRDATA;
	//as1.HWDATA=astb.mHWDATA;
	//as1.HWIRTE=astb.mHWIRTE;
	amtb.mHRDATA = as2.HRDATA;
	astb.HADDR = am2.mHADDR;
	astb.HWRITE = am2.mHWRITE;
	astb.HSEL = 1;
	astb.HWDATA = am2.mHWDATA;
	astb.HTRANS = am2.mHTRANS;	
	end

grandSet[3]:begin
	am3.mHRDATA   = astb.HRDATA;
	//am3.mHWDATA   = astb.HWDATA;
	//am3.HWIRTE   = astb.mHWIRTE;
	amtb.mHRDATA = as3.HRDATA;
	astb.HADDR   = am3.mHADDR;
	astb.HWRITE  = am3.mHWRITE;
	astb.HSEL    = 1;
	astb.HWDATA  = am3.mHWDATA;
	astb.HTRANS  = am3.mHTRANS;	
	end

grandSet[4]:begin
	am4.mHRDATA   = astb.HRDATA;
	//as1.HRDATA=astb.mHRDATA;
	//as1.HWDATA=astb.mHWDATA;
	//as1.HWIRTE=astb.mHWIRTE;
	amtb.mHRDATA = as4.HRDATA;
	astb.HADDR = am4.mHADDR;
	astb.HWRITE = am4.mHWRITE;
	astb.HSEL = 1;
	astb.HWDATA = am4.mHWDATA;
	astb.HTRANS = am4.mHTRANS;	

	end

grandSet[5]:begin
	am5.mHRDATA   = astb.HRDATA;
	//as1.HRDATA=astb.mHRDATA;
	//as1.HWDATA=astb.mHWDATA;
	//as1.HWIRTE=astb.mHWIRTE;
	amtb.mHRDATA = as5.HRDATA;
	astb.HADDR = am5.mHADDR;
	astb.HWRITE = am5.mHWRITE;
	astb.HSEL = 1;
	astb.HWDATA = am5.mHWDATA;
	astb.HTRANS = am5.mHTRANS;	
	end

grandSet[6]:begin
	am6.mHRDATA   = astb.HRDATA;
	//as1.HRDATA=astb.mHRDATA;
	//as1.HWDATA=astb.mHWDATA;
	//as1.HWIRTE=astb.mHWIRTE;
	amtb.mHRDATA = as6.HRDATA;
	astb.HADDR = am6.mHADDR;
	astb.HWRITE = am6.mHWRITE;
	astb.HSEL = 1;
	astb.HWDATA = am6.mHWDATA;
	astb.HTRANS = am6.mHTRANS;	

	end

grandSet[7]:begin
	am7.mHRDATA   = astb.HRDATA;
	//as1.HRDATA=astb.mHRDATA;
	//as1.HWDATA=astb.mHWDATA;
	//as1.HWIRTE=astb.mHWIRTE;
	amtb.mHRDATA = as7.HRDATA;
	astb.HADDR = am7.mHADDR;
	astb.HWRITE = am7.mHWRITE;
	astb.HSEL = 1;
	astb.HWDATA = am7.mHWDATA;
	astb.HTRANS = am7.mHTRANS;	
	end

default: begin
	astb.HWRITE = 0;
	casex(amtb.mHADDR[31:16])//slave select signel
	16'hF000:
		begin
			if(!am0.mHGRANT)
			begin
			as0.HSEL = 1'b1;
			amtb.mHRDATA = as0.HRDATA;
			as0.HWRITE = amtb.mHWRITE;
			as0.HTRANS = amtb.mHTRANS;
			as0.HWDATA = amtb.mHWDATA;
			as0.HBURST = amtb.mHBURST;
			as0.HSIZE = amtb.mHSIZE;
			as0.HADDR = amtb.mHADDR;
			end
			else
			begin
			as0.HSEL = 1'b0;			
			end
			as1.HSEL = 1'b0;
			as2.HSEL = 1'b0;
			as3.HSEL = 1'b0;
			as4.HSEL = 1'b0;
			as5.HSEL = 1'b0;
			as6.HSEL = 1'b0;
			as7.HSEL = 1'b0;
		end
	16'hF001:
		begin
			if(!am1.mHGRANT)
			begin
			as1.HSEL = 1'b1;
			amtb.mHRDATA = as1.HRDATA;
			as1.HWRITE = amtb.mHWRITE;
			as1.HTRANS = amtb.mHTRANS;
			as1.HWDATA = amtb.mHWDATA;
			as1.HBURST = amtb.mHBURST;
			as1.HSIZE = amtb.mHSIZE;
			as1.HADDR = amtb.mHADDR;
			end
			else
			begin
			as1.HSEL = 1'b0;
			end
			as0.HSEL = 1'b0;
			as2.HSEL = 1'b0;
			as3.HSEL = 1'b0;
			as4.HSEL = 1'b0;
			as5.HSEL = 1'b0;
			as6.HSEL = 1'b0;
			as7.HSEL = 1'b0;			
		end
	16'hF002:
		begin
			if(!am1.mHGRANT)
			begin
			as2.HSEL = 1'b1;
			amtb.mHRDATA = as2.HRDATA;
			as2.HWRITE = amtb.mHWRITE;
			as2.HTRANS = amtb.mHTRANS;
			as2.HWDATA = amtb.mHWDATA;
			as2.HBURST = amtb.mHBURST;
			as2.HSIZE = amtb.mHSIZE;
			as2.HADDR = amtb.mHADDR;

			
			end
			else
			begin
			as2.HSEL = 1'b0;
			end
			as0.HSEL = 1'b0;
			as1.HSEL = 1'b0;
			as3.HSEL = 1'b0;
			as4.HSEL = 1'b0;
			as5.HSEL = 1'b0;
			as6.HSEL = 1'b0;
			as7.HSEL = 1'b0;
		end
	16'hF003:
		begin
			if(!am1.mHGRANT)
			begin
			as3.HSEL = 1'b1;
			amtb.mHRDATA = as3.HRDATA;
			as3.HWRITE = amtb.mHWRITE;
			as3.HTRANS = amtb.mHTRANS;
			as3.HWDATA = amtb.mHWDATA;
			as3.HBURST = amtb.mHBURST;
			as3.HSIZE = amtb.mHSIZE;
			as3.HADDR = amtb.mHADDR;

			
			end
			else
			begin
			as3.HSEL = 1'b0;
			end
			as0.HSEL = 1'b0;
			as1.HSEL = 1'b0;
			as2.HSEL = 1'b0;
			as4.HSEL = 1'b0;
			as5.HSEL = 1'b0;
			as6.HSEL = 1'b0;
			as7.HSEL = 1'b0;
		end
	16'hF004:	
		begin
			if(!am1.mHGRANT)
			begin
			as4.HSEL = 1'b1;
			amtb.mHRDATA = as4.HRDATA;
			as4.HWRITE = amtb.mHWRITE;
			as4.HTRANS = amtb.mHTRANS;
			as4.HWDATA = amtb.mHWDATA;
			as4.HBURST = amtb.mHBURST;
			as4.HSIZE = amtb.mHSIZE;
			as4.HADDR = amtb.mHADDR;

			
			end
			else
			begin
			as4.HSEL = 1'b0;
			end
			as0.HSEL = 1'b0;
			as1.HSEL = 1'b0;
			as2.HSEL = 1'b0;
			as3.HSEL = 1'b0;
			as5.HSEL = 1'b0;
			as6.HSEL = 1'b0;
			as7.HSEL = 1'b0;
		end
	16'hF005:
		begin
			if(!am1.mHGRANT)
			begin
			as5.HSEL = 1'b1;
			amtb.mHRDATA = as5.HRDATA;
			as5.HWRITE = amtb.mHWRITE;
			as5.HTRANS = amtb.mHTRANS;
			as5.HWDATA = amtb.mHWDATA;
			as5.HBURST = amtb.mHBURST;
			as5.HSIZE = amtb.mHSIZE;
			as5.HADDR = amtb.mHADDR;

			
			end
			else
			begin
			as5.HSEL = 1'b0;		
			end
			as0.HSEL = 1'b0;
			as1.HSEL = 1'b0;
			as2.HSEL = 1'b0;
			as3.HSEL = 1'b0;
			as4.HSEL = 1'b0;
			as6.HSEL = 1'b0;
			as7.HSEL = 1'b0;
		end
	16'hF006:
		begin
			if(!am1.mHGRANT)
			begin
			as6.HSEL = 1'b1;
			amtb.mHRDATA = as6.HRDATA;
			as6.HWRITE = amtb.mHWRITE;
			as6.HTRANS = amtb.mHTRANS;
			as6.HWDATA = amtb.mHWDATA;
			as6.HBURST = amtb.mHBURST;
			as6.HSIZE = amtb.mHSIZE;
			as6.HADDR = amtb.mHADDR;

			
			end
			else
			begin
			as6.HSEL = 1'b0;			
			end
			as0.HSEL = 1'b0;
			as1.HSEL = 1'b0;
			as2.HSEL = 1'b0;
			as3.HSEL = 1'b0;
			as4.HSEL = 1'b0;
			as5.HSEL = 1'b0;
			as7.HSEL = 1'b0;
		end
	16'hF007:
		begin
			begin
			as7.HSEL = 1'b1;
			amtb.mHRDATA = as7.HRDATA;
			as7.HWRITE = amtb.mHWRITE;
			as7.HTRANS = amtb.mHTRANS;
			as7.HWDATA = amtb.mHWDATA;
			as7.HBURST = amtb.mHBURST;
			as7.HSIZE = amtb.mHSIZE;
			as7.HADDR = amtb.mHADDR;
			as0.HSEL = 1'b0;
			as1.HSEL = 1'b0;
			as2.HSEL = 1'b0;
			as3.HSEL = 1'b0;
			as4.HSEL = 1'b0;
			as5.HSEL = 1'b0;
			as6.HSEL = 1'b0;
			end
		end
	endcase
	end	
endcase	

end


reg [20:0]states,state_nxt;




always @(posedge amtb.HCLK)
begin
if(amtb.HRESET)
begin
states <= 0;
end 
else
begin
states <= state_nxt;
end 
end


always @(*)
begin 
state_nxt = states;

	case(states)
	0:
	begin
		if(am7.mHBUSREQ == 1)
		begin
		am7.mHGRANT=1;
		state_nxt = 12;
		end
		else if(am6.mHBUSREQ == 1)	
		begin
		am6.mHGRANT=1;
		state_nxt = 11;
		end
		else if(am1.mHBUSREQ == 1)
		begin
		am1.mHGRANT=1;
		state_nxt = 14;
		end
		else if(am2.mHBUSREQ == 1)
		begin
		am2.mHGRANT=1;
		state_nxt = 15;
		end
		else if(am3.mHBUSREQ == 1)
		begin
		am3.mHGRANT=1;
		state_nxt = 8;
		end
		else if(am4.mHBUSREQ == 1)
		begin
		am4.mHGRANT=1;
		state_nxt = 9;

		end
		else if(am5.mHBUSREQ == 1)
		begin
		state_nxt = 10;
		am5.mHGRANT=1;

		end
		else if(am0.mHBUSREQ == 1)
		begin
		state_nxt = 13;
		am0.mHGRANT=1;

		end
		else
		begin
		amtb.mHGRANT =  1;	
		state_nxt = 16;
		end
	
	end		
	
	8:
    	if(am3.mHBUSREQ == 0)
	begin
    	state_nxt  =0;am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=0;amtb.mHGRANT=0;
    	end     
    	else
    	begin
	am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=1;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=0;state_nxt  =8;amtb.mHGRANT=0;
    	end 
	
	9:
	if(am4.mHBUSREQ == 0)    
	begin
	am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=0;state_nxt  =0;amtb.mHGRANT=0;	
        end 
   	else
    	begin
	am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=1;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=0;state_nxt  =9;amtb.mHGRANT=0;
    	end 
	
	10:
    	if(am5.mHBUSREQ == 0)    
    	begin
	am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=0;state_nxt  =0;amtb.mHGRANT=0;	
    	end 
    	else
    	begin
	am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=1;am6.mHGRANT=0;am7.mHGRANT=0;state_nxt  =10;amtb.mHGRANT=0;
    	end 
	
	11:
    	if(am6.mHBUSREQ == 0)    
    	begin
	am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=0;state_nxt  =0;amtb.mHGRANT=0;	
    	end 
    	else
    	begin
	am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=1;am7.mHGRANT=0;state_nxt  =11;amtb.mHGRANT=0;
	end 
	
	12:
        if(am7.mHBUSREQ == 0)    
    	begin
	am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=0;state_nxt  =0;amtb.mHGRANT=0;	
    	end 
    	else
	begin
	am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=1;state_nxt  =12;amtb.mHGRANT=0;
    	end 
	
	13:
    	if(am0.mHBUSREQ == 0)    
    	begin
	am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=0;state_nxt  =0;amtb.mHGRANT=0;
    	end 
    	else
    	begin
	am0.mHGRANT=1;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=0;state_nxt  =13;amtb.mHGRANT=0;
    	end 

 	14:
    	if(am1.mHBUSREQ == 0)    
    	begin
	am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=0;state_nxt  =0;amtb.mHGRANT=0;	
    	end 
    	else
    	begin
	am0.mHGRANT=0;am1.mHGRANT=1;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=0;state_nxt  =14;amtb.mHGRANT=0;
    	end 
 
	15:
    	if(am2.mHBUSREQ == 0)    
    	begin
	am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=0;state_nxt  =0;amtb.mHGRANT=0;	
    	end 
    	else
    	begin
	am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=1;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=0;state_nxt=15;amtb.mHGRANT=0;
    	end 

	16:
	/*	
    	if(amtb.mHBUSREQ == 0)    
    	begin
	am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=0;state_nxt=0;amtb.mHGRANT = 0;	
    	end 
    	else
	*/	
    	begin
	amtb.mHGRANT=0;am0.mHGRANT=0;am1.mHGRANT=0;am2.mHGRANT=0;am3.mHGRANT=0;am4.mHGRANT=0;am5.mHGRANT=0;am6.mHGRANT=0;am7.mHGRANT=0;state_nxt  =0;
    	end

   default : state_nxt = 0;
   endcase
end  
	
/*	

if(am3.mHBUSREQ)
begin
am3.mHGRANT=1'b1;
am3.mHRDATA=astb.HRDATA;
astb.HADDR = am3.mHADDR;
astb.HWRITE = am3.mHWRITE;
astb.HTRANS = am3.mHTRANS;
astb.HWDATA = am3.mHWDATA;
end
else
begin
am3.mHGRANT=0;
end









am0.mHGRANT=0;
am1.mHGRANT=0;
am2.mHGRANT=0;
am3.mHGRANT=0;
am4.mHGRANT=0;
am5.mHGRANT=0;
am6.mHGRANT=0;
am7.mHGRANT=0;

*/
































endmodule
