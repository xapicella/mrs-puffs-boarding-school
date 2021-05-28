from communicate import send_uart, serial_ports, read_word, send_to_mem
from consts import CMD_RESET_ON,CMD_RESET_OFF,CMD_WRITE_MEM, APPLY_CMD_CKSUM



if __name__ == "__main__":
    values = [0,1,2,3,4]
    send_to_mem(values)

    '''print(serial_ports())
    int_val = 0xdeadbeef
    int_len = 5
    endian = "big"
    value = []
    value.append(int(APPLY_CMD_CKSUM(CMD_RESET_ON)).to_bytes(4,endian))#enter reset state
    print(APPLY_CMD_CKSUM(CMD_RESET_ON))
    device = send_uart(value,len(value),device=None)
    #print("return code: " + hex(int.from_bytes(read_word(device),endian)))
    #print("return code: " + str(int.from_bytes(read_word(device),endian)))
    value = []
    value.append(int(APPLY_CMD_CKSUM(CMD_WRITE_MEM)).to_bytes(4,endian)) #apply write command
    send_uart(value,len(value),device)
    value = []
    value.append(int(2).to_bytes(4,endian))
    value.append(int(int_len).to_bytes(4,endian))
    for i in range(int_len):
        value.append(int(int_val).to_bytes(4,endian))
    value.append(int(APPLY_CMD_CKSUM(CMD_RESET_OFF)).to_bytes(4,endian))#exit reset state
    print(value)
    send_uart(value,len(value),device)'''
    
