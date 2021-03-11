module block2_src
   #(
    parameter CD = 12,      // color depth
              ADDR = 12,    // number of address bits
              KEY_COLOR =0  // chroma key
   )
   (
    input  logic clk,
    input  logic [10:0] x, y,   // x-and  y-coordinate    
    input  logic [10:0] x0, y0, // origin of sprite 
    input  logic [3:0] ctrl,
    // sprite ram write 
    input  logic we,
    input  logic [13:0] addr_w, // ignore ADDR or will fail to synthesize (needed more bits)
    input  logic [CD-1:0] pixel_in,
    // pixel output
    output logic [CD-1:0] i_block_rgb
   );
   
   // localparam declaration
   localparam H_SIZE = 32; // horizontal size of sprite
   localparam V_SIZE = 32; // vertical size of sprite
   // signal delaration
   logic signed [11:0] xr, yr;  // relative x/y position
   logic in_region;
   logic [13:0] addr_r; // again, ignored ADDR
   logic [CD-1:0] full_rgb, out_rgb;
   logic [CD-1:0] out_rgb_d1_reg;
   logic [3:0] sid;
   assign sid = ctrl[3:0];
   
   // body
   // instantiate sprite RAM  // I will neglect the parameter ADDR because i am only reading
   block2_ram #(.ADDR_WIDTH(14),.DATA_WIDTH(CD)) ram_unit (
      .clk(clk), .we(we), .addr_w(addr_w), .din(pixel_in),
      .addr_r(addr_r), .dout(full_rgb));
   assign addr_r = {sid, yr[4:0], xr[4:0]};   
   //*************************************************************************************//
   // **************** sid [4:2] are for selecting the type of block *********************//
   // **************** sid [1:0] are for the rotation of each block **********************//
   // ****** sid[4:2] == 0: i block  // sid == 1: o block  // sid == 2: t block **********//
   // sid == 3: s block  // sid == 4: z block  // sid == 5: j block  // sid == 6: L block //
   //*************************************************************************************//
      
   // relative coordinate calculation
   assign xr = $signed({1'b0, x}) - $signed({1'b0, x0});
   assign yr = $signed({1'b0, y}) - $signed({1'b0, y0});
   // in-region comparison and multiplexing 
   assign in_region = (0<= xr) && (xr<H_SIZE) && (0<=yr) && (yr<V_SIZE);
   assign out_rgb = in_region ? full_rgb : KEY_COLOR;
   // output with a-stage delay line
   always_ff @(posedge clk) 
      out_rgb_d1_reg <= out_rgb;
   assign i_block_rgb = out_rgb_d1_reg;
endmodule
