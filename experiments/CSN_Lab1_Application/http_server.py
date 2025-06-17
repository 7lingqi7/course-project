import socket

def main():
    # 1. 创建套接字
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    host = ''
    port = 1234  # 使用1234端口，通常使用的8080端口已被占用
    server_socket.bind((host, port))

    # 2. 开始监听端口
    server_socket.listen(1)
    print(f"服务器正在监听端口：{port}")

    while True:
        # 3. 等待客户端连接
        connection_socket, addr = server_socket.accept()
        print(f"收到来自{addr}的连接")

        # 4. 获取HTTP请求并解析文件名
        request = connection_socket.recv(1024).decode()
        filename = request.split()[1][1:]  # [1:]是为了去掉开头的"/"

        try:
            # 5. 从服务器的文件系统中获取请求的文件
            with open(filename, 'rb') as file:
                content = file.read()

            # 6. 创建HTTP响应消息
            response = "HTTP/1.1 200 OK\r\nContent-Length: {}\r\n\r\n".format(len(content)).encode()
            connection_socket.send(response + content)

        except FileNotFoundError:
            # 如果文件不存在，返回404错误
            error_msg = "<html><body><h1>404 Not Found</h1></body></html>".encode()
            response = "HTTP/1.1 404 Not Found\r\nContent-Length: {}\r\n\r\n".format(len(error_msg)).encode()
            connection_socket.send(response + error_msg)

        finally:
            connection_socket.close()

        # 只处理一个请求，然后退出
        break

    server_socket.close()

if __name__ == "__main__":
    main()
