import socket
import datetime

# 设定服务器地址和端口
server_address = ('192.168.3.11', 12345)
# 自由设定数据包数量
num_packets = 100

# 创建一个 UDP 套接字
client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
# 设置套接字超时
client_socket.settimeout(1)

# 初始化统计数据
sent_packets = 0
lost_packets = 0
rtt_list = []

# 发送数据包
for i in range(num_packets):
    # 定义数据包为Packet x
    message = f'Packet {i}'
    start_time = datetime.datetime.now()
    print(f'Sending packet {i}...')
    while True:
        try:
            # 发送消息到服务器
            client_socket.sendto(message.encode(), server_address)
            sent_packets += 1

            # 尝试接收服务器响应
            _, _ = client_socket.recvfrom(1024)
            end_time = datetime.datetime.now()
            rtt = (end_time - start_time).total_seconds()
            rtt_list.append(rtt)
            print(f'Received ACK for {message} with RTT {rtt:.2f}s')
            break
        except socket.timeout:
            print(f'Timeout for {message}, resending...')
            lost_packets += 1

# 计算丢包率和平均 RTT
loss_rate = lost_packets / sent_packets
avg_rtt = sum(rtt_list) / len(rtt_list) if rtt_list else 0  # 避免空列表和除0

# 输出实验相关数据丢包率、平均时延、发包总时间
print(f'Packet loss rate: {loss_rate:.2%}')
print(f'Average RTT: {avg_rtt:.2f}s')
print(f'Total time{sum(rtt_list):.2f}s')

# 关闭套接字
client_socket.close()
