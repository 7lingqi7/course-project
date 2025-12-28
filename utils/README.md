# Utilities / 工具集

This directory contains utility scripts for various text processing and conversion tasks.

本目录包含各种文本处理和转换任务的实用工具脚本。

## Markdown to Text Converter / Markdown转纯文本工具

### Description / 描述

A Python utility to convert markdown-formatted insurance terms and other documents to plain text format.

一个Python工具，用于将markdown格式的保险条款和其他文档转换为纯文本格式。

### File / 文件

- `markdown_to_text.py` - Main conversion script / 主转换脚本

### Features / 功能

- Removes markdown formatting (headers, bold, italic, links, etc.)
- Converts numbered lists to clean paragraph format
- Preserves Chinese and English text content
- Handles insurance terms and definitions

- 删除markdown格式（标题、粗体、斜体、链接等）
- 将编号列表转换为整洁的段落格式
- 保留中英文文本内容
- 处理保险条款和定义

### Usage / 使用方法

#### Run the script directly / 直接运行脚本

```bash
python3 utils/markdown_to_text.py
```

This will convert the built-in insurance terms and display the plain text output.

这将转换内置的保险条款并显示纯文本输出。

#### Use as a module / 作为模块使用

```python
from utils.markdown_to_text import convert_markdown_to_text, format_insurance_terms

# Convert any markdown text
markdown_text = "# Title\n\n**Bold text** and *italic text*"
plain_text = convert_markdown_to_text(markdown_text)
print(plain_text)

# Format insurance terms specifically
insurance_md = "1. Term definition...\n2. Another term..."
formatted = format_insurance_terms(insurance_md)
print(formatted)
```

### Output Example / 输出示例

The script converts markdown formatted insurance terms like:

脚本将markdown格式的保险条款如：

```markdown
# 第一条：释义

1. "享权人"是指平安健康保单约定的被保险人。  
2. "享权事件"是指本确认函第2.2条规定的享权人有权申请服务的情形和条件。
```

To clean plain text:

转换为整洁的纯文本：

```
第一条：释义

1. "享权人"是指平安健康保单约定的被保险人。

2. "享权事件"是指本确认函第2.2条规定的享权人有权申请服务的情形和条件。
```

### Requirements / 依赖要求

- Python 3.6+
- No external dependencies (uses only standard library)

- Python 3.6+
- 无外部依赖（仅使用标准库）

### Author / 作者

Created for the course-project repository at Shenzhen University Wenhua Honor Class.

为深圳大学文华班课程项目仓库创建。
