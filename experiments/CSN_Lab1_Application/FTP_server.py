# server.py
import socket
import os

def send_file(connection, file_path):
    with open(file_path, 'rb') as file:
        connection.sendfile(file)

def server_program():
    host = 'localhost'
    port = 12345

    server_socket = socket.socket()
    server_socket.bind((host, port))
    server_socket.listen(5)
    print(f"服务器在 {host}:{port} 上监听")

    try:
        while True:
            conn, address = server_socket.accept()
            print(f"连接地址：{address}")

            # 接收客户端请求的文件名
            file_name = conn.recv(1024).decode()
            print(f"客户端请求的文件：{file_name}")

            # 检查文件是否存在
            if os.path.isfile(file_name):
                conn.send(b"START")  # 开始传输文件的信号
                send_file(conn, file_name)
                conn.send(b"END")    # 文件传输完毕的信号
            else:
                conn.send(b"ERROR")  # 文件不存在的信号

            conn.close()  # 关闭连接
    except KeyboardInterrupt:
        print("服务器关闭")
    finally:
        server_socket.close()

if __name__ == '__main__':
    server_program()
