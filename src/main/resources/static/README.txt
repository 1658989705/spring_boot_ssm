
牛耳学员管理系统

技术栈:
h-ui + jquery + spring boot + mybatis + mysql

1.导入工程

2.执行 db/newersms.sql
  检查 application.yml 中的数据库用户名和密码

3.启动 com.newer.sms.Application

4.cmd: live-server
  Chrome: http://127.0.0.1:8080/index.html

-----------------------------------------------
前后端分离:
  1.运行后端服务器 - 启动Spring Boot - com.newer.sms.Application
  2.运行前端服务器 - 启动live-server (webfrontend目录下) - 浏览器访问 http://127.0.0.1:8080


前后端不分离:
  1.把 webfrontend 目录复制到 resources 下更名为 static
  2.运行后端服务器 - 启动Spring Boot - com.newer.sms.Application
  3.浏览器访问 http://127.0.0.1:8086/index.html
-----------------------------------------------



开发步骤:
1.实体类: com.newer.sms.domain
2.映射器接口: com.newer.sms.mapper
  映射器文件: resources/mybatis/mapper/*.xml
3.业务逻辑类: com.newer.sms.service
4.控制器类: com.newer.sms.controller

5.配置类: com.newer.sms.config
  工具类: com.newer.sms.util

6.html + css + js + images


Spring Security 是一个专门针对基于Spring项目的安全框架，主要是利用了AOP来实现的
采用Token(令牌)进行鉴权 - jwt

jwt是Json Web Token的缩写,是基于 RFC 7519标准定义的一种可以安全传输的小巧和自包含json对象。由于数据使用数字签名的，所有是可信任和安全的。
jwt可以使用hmac算法对secret进行加密或者使用rsa的公钥私钥进行签名

jwt的工作流程:
1.用户导航到登录页，输入用户名和密码进行登录
2.服务器验证登录鉴权(如果用户合法，根据用户的信息和服务器的规则生产jwt token - 令牌)
3.服务器将该token以json形式返回
4.用户得到token，存在localStorage/cookie或其它数据存储形式中
5.以后用户请求受保护的api时，在请求的header中加入 Authorization: Bearer xxx(token)
6.服务器端对此token进行检验，如果合法就解析其中内容，根据其拥有的权限和自己的业务逻辑给出对应的响应结果
7.用户取得结果



将Redis作为二级缓存
0.从QQ群下载解压 redis.zip - 启动redis服务器: redis-server
1.pom.xml中增加redis的依赖
  <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-data-redis</artifactId>
  </dependency>

2.application.properties中增加redis配置
  Spring Boot会在侦测到存在Redis的依赖并且Redis的配置是可用的情况下，使用RedisCacheManager初始化CacheManager

  # redis ip & port
  redis:
    host: 127.0.0.1
    port: 6379
    jedis:
      pool:
        min-idle: 0
        max-idle: 8
        max-active: 8
        max-wait: -1ms

3.util:ApplicationContextHolder + RedisCache
4.映射器接口: @CacheNamespace(implementation = com.newer.sms.util.RedisCache.class)
  映射文件 : <cache type="com.newer.sms.util.RedisCache"/>

  select:
  @Options(useCache = true, flushCache = Options.FlushCachePolicy.FALSE, timeout = 10000)
  insert update delete:
  @Options(flushCache = Options.FlushCachePolicy.TRUE, timeout = 20000)
5.在Spring Boot主类 Application 中增加@EnableCaching注解开启缓存功能
6.JUnit



Mybatis的二级缓存原理:Mybatis的二级缓存可以自动地对数据库的查询做缓存，并且可以在更新数据时同时自动地更新缓存。

实现Mybatis的二级缓存很简单，只需要新建一个类实现org.apache.ibatis.cache.Cache接口即可。
该接口共有以下五个方法：

String getId()：mybatis缓存操作对象的标识符。一个mapper对应一个mybatis的缓存操作对象。
void putObject(Object key, Object value)：将查询结果塞入缓存。
Object getObject(Object key)：从缓存中获取被缓存的查询结果。
Object removeObject(Object key)：从缓存中删除对应的key、value。只有在回滚时触发。一般我们也可以不用实现，具体使用方式请参考：org.apache.ibatis.cache.decorators.TransactionalCache。
void clear()：发生更新时，清除缓存。
int getSize()：可选实现。返回缓存的数量。
ReadWriteLock getReadWriteLock()：可选实现。用于实现原子性的缓存操作

tips: 修改密码后需等缓存失效超时后,再重新登录