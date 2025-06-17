# 定义网络拓扑，用字典形式表示，键是节点，值是另一个字典，包含相邻节点及其成本
topology = {
    '0': {'1': 1, '3': 6},
    '1': {'0': 1, '2': 3, '3': 4},
    '2': {'1': 3, '3': 6, '4': 6},
    '3': {'0': 6, '1': 4, '2': 6, '4': 9, '5': 2},
    '4': {'2': 6, '3': 9},
    '5': {'3': 2}
}
# 更改末尾的输出值即可得到不同节点的距离和路径

# 初始化每个节点的路由表
routing_tables = {node: {neighbour: (cost, neighbour) for neighbour, cost in neighbours.items()} for node, neighbours in topology.items()}

# 定义一个函数，用于更新一个节点的路由表
def update_routing_table(node):
    # 创建当前节点路由表的一个副本以便迭代
    current_table = routing_tables[node].copy()
    for neighbour, (cost_to_neighbour, _) in current_table.items():
        # 仍然从原始的路由表中读取邻居的信息
        for dest, (neighbour_cost_to_dest, _) in routing_tables[neighbour].items():
            new_cost = cost_to_neighbour + neighbour_cost_to_dest
            if dest not in routing_tables[node] or new_cost < routing_tables[node][dest][0]:
                # 直接在原始路由表中更新
                routing_tables[node][dest] = (new_cost, neighbour)


# 定义一个函数，对所有节点迭代并更新它们的路由表
def iterate_routing_tables():
    for node in topology:
        update_routing_table(node)

# 定义一个函数，打印从一个节点到所有其他节点的距离和路径
def print_routing_table_for_node(start_node):
    print(f"节点 {start_node} 的路由表：")
    for dest, (cost, next_hop) in routing_tables[start_node].items():
        path = [start_node]
        while next_hop != dest:
            path.append(next_hop)
            next_hop = routing_tables[next_hop][dest][1]
        path.append(dest)
        print(f"到节点 {dest} 的距离是 {cost}, 路径：{' -> '.join(path)}")

# 运行算法直至收敛
previous_routing_tables = None
while routing_tables != previous_routing_tables:
    previous_routing_tables = {node: routing_tables[node].copy() for node in routing_tables}
    iterate_routing_tables()

# 输出指定节点的路由表
print_routing_table_for_node('5')

