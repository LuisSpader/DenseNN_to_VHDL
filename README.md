# DenseNN to VHDL
![alt text for screen readers](./framework_workflow_2.png "Framework Workflow").

 This repository is a framework to generate a Hardware Description Language (HDL) in VHDL language for Artificial Neural Network Accelerators, from 3 input formats possibilities: 
 - 1) ONNX input format (not finished).
 - 2) Adjustable parameter configurations (Website or Python dictionary):
   - Number of layers
   - Number of neurons in each layer
   - Bit width
   - Activation Function from each layer
   - Adder achitecture (not finished): '+' operator, Carry-select Adder, Compressor-adder, YOUR OWN ADDER IMPLEMENTATION
   - Multiplier achitecture (not finished): '*' operator, Baugh-Wooley, Booth, Shift-operations, YOUR OWN MULTIPLIER IMPLEMENTATION
   - Generic vs fixed weight implementation
  *As a open-source code, you can implement new architectures as: MAC (Multiply-and-accumulate), Activation-functions
------------------------
Web framework link: https://luisspader-nn-generator-python-scriptweb-all-nn-a0dmc8.streamlit.app/ 
------------------------
Work in progress!!

Author & Copyright: Luis Antonio Spader Simon
