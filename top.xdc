set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports clk]

#create_clock -name clk -period 12.000 [get_ports clk]

set_property -dict {PACKAGE_PIN U4 IOSTANDARD LVCMOS33} [get_ports rst]

#create_clock -period 12.856 -name divideClk -waveform {0.000 6.428} [get_nets -hierarchical *divide*]

set_property -dict {PACKAGE_PIN B4 IOSTANDARD LVCMOS33} [get_ports {leds[0]}]
set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVCMOS33} [get_ports {leds[1]}]
set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports {leds[2]}]
set_property -dict {PACKAGE_PIN B1 IOSTANDARD LVCMOS33} [get_ports {leds[3]}]
set_property -dict {PACKAGE_PIN A1 IOSTANDARD LVCMOS33} [get_ports {leds[4]}]
set_property -dict {PACKAGE_PIN B3 IOSTANDARD LVCMOS33} [get_ports {leds[5]}]
set_property -dict {PACKAGE_PIN B2 IOSTANDARD LVCMOS33} [get_ports {leds[6]}]

set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports {ano[0]}]
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports {ano[1]}]
set_property -dict {PACKAGE_PIN C1 IOSTANDARD LVCMOS33} [get_ports {ano[2]}]
set_property -dict {PACKAGE_PIN H1 IOSTANDARD LVCMOS33} [get_ports {ano[3]}]

set_property -dict {PACKAGE_PIN D5 IOSTANDARD LVCMOS33} [get_ports dot]

set_property -dict {PACKAGE_PIN N5 IOSTANDARD LVCMOS33} [get_ports RX_Serial]
set_property -dict {PACKAGE_PIN T4 IOSTANDARD LVCMOS33} [get_ports TX_Serial]