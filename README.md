# Asynchronous Architecture

In Asynchronous architecture, the global clock is designed to be dependent on the process the processor is asked to do. We designed a processor in which every elementary operation which requires clock triggering (in the case of synchronous processors) happens with handshaking protocol. This architecture has a clear edge over its synchronous counterpart in terms of speed and power efficiency (proved through simulaiotns for a specific case as explained below)

## A small-scale implementation of asynchronous repeated-multiplication operation. 

### Following is the process flow: 

1. Data (given through cache testbench) are stored in cache. 
2. When multiplication operation is requested (through cache testbench), operands (two data stored in different locations in cache) are sent to registers A and B. 
3. The data of registers A and B are further passed on to the multiplier which multiplies the operands and sends out the result (temporary) into a register C.
4. Step 3 is repeated with data coming from register A and C. 
5. Final result of multiplication is copied from the register C to a location in cache.

Each step above happens sequentially, one after the other, using Handshaking Protocol.

#### For working codes, please go to [Working codes](https://github.com/cao-track-4-codes/Async_processor/tree/end-of-project-working-codes). The main module is not working as of now. We're still debugging the code.

Other branches are maintained for debugging purposes. Please ignore them.

## Aim

Our main aim is to implement pipelining based asynchronous architecture and compare its performance with that of synchronous architecture. 

