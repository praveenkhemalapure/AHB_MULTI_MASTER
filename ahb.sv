module ahb (  AHBIF.AHBM ahbmint , AHBIF.AHBS ahbsint ,cantintf.tox tranint);


reg [31:0]DH,DHm,DHmm;
reg [31:0]DL,DLm,DLmm;
reg [31:0]CMD,CMDm,CMDmm;
reg [31:0]ID,IDm,IDmm;
reg [31:0]ST_BUSY;
reg [31:0]BM_BASE,BM_BASEm;
reg [31:0]BM_STATUS,LINK,LINKm,mADDR,mmADDR,mDATA,mmDATA;
reg [4:0]count;
reg [4:0]countm;


reg [10:0]slave_states,nxtslave_states;
reg [10:0]master_states,nxtmaster_states;

always@(posedge ahbsint.HCLK)
begin
	if(ahbsint.HRESET)
	begin
//	ID           <= 0;
//	DL 	     <= 0;
//	CMD	     <= 0;
//	ST_BUSY      <= 0;
//	DHm	     <= 0;
//	DLm	     <= 0;
//	CMDm	     <= 0;
//	IDm          <= 0;

//	BM_BASE	     <= 0;
//	BM_STATUS    <= 0;
//	LINK	     <= 0;
//	mADDR	     <= 0;
//	mDATA	     <= 0;
	nxtmaster_states  <=  0;
//	master_states  <=  0;
	nxtslave_states   <=  0;
	count 		<= 0;
//	countm 		<= 0;
	end
	else
	begin
	nxtslave_states  <=  slave_states;
	nxtmaster_states <=  master_states;
	count 		 <= countm;
	LINKm		 <= LINK;	
        mmDATA		 <= mDATA;
	mmADDR		 <= mADDR;	
	DHmm		 <= DHm;
	DLmm		 <= DLm;
	CMDmm		 <= CMDm;	
	IDmm		 <= IDm;
	BM_BASEm 	 <= BM_BASE;

	end

end



always @(*)
begin
countm = count;
LINK   = LINKm;
mDATA  = mmDATA;
mADDR  = mmADDR;
DHm    = DHmm;
DLm    = DLmm;	
IDm    = IDmm;
CMDm   = CMDmm;
slave_states = nxtslave_states;
master_states = nxtmaster_states;
BM_BASE = BM_BASEm;
ahbmint.mHWRITE = ahbmint.mHWRITE;
ahbmint.mHWDATA = ahbmint.mHWDATA;
ahbmint.mHTRANS = ahbmint.mHTRANS;
ahbmint.mHADDR  = ahbmint.mHADDR;
ahbsint.HRDATA  = ahbsint.HRDATA;
tranint.frameType = tranint.frameType;
ahbmint.mHBUSREQ  = ahbmint.mHBUSREQ;
tranint.startXmit = tranint.startXmit;
tranint.id        = tranint.id;
tranint.format	  = tranint.format;
tranint.xmitdata  = tranint.xmitdata;
tranint.datalen   = tranint.datalen;
tranint.quantaDiv = tranint.quantaDiv;
tranint.propQuanta = tranint.propQuanta;
tranint.seg1Quanta = tranint.seg1Quanta;




	case(nxtslave_states)					
		0:
			if((ahbsint.HADDR[15:0] == 16'hff04) && (ahbsint.HTRANS == 2) && (ahbsint.HWRITE))
	 		begin
				 	slave_states = 1;
			end
			else
			begin
				 	slave_states = 0;
			end	

		1: 
			begin	
                  	if(ahbsint.HADDR[15:0] == 16'hff04)begin
					DLm = ahbsint.HWDATA;
                                        slave_states = 2;
				end
			if((ahbsint.HADDR[15:0] == 16'hff00) && (ahbsint.HTRANS == 2) && (ahbsint.HWRITE))
                        begin
                                        slave_states = 2;
                        end
                        else
                        begin
                                        slave_states = 1;
		                end	
			end
		2:
			begin
 			if(ahbsint.HADDR[15:0] == 16'hff00)
			begin	
					DHm = ahbsint.HWDATA;
                                        slave_states = 3;
			end		
			if((ahbsint.HADDR[15:0] == 16'hff08) && (ahbsint.HTRANS == 2) && (ahbsint.HWRITE))
                        begin
                                        slave_states = 3;
                        end
                        else
                        begin
                                        slave_states = 2;
			end
			end
		3:
			begin
	                if(ahbsint.HADDR[15:0] == 16'hff08)
			 begin       
					CMDm = ahbsint.HWDATA;
                                        slave_states = 4;
			end		
			if((ahbsint.HADDR[15:0] == 16'hff0c) && (ahbsint.HTRANS == 2) && (ahbsint.HWRITE))
                        begin
                                        slave_states = 4;
                        end
                        else
                        begin
                                        slave_states = 3;
                        end
			end
				
		4:
			begin
                
               	    if(ahbsint.HADDR[15:0] == 16'hff0c)
		       begin     
                       IDm  = ahbsint.HWDATA;
                        slave_states = 5;
		       end
			if((ahbsint.HADDR[15:0] == 16'hff10) && (ahbsint.HTRANS == 2) && (ahbsint.HWRITE))
                        begin
                        slave_states = 5;
                        end
                    else
                        begin
                        slave_states = 4;
                        end
			end
                        
		
		5:
			
                        begin
                                        slave_states = 6;
      					  ST_BUSY 	= ahbsint.HWDATA;
				tranint.startXmit  	= 1'b1;
				tranint.quantaDiv  	= CMDm[31:24];
			       	tranint.propQuanta	= CMDm[23:18];
			       	tranint.seg1Quanta  	= CMDm[17:12];
			       	tranint.xmitdata	= {DHm,DLm};
				tranint.datalen		= CMDm[11:8];
				tranint.id		= IDm[31:3];
				tranint.format		= CMDm[7];
				tranint.frameType	= CMDm[6:5];

                        end
		

		6:

		if(ahbsint.HADDR[15:0] == 16'hff14)
			begin
				slave_states = 7;	
			end
		else	
		begin
			if(ahbsint.HWRITE == 0)
				begin
				tranint.startXmit  	= 1'b0;
				slave_states = 6;
					case(ahbsint.HADDR[15:0])	
					16'hff00:
							ahbsint.HRDATA = DHm;		
			
					16'hff04:
							ahbsint.HRDATA = DLm;
			
					16'hff08:
							ahbsint.HRDATA = CMDm;
				
					16'hff0c:
							ahbsint.HRDATA = IDm;
			
					16'hff10:
	       						ahbsint.HRDATA = {31'b0,tranint.busy};

					endcase
				end
			else
			begin
	                    if((ahbsint.HADDR[15:0] == 16'hff04) && (ahbsint.HTRANS == 2) && (ahbsint.HWRITE))
        	            begin
					 	slave_states = 1;
	                    end
        	            else
                	    begin
					 	slave_states = 6; 
	                    end	
        		end  
		end	



		7:
			begin
			if(ahbsint.HADDR[15:0] == 16'hff14)
			begin
			BM_BASE   =   ahbsint.HWDATA;			
			end 
			
			
            if(ahbsint.HADDR[15:0] == 16'hff18)
			begin
//			BM_BASE   =   ahbsint.HWDATA;
			slave_states = 8;
			ahbmint.mHBUSREQ = 1;
			BM_STATUS	= 1;
			ahbsint.HRDATA = {BM_STATUS,1};
			master_states  = 0;
			end
			else
			begin
			slave_states = 7;
			end
			end




                8:
                        begin
		              case(nxtmaster_states)

				      0:
			                        if(ahbmint.mHGRANT)
			                        begin
			                        ahbmint.mHTRANS  = 2;
						master_states   = 2;	
						ahbmint.mHWRITE = 1'b0;
    
							case(count)
							0:
								ahbmint.mHADDR  = BM_BASE;
							1:
								ahbmint.mHADDR  = BM_BASE + 4;
							2:
								ahbmint.mHADDR  = BM_BASE + 8;
							3:
								ahbmint.mHADDR  = BM_BASE + 12;
							4:
								ahbmint.mHADDR  = BM_BASE + 16;
							5:
								ahbmint.mHADDR  = BM_BASE + 20;
							6:
								ahbmint.mHADDR  = BM_BASE + 24;
				
							endcase	
						end	
						else
						begin
						master_states   = 0;	
						end	
				      1:
	   	         		        begin
	  						
                                                master_states  = 2;
		
						end			
					
                                      2:
                                                begin
						if(count < 7)
						begin
							case(count)

							0:
							begin
	                                                         DHm   = ahbmint.mHRDATA;
								countm = count + 1;
								master_states = 0;
							end

			 				1:
			       				begin					
		                                                 DLm   = ahbmint.mHRDATA;
								countm = count + 1;
								master_states = 0;
							end	

							2:
							begin
	                                                         CMDm  = ahbmint.mHRDATA;
								countm = count + 1;
								master_states = 0;
							end	
	
 							3:
							begin	
	                                                         IDm   = ahbmint.mHRDATA;
								countm = count + 1;
								master_states = 0;
							end	
							
							4:
							begin	
                                                                 mADDR = ahbmint.mHRDATA;
								countm = count + 1;
								master_states = 0;
							end	

							5:
							begin	
							 	mDATA  = ahbmint.mHRDATA;
								countm = count + 1;
								master_states = 0;
							end	
							
							6:
							begin	
			                                        LINK  = ahbmint.mHRDATA;
                        			                countm = 0;
		        					// ahbmint.mHBUSREQ = 0;
								master_states = 3;
							end	
	
	                                                endcase
						 end	 
						 else
						begin	
					                        master_states  = 3;
						end	 

                                                end
			
	

	                		 3:
                                               begin
                                            master_states  = 7;
	                               tranint.startXmit       = 1'b1;
        	                       tranint.quantaDiv       = CMDm[31:24];
                	               tranint.propQuanta      = CMDm[23:18];
                     		       tranint.seg1Quanta      = CMDm[17:12];
	                               tranint.xmitdata        = {DHm,DLm};
        	                       tranint.datalen         = CMDm[11:8];
                	               tranint.id              = IDm[31:3];
	                               tranint.format          = CMDm[7];
	                               tranint.frameType       = CMDm[6:5];
	                                //ahbmint.mHBUSREQ       = 0;
                                                end
					

				     7:
					begin
	                                ahbmint.mHBUSREQ       = 0;
                                            master_states      = 4;
	                               tranint.startXmit       = 1'b0;


					end	
							
	
								
				     4:
		     				begin
		                   			 tranint.startXmit       = 1'b0;
							if(tranint.busy == 0)
							begin
				                                ahbmint.mHBUSREQ = 1'b1;
								master_states   = 6;
							end
							else
							begin
								master_states   = 4;
								ahbmint.mHWRITE = 1'b0;				
							end

						end					

				      5:
						begin
									ahbmint.mHWRITE = 1'b0;				
                                                                if(LINK == 0)
                                                                begin
                        	                                        BM_STATUS = 0;
                                                                    BM_BASE   = LINK;
                                                                    ahbsint.HRDATA = {BM_STATUS,0};
                                                	                slave_states   = 6;
                                                                    ahbmint.mHBUSREQ = 0;
                                                                    ahbmint.mHTRANS  = 0;	
                                                                end
                                                                else
                                                                begin
                                                	                master_states   = 0;
                                                        	        BM_BASE         = LINK;
                                                                end




						end


                        6:
                        begin
				if(ahbmint.mHGRANT)
				begin	
				ahbmint.mHADDR  = mADDR;
				ahbmint.mHWDATA = mDATA;
				ahbmint.mHWRITE = 1'b1;				
				master_states   = 5;
                        	end
				else
				begin
				master_states   = 6;
				end
	
                        
                        end 




				default: master_states = 0;
				endcase	
                        end




        default: slave_states = 0;
        endcase
        
    end

endmodule
