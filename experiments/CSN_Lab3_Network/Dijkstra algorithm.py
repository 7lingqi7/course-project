import heapq

# 实现Dijkstra算法来找到图中从起始节点到所有其他节点的最短路径
# 通过start_node设置初始节点
# 通过graph设置输入网络节点拓扑
def dijkstra(edges, start):
    # 创建一个优先队列和距离字典
    queue = [(0, start, [])]  # 路径是一个列表
    distances = {start: 0}  # 起始节点到自己的距离是0
    paths = {start: [start]}  # 起始节点的路径是它自己

    while queue:
        # 获取距离最小的节点，即队列的第一个节点
        (cost, node, path) = heapq.heappop(queue)
        # 遍历节点的所有邻居
        for next_node, distance in edges.get(node, {}).items():
            # 计算到下一个节点的新距离
            new_cost = cost + distance
            # 如果下一个节点未被访问过，或者新计算的距离更短
            if next_node not in distances or new_cost < distances[next_node]:
                # 更新到下一个节点的最短距离
                distances[next_node] = new_cost
                # 更新到下一个节点的最短路径
                paths[next_node] = path + [node, next_node]
                # 将下一个节点和新的距离添加到队列中
                heapq.heappush(queue, (new_cost, next_node, path + [node]))

    return distances, paths

# 定义网络拓扑，通过改变字典的值来计算其他的网络拓扑
topology = {
    0: {1: 1, 3: 6},
    1: {0: 1, 2: 3, 3: 4},
    2: {1: 3, 3: 2, 4: 6},
    3: {0: 6, 1: 4, 2: 2, 4: 9, 5: 2},
    4: {2: 6, 3: 9},
    5: {3: 2}
}

# 指定起始节点，并运行Dijkstra算法
start_node = 0
distances, paths = dijkstra(topology, start_node)

# 输出从起始节点到每个节点的最短距离和路径
print(f"节点{start_node}到其他节点的距离列表和路径：")
for node in sorted(topology):
    print(f"从节点 {start_node} 到节点 {node} 的最短距离是: {distances[node]} 最短路径是: {' -> '.join(map(str, paths[node]))}")

