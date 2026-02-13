# FPGA Basic Development Guide

## Table of Contents
- [Introduction](#introduction)
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Vivado Workflow](#vivado-workflow)
- [HDL Basics](#hdl-basics)
- [Simulation](#simulation)
- [Synthesis & Implementation](#synthesis--implementation)
- [Resources](#resources)

##

This repository contains FPGA development projects using Xilinx Vivado. FPGA (Field-Programmable Gate Array) development involves designing digital circuits using Hardware Description Languages (HDL) and implementing them on programmable hardware.

## Getting Started

### What You'll Learn
- FPGA design fundamentals
- Verilog/VHDL HDL programming
- Vivado project creation and management
- Simulation and debugging
- Synthesis and implementation
- Programming FPGA boards

## Prerequisites

### Software Requirements
- **Xilinx Vivado Design Suite** (Free Webpack Edition available)
  - Download: https://www.xilinx.com/products/design-tools/vivado.html
- **Required Tools:**
  - Vivado HLx Suite
  - Vivado Lab Tools (for programming)
  - Git (version control)

### Hardware Requirements (Optional)
- FPGA Development Board (e.g., Xilinx Basys 3, Arty)
- USB cable for board programming
- External peripherals as needed

## Project Structure

```
vivado_FPGA/
├── README.md                 # This file
├── src/                      # Source HDL files
│   ├── rtl/                 # RTL (Register Transfer Level) Verilog/VHDL
│   ├── tb/                  # Testbenches for simulation
│   └── constraints/         # XDC constraint files
├── projects/                # Vivado project files
├── docs/                    # Documentation
└── scripts/                 # Build and automation scripts
```

## Vivado Workflow

### 1. Create a New Project
```bash
# In Vivado GUI:
File → New Project → Configure project settings
```

### 2. Add Source Files
- Create or import `.v` (Verilog) or `.vhd` (VHDL) files
- Add constraint files (`.xdc` for pin assignments)

### 3. Run Behavioral Simulation
- Set testbench as top module
- Run simulation to verify functionality

### 4. Synthesis
- Converts RTL to gate-level netlist
- Check for timing issues

### 5. Implementation
- Place and Route (P&R) - maps design to FPGA resources
- Generate bitstream

### 6. Programming
- Download bitstream to FPGA device
- Verify functionality on hardware

## HDL Basics

### Verilog Example - Simple Counter

```verilog
module counter (
    input clk,
    input reset,
    output reg [7:0] count
);

always @(posedge clk) begin
    if (reset)
        count <= 8'b0;
    else
        count <= count + 1;
end

endmodule
```

### VHDL Example - Simple Counter

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
    Port (
        clk   : in STD_LOGIC;
        reset : in STD_LOGIC;
        count : out STD_LOGIC_VECTOR(7 downto 0)
    );
end counter;

architecture Behavioral of counter is
    signal count_reg : unsigned(7 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                count_reg <= (others => '0');
            else
                count_reg <= count_reg + 1;
            end if;
        end if;
    end process;
    
    count <= std_logic_vector(count_reg);
end Behavioral;
```

## Simulation

### Writing a Testbench (Verilog)

```verilog
module tb_counter;
    reg clk, reset;
    wire [7:0] count;
    
    counter uut (
        .clk(clk),
        .reset(reset),
        .count(count)
    );
    
    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;
        #200 $finish;
    end
    
    always #5 clk = ~clk;  // 10ns period clock
endmodule
```

### Running Simulation in Vivado
1. Right-click testbench → Set as Top
2. Run → Run Behavioral Simulation
3. View waveforms in Wave window

## Synthesis & Implementation

### Synthesis
- Converts Verilog/VHDL to hardware primitives
- Checks for timing violations
- Reports resource utilization

### Implementation
- **Place & Route:** Maps logic to FPGA fabric
- **Bitstream Generation:** Creates programming file

### Monitoring Progress
- Check Vivado console for warnings/errors
- Review timing reports for critical paths
- Verify resource utilization

## Common Design Patterns

### Finite State Machine (FSM)
```verilog
always @(posedge clk) begin
    case(state)
        IDLE: if (start) state <= ACTIVE;
        ACTIVE: if (done) state <= IDLE;
    endcase
end
```

### Pipelined Operations
- Register intermediate results
- Improve throughput at cost of latency

### Synchronizers
- Use for clock domain crossing
- Prevent metastability issues

## Debugging Tips

1. **Simulation First** - Test thoroughly before synthesis
2. **Check Constraints** - Verify all pins and timing constraints
3. **Incremental Builds** - Start simple and add complexity
4. **Timing Analysis** - Monitor slack on critical paths
5. **Resource Reports** - Verify LUT/FF/BRAM usage

## Resources

### Learning Materials
- [Xilinx Vivado Documentation](https://docs.xilinx.com/)
- [Verilog HDL Reference](https://en.wikipedia.org/wiki/Verilog)
- [VHDL Language Reference](https://en.wikipedia.org/wiki/VHDL)

### Development Boards
- Xilinx Basys 3
- Xilinx Arty Series
- Intel/Altera DE series

### Useful Tools
- **ModelSim** - Advanced simulation (Vivado included)
- **GTKWave** - Free waveform viewer
- **Yosys** - Open-source synthesis

## Quick Start Checklist

- [ ] Install Vivado Design Suite
- [ ] Install your FPGA board drivers
- [ ] Create first Vivado project
- [ ] Write simple counter module
- [ ] Create and run testbench
- [ ] Run synthesis and implementation
- [ ] Program FPGA board (optional)
- [ ] Experiment with different designs

---

**Last Updated:** February 2026
**License:** Open Source (MIT)

For questions or contributions, please refer to project documentation.