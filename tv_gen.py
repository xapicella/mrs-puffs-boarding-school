from random import randint
from random import seed
from consts import SEEDNUM
import numpy as np
## Functions for generating test vectors



#function randomly generates num_seqs vectors with num_inputs vectors
#returns a list of test vectors in no particular order
def generate_test_vectors(num_inputs,num_seqs):
    seed(SEEDNUM)
    test_vecs = []
    while True:
        for i in range(num_seqs):
            tv = ""
            for j in range(num_inputs):
                tv += str(randint(0,1))

            if not tv in test_vecs:
                #make sure no repeats
                test_vecs.append(tv)
        if len(test_vecs) == num_seqs:
            break;

    print(test_vecs)

if __name__=="__main__":
    generate_test_vectors(2,3)
