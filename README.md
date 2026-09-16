# Maat：Go 后端工程手册

> 定义什么是正确，并作为质量门禁的标尺。

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-green.svg)](./LICENSE)
[![Language: Markdown](https://img.shields.io/badge/Language-Markdown-blue)](./README.md)
[![Docs: 18 chapters](https://img.shields.io/badge/Docs-18%20chapters-orange)](./README.md)

Maat 是面向 Go 后端团队的工程手册，定义命名、设计、编码、测试、错误处理、性能、可观测性、重构与质量门禁的统一标准。全部内容以可执行、可检查的规则写成，可直接用于日常开发、Code Review 和 CI 门禁。

适用对象：

- Go 后端团队的日常开发与 Code Review
- 新项目的工程规范初始化
- 存量系统的重构与质量治理

内容范围：

- 命名、设计、函数设计、封装与抽象
- 测试、错误处理、性能、可观测性
- 质量门禁、重构流程、综合检查清单
- 中文技术文档与工程写作规范

快速入口：

- 在线阅读：[Maat Wiki](https://github.com/omeyang/Maat/wiki)，与仓库章节同步
- 从下方文档索引按主题阅读
- 新团队落地时，优先阅读 [02-design-principles.md](./02-design-principles.md)、[03-coding-checklist.md](./03-coding-checklist.md)、[04-testing-standards.md](./04-testing-standards.md) 和 [13-quality-gates.md](./13-quality-gates.md)
- 做文档治理时，配合 [10-documentation-standards.md](./10-documentation-standards.md) 和 [10A-chinese-writing-style.md](./10A-chinese-writing-style.md) 使用

## 文档索引

| 编号 | 文档 | 说明 |
|------|------|------|
| 01 | [命名准则](./01-naming-conventions.md) | 包、文件、类型、函数、变量的命名规范 |
| 02 | [设计准则](./02-design-principles.md) | 四层架构、模块化、面向接口、避免过度设计 |
| 03 | [编码自检清单](./03-coding-checklist.md) | 代码提交前、Code Review、重构的检查清单 |
| 04 | [测试标准](./04-testing-standards.md) | TDD 流程、覆盖率要求、Mock 策略、表驱动测试 |
| 05 | [错误处理与健壮性](./05-error-handling.md) | 错误包装、边界条件、防御式编程、并发安全、优雅降级 |
| 06 | [接口设计](./06-interface-and-abstraction.md) | 小接口原则、抽象时机、泛型使用、抽象层次 |
| 07 | [可观测性](./07-observability.md) | 可测试性、日志、监控、追踪、可读性 |
| 08 | [性能标准](./08-performance.md) | 数据库优化、缓存策略、并发优化、内存优化 |
| 09 | [文件与包设计](./09-file-and-package-design.md) | 文件规模、包组织、依赖管理、目录结构 |
| 10 | [文档书写标准](./10-documentation-standards.md) | 技术文档的 12 项核心原则与书写规范 |
| 10A | [中文技术写作规范](./10A-chinese-writing-style.md) | 标点、括号、链接、术语一致性、常见错误、自动化工具 |
| 11 | [设计模式参考](./11-design-patterns-reference.md) | 可靠性、性能、创建型、结构型、行为型模式索引 |
| 12 | [重构流程准则](./12-refactoring-guide.md) | 7 步重构流程、兼容性保证、灰度发布、回滚策略 |
| 13 | [质量门禁](./13-quality-gates.md) | 静态分析、复杂度控制、覆盖率、安全检查、CI/CD 集成 |
| 14 | [综合检查清单](./14-comprehensive-checklist.md) | 整合所有标准的分层检查清单与命令速查表 |
| 15 | [函数设计规范](./15-function-design.md) | 函数职责、CQS、参数设计、Guard Clause、组合拆分 |
| 16 | [封装与信息隐藏](./16-encapsulation.md) | 导出决策、结构体设计、包 API 面积控制、构造函数设计 |
| 17 | [内聚耦合度量](./17-cohesion-coupling.md) | 内聚判定、耦合度量、解耦策略、边界设计、依赖方向 |
| 18 | [质量意识](./18-quality-mindset.md) | 六大质量维度、质量权衡、业务抽象、挑战现状 |

## 关键词约定

本手册中的关键词"**必须**"、"**禁止**"、"**应该**"、"**不应该**"和"**可以**"按照 [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt) 中的描述进行解释。

## 适用范围

Maat 适用于所有 Go 后端项目的开发、重构和 Code Review，是团队统一的工程质量标准。

## 名字由来

Maat（玛阿特）是古埃及神话中真理、秩序与法则的化身。在冥界称心的审判中，天平一端是逝者的心，另一端是 Maat 的羽毛，心比羽毛重者不得通行。

本手册的角色与之相同：它不是建议，而是标尺。代码是否能进入主干，以 Maat 中的规则为准。

## 仓库结构

- 根目录下的编号 Markdown 文件是手册正文，编号即阅读顺序
- [Wiki](https://github.com/omeyang/Maat/wiki) 由 `scripts/sync-wiki.sh` 从正文生成，不要直接在 Wiki 上编辑
- [CONTRIBUTING.md](./CONTRIBUTING.md) 说明贡献流程

## 贡献方式

欢迎通过 Issue 或 Pull Request 持续完善 Maat。提交前请先阅读 [CONTRIBUTING.md](./CONTRIBUTING.md)。

## 许可协议

本文档采用 [CC BY 4.0](./LICENSE) 许可协议发布。
