close all;
clear all;

num_inputs_DUT = 4;     %number of inputs the DUT requires
num_test_seqs = 10;     %number of tests the user wants to run

%% generate all possible sequences

sequences = zeros((2^num_inputs_DUT),num_inputs_DUT);

%fill in sequences with binary
if (num_inputs_DUT > 0)
    for i = 2:2:(2^num_inputs_DUT)
        sequences((2^num_inputs_DUT)+2-i,num_inputs_DUT) = 1;
    end   
end

if (num_inputs_DUT > 1)
    for i = 4:4:(2^num_inputs_DUT)
        sequences((2^num_inputs_DUT)+3-i,num_inputs_DUT-1) = 1;
        sequences((2^num_inputs_DUT)+4-i,num_inputs_DUT-1) = 1;
    end   
end

if (num_inputs_DUT > 2)
    for i = 8:8:(2^num_inputs_DUT)
        sequences((2^num_inputs_DUT)+5-i,num_inputs_DUT-2) = 1;
        sequences((2^num_inputs_DUT)+6-i,num_inputs_DUT-2) = 1;
        sequences((2^num_inputs_DUT)+7-i,num_inputs_DUT-2) = 1;
        sequences((2^num_inputs_DUT)+8-i,num_inputs_DUT-2) = 1;
    end   
end

if (num_inputs_DUT > 3)
    for i = 16:16:(2^num_inputs_DUT)
        sequences((2^num_inputs_DUT)+9-i,num_inputs_DUT-3) = 1;
        sequences((2^num_inputs_DUT)+10-i,num_inputs_DUT-3) = 1;
        sequences((2^num_inputs_DUT)+11-i,num_inputs_DUT-3) = 1;
        sequences((2^num_inputs_DUT)+12-i,num_inputs_DUT-3) = 1;
        sequences((2^num_inputs_DUT)+13-i,num_inputs_DUT-3) = 1;
        sequences((2^num_inputs_DUT)+14-i,num_inputs_DUT-3) = 1;
        sequences((2^num_inputs_DUT)+15-i,num_inputs_DUT-3) = 1;
        sequences((2^num_inputs_DUT)+16-i,num_inputs_DUT-3) = 1;
    end   
end

%% generate random Test Vector

range = 1:(2^num_inputs_DUT);   %range of all possible "sequences" indices

%generate desired number of random indices w/o replacement
random_ints = randsample(range,num_test_seqs);  

testVector = zeros(num_test_seqs,num_inputs_DUT);

%generate test vector comprised of random rows of "sequences"
for j = 1:1:num_test_seqs
    testVector(j,:) = sequences(random_ints(j),:);
end
