class PcraftPacket:
    def __init__(self, packet_type="custom", packet_data=None, new_sleep_cursor=0):
        self.packet_type = packet_type
        self.packet_data = packet_data
        self.new_sleep_cursor = new_sleep_cursor

