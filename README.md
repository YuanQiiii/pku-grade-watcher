# 北京大学成绩监控工具

🎓 一个自动监控北京大学学生成绩变化并发送通知的 Python 工具。

- forked from zhuozhiyongde/pku-grade-watcher
- 如果觉得项目有帮到你，请给原作者点点star。
- 主要改进是在原项目基础上增加了邮箱通知渠道，解决了自部署情形下周期性出现的异常行为，并为之后的拓展设计了基类。

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Python](https://img.shields.io/badge/python-3.7+-green.svg)

## ✨ 特性

- 🔄 **自动监控**: 定期检查成绩更新
- 📱 **多种通知方式**: 支持 Bark 推送、邮件通知、控制台输出
- 🎯 **智能去重**: 自动处理重复修读的课程
- 📊 **详细记录**: 记录历史成绩数据和变化
- ⚙️ **易于配置**: 基于 YAML 的简单配置
- 🔒 **安全可靠**: 本地存储，保护隐私
- 📅 **定时运行**: 支持 crontab 定时任务

## 🚀 快速开始

### 环境要求

- Python 3.7+
- 网络连接

### 安装依赖

```bash
# 克隆项目
git clone <repository-url>
cd pku-grade-watcher

# 安装依赖
pip install -r requirements.txt
```

### 配置设置

1. 复制配置模板：

```bash
cp config_sample.yaml config.yaml
```

2. 编辑 `config.yaml` 文件，填入您的信息：

```yaml
# 北大成绩监控配置文件

# 登录信息（必需）
username: 2100000000  # 您的学号
password: your_password      # 您的密码

# 数据文件路径（可选，默认为 course_data.json）
data_file: course_data.json

# 通知配置
# 支持的通知类型：bark, email, console, multi

# 方式1: 只使用 Bark 推送（推荐）
bark: 'your_bark_token'

# 方式2: 只使用邮件通知
# type: email
# smtp_server: smtp.qq.com
# smtp_port: 587
# email_username: your_email@qq.com
# email_password: your_app_password
# from_email: your_email@qq.com
# to_email: target@example.com

# 方式3: 同时使用多种通知方式
# type: multi
# bark: 'your_bark_token'
# smtp_server: smtp.qq.com
# smtp_port: 587
# email_username: your_email@qq.com
# email_password: your_app_password
# from_email: your_email@qq.com
# to_email: target@example.com

# 方式4: 控制台输出（用于测试）
# type: console
```

### 运行程序

```bash
# 手动运行一次
python main.py

# 或使用提供的脚本
./check.sh
```

## 🔧 通知方式配置

### 1. Bark 推送（推荐）

Bark 是一个简单易用的 iOS 推送服务。

1. 在 App Store 下载 Bark 应用
2. 获取您的推送 token
3. 在配置文件中设置：

```yaml
bark: 'your_bark_token'
```

### 2. 邮件通知

支持各种邮箱服务商的 SMTP 服务。

```yaml
type: email
smtp_server: smtp.qq.com
smtp_port: 587
email_username: your_email@qq.com
email_password: your_app_password  # 使用应用专用密码
from_email: your_email@qq.com
to_email: target@example.com
```

### 3. 多种通知方式

可以同时配置多种通知方式：

```yaml
type: multi
bark: 'your_bark_token'
smtp_server: smtp.qq.com
smtp_port: 587
email_username: your_email@qq.com
email_password: your_app_password
from_email: your_email@qq.com
to_email: target@example.com
```

### 4. 控制台输出

用于调试和测试：

```yaml
type: console
```

## ⏰ 定时运行

### 使用 crontab

编辑 crontab：

```bash
crontab -e
```

添加定时任务（例如每小时检查一次）：

```bash
0 * * * * /home/xianyu/tasks/pku-grade-watcher/check.sh >> /home/xianyu/tasks/pku-grade-watcher/check.log 2>&1
```

### 修改脚本路径

编辑 `check.sh` 文件，修改为您的实际路径：

```bash
#!/bin/bash

# 进入项目目录
cd /path/to/your/pku-grade-watcher || exit

# 使用您的 Python 解释器路径
/path/to/your/python main.py
```

## 📁 项目结构

```text
pku-grade-watcher/
├── main.py              # 主程序入口
├── grade_watcher.py     # 成绩监控核心类
├── notifier.py          # 通知模块
├── models.py            # 数据模型定义
├── config_sample.yaml   # 配置文件模板
├── config.yaml          # 配置文件（需要自己创建）
├── requirements.txt     # Python 依赖
├── check.sh            # 定时运行脚本
├── course_data.json    # 成绩数据文件（自动生成）
├── current.json        # 当前成绩数据（自动生成）
├── check.log          # 运行日志（自动生成）
└── README.md          # 项目说明
```

## 🛡️ 安全说明

- ✅ 所有数据均存储在本地，不会上传到第三方服务器
- ✅ 密码仅用于登录教务系统，不会保存在明文日志中
- ✅ 支持配置文件权限控制，保护敏感信息
- ⚠️ 建议定期更改密码，并确保配置文件安全

## 🔍 功能说明

### 核心功能

1. **自动登录**: 使用学号和密码自动登录北大教务系统
2. **成绩获取**: 自动抓取最新的成绩信息
3. **智能对比**: 与历史数据对比，识别新增和更新的成绩
4. **去重处理**: 自动处理重复修读课程的成绩记录
5. **通知推送**: 当发现成绩变化时，立即发送通知

### 数据处理

- **课程去重**: 基于课程 ID 和学期进行去重，支持重复修读
- **增量更新**: 只处理新增或变化的成绩记录
- **历史记录**: 保留完整的成绩变化历史
- **数据备份**: 自动备份重要数据文件

## 🐛 故障排除

### 常见问题

1. **登录失败**
   - 检查学号和密码是否正确
   - 确认网络连接正常
   - 查看是否需要验证码（目前不支持验证码）

2. **通知发送失败**
   - 检查通知配置是否正确
   - 验证 Bark token 或邮箱设置
   - 查看网络连接是否正常

3. **定时任务不执行**
   - 检查 crontab 配置是否正确
   - 确认脚本路径和 Python 路径
   - 查看系统日志和程序日志
  
4. **log内容为无权限**
   - 使用下面的脚本赋予你的脚本执行权限

```bash
     chmod +x check.sh
```

### 调试方法

1. **手动运行**: 先手动运行程序，确认基本功能正常
2. **日志查看**: 检查 `check.log` 文件中的运行日志
3. **配置验证**: 使用控制台输出模式测试配置
4. **逐步调试**: 逐一测试登录、获取数据、通知等功能

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

1. Fork 本项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📄 许可证

本项目采用 MIT 许可证。详见 [LICENSE](LICENSE) 文件。

## ⚠️ 免责声明

- 本工具仅供学习和个人使用
- 请遵守学校相关规定，合理使用教务系统
- 使用本工具产生的任何问题，作者不承担责任
- 请保护好个人账号信息，注意网络安全
