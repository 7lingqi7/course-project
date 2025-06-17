# client.py
import socket

def receive_file(socket):
    with open("received_file", "wb") as file:
        while True:
            data = socket.recv(1024)
            if data.endswith(b"END"):
                file.write(data[:-3])  # 去除结束信号，写入剩余部分
                break
            if data == b"ERROR":
                print("文件不存在于服务器")
                file.close()
                os.remove("received_file")  # 如果文件不存在则删除已创建的空文件
                break
            file.write(data)

def client_program():
    host = 'localhost'
    port = 12345

    client_socket = socket.socket()
    client_socket.connect((host, port))

    file_name = input("请输入想要下载的文件名: ")
    client_socket.send(file_name.encode())

    server_response = client_socket.recv(5)
    if server_response == b"START":
        print("开始接收文件.....")
        receive_file(client_socket)
        print("文件接收完毕")
    elif server_response == b"ERROR":
        print("服务器上不存在该文件")

    client_socket.close()

if __name__ == '__main__':
    client_program()
