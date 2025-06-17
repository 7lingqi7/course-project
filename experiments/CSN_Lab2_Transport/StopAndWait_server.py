import socket
import random

# 设定服务器地址和端口
server_address = ('192.168.3.11', 12345)
# 设定丢包率
packet_loss_rate = 0.5

# 创建一个 UDP 套接字
server_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
# 绑定套接字的地址和端口
server_socket.bind(server_address)

# 显示运行状态
print("Server is running...")

while True:
    # 接收客户端消息,decode转字节串为字符串
    message, client_address = server_socket.recvfrom(1024)
    print(f'Received {message.decode()} from {client_address}')

    # 随机数模拟丢包，大于则接受成功并发送ACK
    if random.random() > packet_loss_rate:
        # 发送 ACK
        server_socket.sendto('ACK'.encode(), client_address)
        print(f'{message.decode()} is successfully transmitted')
    else:
        # 发送丢失哪个包
        print(f'{message.decode()} is lost')
