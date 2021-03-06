title=对于J2EE架构以及开发流程的一些感想
date=2015-03-02
type=post
tags=架构,java
status=published
~~~~~~

工作好久，也接触过不同架构和框架，多少有些感触，总结一下如下：

 * 开发阶段，能够让开发人员快速上手，不能有太高的学习成本，最好是常用的Struts，spring，mybatis，hibernate等常用开源框架。提倡不要重复造轮子，最理想情况是升级改造！
 * 开发工具能够支持代码规范的自动检查，报错。
 * 有持续集成环境不断验证服务，必须有测试用例验证，并且验证代码是否符合规范，不符合规范报错，另外还要做代码覆盖率，注释检查等。做到错误提前发现
 * 功能交付前要有代码review
 * 测试以及交付阶段产生的功能需求必须跟踪
 * 开发过程中遇到的问题和解决方案要沉淀，文档必须迭代。发挥文档应有的功能价值。
 * 开发完成后，产品发布时自动发布成分布式或者集群式。开发不用关心如何部署。
 * 架构要支持HA，支持故障迁移，支持动态可伸缩
 * 产品交付阶段能够实时了解运行情况，监视实时动态，包含服务健康以及服务负载等指标，最好是图形化展示
 * 对于不同的项目一定要有协同看板，让团队知道团队的总体目标，让团队成员明确自己的任务，一个任务要具体人员，以及交付时间，以及交付产物有哪些!并且这些产物都是可以验证和review的。在一个固定的周期内要评审回顾。建议以敏捷的方式操作
 * 对于项目或者产品研发一定要明确不同角色的具体的流程，流程一定要管控死，流程可以根据迭代情况不断调整，但是调整前必须严格执行。否则就会有破窗效应，影响后续计划的执行，降低流程的执行效率。对于流程中的问题一定要及时弥补和反应，否则也会引起不好的后果。
 * 测试要自动化，部署自动化，运维要自动化，尽量减少人工干预，人可以在所有流程环节中，可以设置为最不可信任节点，有可以机器代替的尽量机器执行，做到高度自动化，高度可靠，高度量化！