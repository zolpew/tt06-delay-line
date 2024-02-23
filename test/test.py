import cocotb
from cocotb.regression import TestFactory
from cocotb.triggers import RisingEdge

@cocotb.coroutine
def clock_generator(clk, period=10):
    while True:
        clk.value = 0
        yield RisingEdge(clk)
        clk.value = 1
        yield RisingEdge(clk)
        yield cocotb.triggers.Timer(period // 2)

@cocotb.coroutine
def stimulus(ui_in, uio_in):
    yield RisingEdge(ui_in)
    yield cocotb.triggers.Timer(10)
    
    for _ in range(90):
        ui_in.value = cocotb.utils.rand_bitstr(11)
        yield RisingEdge(ui_in)
        yield cocotb.triggers.Timer(10)

@cocotb.coroutine
def run_test(dut):
    cocotb.fork(clock_generator(dut.clk))
    yield stimulus(dut.ui_in, dut.uio_in)
    yield cocotb.triggers.Timer(10)
    raise cocotb.result.TestSuccess("Simulation complete")

# Testbench Factory
tf = TestFactory(run_test)

# You can customize the simulator and add options here if needed
tf.generate_tests()
