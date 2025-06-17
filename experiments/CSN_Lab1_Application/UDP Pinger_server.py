import socket
import random

# 服务器的IP地址和端口号
serverIP = "127.0.0.1"
serverPort = 12000

# 创建UDP套接字
serverSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# 将套接字绑定到地址
serverSocket.bind((serverIP, serverPort))

print(f"UDP服务器正在监听地址 {serverIP} 的端口 {serverPort}")

# 服务器循环
while True:
    message, clientAddress = serverSocket.recvfrom(1024)
    modifiedMessage = message.decode()

    # 随机决定是否响应
    if random.randint(0, 10) < 8:  # 有80%的概率响应
        serverSocket.sendto(modifiedMessage.encode(), clientAddress)
