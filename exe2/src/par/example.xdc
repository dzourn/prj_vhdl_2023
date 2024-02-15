create_clock -period 10.000 -name CLK [get_ports { clk }];
set_property -dict { PACKAGE_PIN Y9  IOSTANDARD LVCMOS33 } [get_ports { clk }];

# "SW0"
set_property -dict { PACKAGE_PIN F22  IOSTANDARD LVCMOS33 } [get_ports { switches[0] }];
# "SW1"
set_property -dict { PACKAGE_PIN G22  IOSTANDARD LVCMOS33 } [get_ports {switches[1]}];
# "SW2"
set_property -dict { PACKAGE_PIN H22  IOSTANDARD LVCMOS33 } [get_ports { switches[2] }];
# "SW3"
set_property -dict { PACKAGE_PIN F21  IOSTANDARD LVCMOS33 } [get_ports { switches[3]}];
# "SW4"
set_property -dict { PACKAGE_PIN H19  IOSTANDARD LVCMOS33 } [get_ports { switches[4] }];
# "SW5"
set_property -dict { PACKAGE_PIN H18  IOSTANDARD LVCMOS33 } [get_ports { switches[5] }];
# "SW6"
set_property -dict { PACKAGE_PIN H17  IOSTANDARD LVCMOS33 } [get_ports {switches[6]}];
# "SW7"
set_property -dict { PACKAGE_PIN M15  IOSTANDARD LVCMOS33 } [get_ports {switches[7]}];

# "LD0"
set_property -dict { PACKAGE_PIN T22  IOSTANDARD LVCMOS33 } [get_ports {data_out[0] }];
# "LD1"
set_property -dict { PACKAGE_PIN T21  IOSTANDARD LVCMOS33 } [get_ports {data_out[1] }];
# "LD2"
set_property -dict { PACKAGE_PIN U22  IOSTANDARD LVCMOS33 } [get_ports { data_out[2] }];
# "LD3"
set_property -dict { PACKAGE_PIN U21  IOSTANDARD LVCMOS33 } [get_ports { data_out[3] }];
# "LD4"
set_property -dict { PACKAGE_PIN V22  IOSTANDARD LVCMOS33 } [get_ports { data_out[4] }];
# "LD5"
set_property -dict { PACKAGE_PIN W22  IOSTANDARD LVCMOS33 } [get_ports { data_out[5] }];
# "LD6"
set_property -dict { PACKAGE_PIN U19  IOSTANDARD LVCMOS33 } [get_ports { data_out[6] }];
# "LD7"
set_property -dict { PACKAGE_PIN U14  IOSTANDARD LVCMOS33 } [get_ports { data_out[7] }];

# "BTNC"
set_property -dict { PACKAGE_PIN P16  IOSTANDARD LVCMOS33 } [get_ports { rst }];
# "BTND"
set_property -dict { PACKAGE_PIN R16  IOSTANDARD LVCMOS33 } [get_ports { BTND }];
# "BTNL"
set_property -dict { PACKAGE_PIN N15  IOSTANDARD LVCMOS33 } [get_ports { BTNL }];
# "BTNR"
set_property -dict { PACKAGE_PIN R18  IOSTANDARD LVCMOS33 } [get_ports { BTNR }];
# "BTNU"
set_property -dict { PACKAGE_PIN T18  IOSTANDARD LVCMOS33 } [get_ports { BTNU }];

#PMOD next to switches
#JA1
set_property -dict { PACKAGE_PIN Y11  IOSTANDARD LVCMOS33 } [get_ports { segment[0] }];
#JA2
set_property -dict { PACKAGE_PIN AA11  IOSTANDARD LVCMOS33 } [get_ports { segment[1] }];
#JA3
set_property -dict { PACKAGE_PIN Y10  IOSTANDARD LVCMOS33 } [get_ports { segment[2] }];
#JA4
set_property -dict { PACKAGE_PIN AA9  IOSTANDARD LVCMOS33 } [get_ports { segment[3] }];
#JB1
set_property -dict { PACKAGE_PIN W12  IOSTANDARD LVCMOS33 } [get_ports { segment[4] }];
#JB2
set_property -dict { PACKAGE_PIN W11  IOSTANDARD LVCMOS33 } [get_ports { segment[5] }];
#JB3
set_property -dict { PACKAGE_PIN V10  IOSTANDARD LVCMOS33 } [get_ports { segment[6] }];
#JB4
set_property -dict { PACKAGE_PIN W8  IOSTANDARD LVCMOS33 } [get_ports { digit }];
