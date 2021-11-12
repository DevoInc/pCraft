class PcraftPacket:
    def __init__(self, packet_type="custom", packet_data=None, new_sleep_cursor=0):
        self.packet_type = packet_type
        self.packet_data = packet_data
        self.new_sleep_cursor = new_sleep_cursor

    def __iter__(self):
        return self
        
    def get_packet_type(self):
        return self.packet_type

    def get_packet_data(self):
        return self.packet_data

    def get_new_sleep_cursor(self):
        return self.new_sleep_cursor
    
