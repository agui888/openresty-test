--单个请求内多个阶段如何共享变量
--ngx.ctx  可以共享，是一个table
--单个请求内的 rewrite (重写)，access (访问)，和 content (内容) 等各处理阶段是保持一致的。


--每个请求，包括子请求，都有一份自己的 ngx.ctx 表。