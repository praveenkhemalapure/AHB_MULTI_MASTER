//bit output

module canxmit(cantintf.xmit ctf);

reg [7:0] length1, counter2, counter3, counter4, counterC, cp1;
reg [140:0] frame1;
reg [200:0] frame3, frame4;
reg [2:0] state, O_cp;

reg [14:0] reCRC2;
reg [2:0] five_counter;
reg [8:0] BScp, outlength,temp;

reg [9:0] N, N0;
reg ddrive, busy, dout;

parameter idle=3'b000, start=3'b001, crc_bs=3'b010, bitout=3'b011;

assign ctf.ddrive=ddrive;
assign ctf.busy=busy;
assign ctf.dout=dout;
assign N0=(1+ctf.propQuanta+ctf.seg1Quanta+ctf.seg1Quanta)*ctf.quantaDiv;



always @(posedge ctf.clk)
begin
	if (ctf.rst)
	begin 
		state <= 0;
		length1 <= 0;
		frame1 <= 0;
		busy <= 1'b0;
		N <= 0;
		state <= 0;
		counter2 <= 0;
		counter3 <= 0;
		counter4 <= 0;
		five_counter <= 0;
		reCRC2 <= 0;
		frame1 <= 0;
		frame3 <= 0;
		frame4 <= 0;
		BScp <= 0;
		outlength <= 0;
		ddrive <= 1'b0;
		counterC <= 0;
		dout <= 1'b1;
		cp1 <= 8'b00001010;
		O_cp <= 3'b111;
		temp <= 0;
	end
	
	else
	begin	
		case(state)
		idle:
		begin	
			length1 <= 0;
			frame1 <= 0;
			busy <= 1'b0;
			N <= 0;
			state <= 0;
			counter2 <= 0;
			counter3 <= 0;
			counter4 <= 0;
			five_counter <= 0;
			reCRC2 <= 0;
			frame1 <= 0;
			frame3 <= 0;
			frame4 <= 0;
			BScp <= 0;
			outlength <= 0;
			ddrive <= 1'b0;
			counterC <= 0;
			dout <= 1'b1;
			cp1 <= 8'b00001010;
			O_cp <= 3'b111;
			temp <= 0;
			if(ctf.startXmit)
			begin
				state <= start;
			end
		end
		start:
		begin
			busy <= 1'b1;
					if (ctf.format==0&&ctf.frameType==0)//data_frame with 11bit ID
					begin
						case(ctf.datalen)
						4'b0000:	
								begin
								frame1[140:122] <= {1'b0, ctf.id[28:18], 3'b0, ctf.datalen};
								length1 <=19;//default decimalism
								end
						4'b0001:	
								begin
                                				frame1[140:114] <= {1'b0, ctf.id[28:18], 3'b0, ctf.datalen, ctf.xmitdata[63:56]};//
								length1 <=27;
								end
						4'b0010:	
								begin
								frame1[140:106] <= {1'b0, ctf.id[28:18], 3'b0, ctf.datalen, ctf.xmitdata[63:48]};
								length1 <= 35;
								end
						4'b0011:	
								begin
								frame1[140:98] <= {1'b0, ctf.id[28:18], 3'b0, ctf.datalen, ctf.xmitdata[63:40]};
								length1 <= 43;
								end
						4'b0100:	
								begin
								frame1[140:90] <= {1'b0, ctf.id[28:18], 3'b0, ctf.datalen, ctf.xmitdata[63:32]};
								length1 <= 51;
								end
						4'b0101:	
								begin
								frame1[140:82] <= {1'b0, ctf.id[28:18], 3'b0, ctf.datalen, ctf.xmitdata[63:24]};
								length1 <= 59;
								end
						4'b0110:	
								begin 
								frame1[140:74] <= {1'b0, ctf.id[28:18], 3'b0, ctf.datalen, ctf.xmitdata[63:16]};
								length1 <= 67;
								end
						4'b0111:	
								begin 
								frame1[140:66] <= {1'b0, ctf.id[28:18], 3'b0, ctf.datalen, ctf.xmitdata[63:8]};
								length1 <= 75;
								end
						4'b1000:	
								begin
								frame1[140:58] <= {1'b0, ctf.id[28:18], 3'b0, ctf.datalen, ctf.xmitdata[63:0]};
								length1 <= 83;
								end
						endcase
					end
					if (ctf.format==1&&ctf.frameType==0)//data_frame with 29bit ID
					begin
						case(ctf.datalen)
						4'b0000:	
								begin
								frame1[140:102] <= {1'b0, ctf.id[28:18], 2'b10, ctf.id[17:0], 3'b0, ctf.datalen};
								length1 <= 39;//default decimalism
								end
						4'b0001:	
								begin
                                  				frame1[140:94] <= {1'b0, ctf.id[28:18], 2'b10, ctf.id[17:0], 3'b0, ctf.datalen, ctf.xmitdata[63:56]};//
								length1 <= 47;
								end
						4'b0010:	
								begin
								frame1[140:86] <= {1'b0, ctf.id[28:18], 2'b10, ctf.id[17:0], 3'b0, ctf.datalen, ctf.xmitdata[63:48]};
								length1 <= 55;
								end
						4'b0011:	
								begin
								frame1[140:78] <= {1'b0, ctf.id[28:18], 2'b10, ctf.id[17:0], 3'b0, ctf.datalen, ctf.xmitdata[63:40]};
								length1 <= 63;
								end
						4'b0100:	
								begin
								frame1[140:70] <= {1'b0, ctf.id[28:18], 2'b10, ctf.id[17:0], 3'b0, ctf.datalen, ctf.xmitdata[63:32]};
								length1 <= 71;
								end
						4'b0101:	
								begin
								frame1[140:62] <= {1'b0, ctf.id[28:18], 2'b10, ctf.id[17:0], 3'b0, ctf.datalen, ctf.xmitdata[63:24]};
								length1 <= 79;
								end
						4'b0110:	
								begin 
								frame1[140:54] <= {1'b0, ctf.id[28:18], 2'b10, ctf.id[17:0], 3'b0, ctf.datalen, ctf.xmitdata[63:16]};
								length1 <= 87;
								end
						4'b0111:	
								begin 
								frame1[140:46] <= {1'b0, ctf.id[28:18], 2'b10, ctf.id[17:0], 3'b0, ctf.datalen, ctf.xmitdata[63:8]};
								length1 <= 95;
								end
						4'b1000:	
								begin
								frame1[140:38] <= {1'b0, ctf.id[28:18], 2'b10, ctf.id[17:0], 3'b0, ctf.datalen, ctf.xmitdata[63:0]};
								length1 <= 103;
								end
						endcase
					end
				if(ctf.frameType==1)//request_frame
				begin 
					if (ctf.format==0)//request_frame with 11bit ID
					begin
						frame1[140:122] <= {1'b0, ctf.id[28:18], 3'b100, ctf.datalen};
						length1 <= 19;
					end
					else if (ctf.format==1)//request_frame with 29bit ID
					begin
						frame1[140:102] <= {1'b0, ctf.id[28:18], 2'b10, ctf.id[17:0], 3'b100, ctf.datalen};
						length1 <= 39;
					end
				end
/********************************error frame******************************/
				if(ctf.frameType==2)//error_frame
				begin
					length1 <= 6;
				end
/********************************overload frame******************************/
				if(ctf.frameType==3)//overload_frame
				begin
					length1 <= 6;
				end
				if (ctf.frameType<2)
				begin
					state <= state + 1;//CRC and bitstuffing
				end
				else 
				begin
					state <= state + 2;//Error 
				end
		end		
		crc_bs:
		begin
			if (counterC < length1)
			begin
				//CRC
              			reCRC2[0] <= frame1[140-counterC] ^ reCRC2[14];
				reCRC2[1] <= reCRC2[0];
				reCRC2[2] <= reCRC2[1];
            			reCRC2[3] <= reCRC2[2]^frame1[140-counterC]^reCRC2[14];
              			reCRC2[4] <= reCRC2[3]^frame1[140-counterC]^reCRC2[14];
				reCRC2[5] <= reCRC2[4];
				reCRC2[6] <= reCRC2[5];
              			reCRC2[7] <= reCRC2[6]^frame1[140-counterC]^reCRC2[14];
              			reCRC2[8] <= reCRC2[7]^frame1[140-counterC]^reCRC2[14];
				reCRC2[9] <= reCRC2[8];
              			reCRC2[10] <= reCRC2[9]^frame1[140-counterC]^reCRC2[14];
				reCRC2[11] <= reCRC2[10];
				reCRC2[12] <= reCRC2[11];
				reCRC2[13] <= reCRC2[12];
              			reCRC2[14] <= reCRC2[13]^frame1[140-counterC]^reCRC2[14];
				counterC <= counterC + 1;
			end
			//bitstuffing
			if (counter2 < length1) 
			begin
				if (five_counter==4 && frame1[140-counter2] ==frame1[141-counter2])
				begin
					frame3[200-BScp]<=~frame3[201-BScp];
					five_counter<=0;
				end
				else
				begin
					if (counter2!=0 && (frame1[140-counter2]==frame3[201-BScp]))
					begin
						five_counter<=five_counter+1;
					end
					else
					begin
						five_counter<=0;
					end
					frame3[200-BScp]<=frame1[140-counter2];
					counter2<=counter2+1;
				end
				BScp<=BScp+1;
			end
			else if (counter3<15)
			begin
				if (five_counter==4 && frame3[201-BScp] ==reCRC2[14-counter3])
				begin
					frame3[200-BScp]<=~frame3[201-BScp];
					five_counter<=0;
				end
				else
				begin			
					//if (counter3==0 && (frame1[141-length1]==reCRC2[14-counter3]))
					if (counter3==0 && (frame3[201-BScp]==reCRC2[14-counter3]))
					begin
						five_counter<=five_counter+1;
					end
					else if(reCRC2[14-counter3]==frame3[201-BScp])
					begin
						five_counter<=five_counter+1;
					end
					else 
					begin
						five_counter<=0;
					end
					frame3[200-BScp]<=reCRC2[14-counter3];
					counter3<=counter3+1;
				end
				BScp<=BScp+1;
			end
			else
			begin
				outlength<=BScp;
				frame4<=frame3;
				state<=state+1;
			end
///////////////////////////////////////////////////////////////////////////
			ddrive <= 1'b1;
			if (counter4 == N0-1 && (temp==0))
			begin 
				dout <= 0;
				counter4 <= 0;
				temp <= 1;
			end
			else if (counter4 == N0-1 && (temp !=0))
			begin
				dout <= frame3[200-temp];
				counter4 <= 0;
				temp <= temp + 1;
			end
			else
			begin
				counter4 <= counter4+1;
			end
///////////////////////////////////////////////////////////////////////////
		end
		bitout:
		begin
			ddrive<=1'b1;
			if (counter4 == N0-1)
			begin
				if ((outlength-temp)>0)
				begin
					dout <= frame4[200+outlength-temp-BScp];
					outlength <= outlength-1;
				end
				else if(cp1>0 &&  BScp>0)
				begin
					dout <= 1'b1;
					cp1 <= cp1-1;
				end
				else if (O_cp>1 && length1==6)
				begin
					dout <= 1'b0;//
					O_cp <= O_cp-1;
				end
				else
				begin
					state <= idle;
					busy <= 1'b0;
				end
				counter4 <= 0;
			end
			else
			counter4 <= counter4 + 1;	
		end
		endcase
	end				
end

endmodule
