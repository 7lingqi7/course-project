import socket
import datetime
import statistics

# 服务器的IP地址和端口号
serverIP = "127.0.0.1"
serverPort = 12000

# 创建UDP客户端套接字
clientSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# 设置套接字的超时时间
clientSocket.settimeout(1)

# 用于存储RTT的列表
RTTS = []

# 向服务器发送10个ping消息
for i in range(1, 11):
    send_time = datetime.datetime.now()
    message = f'Ping {i} {send_time.strftime("%Y-%m-%d %H:%M:%S")}'

    try:
        # 发送包含ping消息的UDP数据包
        clientSocket.sendto(message.encode(), (serverIP, serverPort))

        # 接收服务器的响应
        modifiedMessage, serverAddress = clientSocket.recvfrom(1024)

        # 计算并打印RTT
        RTT = datetime.datetime.now() - send_time
        print(f"收到的消息: {modifiedMessage.decode()}")
        print(f"RTT: {RTT.total_seconds()} 秒\n")
        RTTS.append(RTT.total_seconds())

    except socket.timeout:
        print("请求超时\n")

# 打印统计信息
if RTTS:
    print(f"平均RTT: {statistics.mean(RTTS)} 秒")
else:
    print("没有可用的RTT。所有请求都超时了")

# 关闭套接字
clientSocket.close()