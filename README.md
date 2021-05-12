# mrs-puffs-boarding-school
Repo to hold the code for the EE 532 digital board project--Spring 2021.

## to install all python libraries, run
    python3 -m pip install -r requirements.txt

## outline for the application

Something that would be important for our application is to listen at the same time as
displaying the UI, so I think we will be requiring the use of the multiprocessing
library. On launch, we will spawn a listening thread to listen over uart, and then 
launch the UI itself, which will be in charge of sending the data over UART. 

### TODO:
Joshua and Sebastien: we need to get some sort of standard for communication over UART
(maybe with the use of a stop character?) to the FPGA. We'll need to communicate with 
Aria and Ethan about that. 

DJ and Sebastien: we need to figure out how ^ will be handling the data and the write our 
comparison function in a similar manner. I think it would be best to just have the comparison
function read from a "correct" file with the correct sequence of outputs for a given test.
The generation function, in conjunction with Xander's ui, should create a test vector input
file, so it is saved and can be referenced for later.
