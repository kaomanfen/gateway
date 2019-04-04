--
-- Created by IntelliJ IDEA.
-- User: shuaijinchao
-- Date: 2019/1/28
-- Time: 7:23 PM
-- To change this template use File | Settings | File Templates.
--

local _M = {}

-- 环境配置（test、beta、prod）
_M.env = os.getenv('ENV')

-- MySQL配置
_M.mysql = {
    db_host = os.getenv('DB_HOST'),
    db_port = os.getenv('DB_PORT'),
    db_user = os.getenv('DB_USER'),
    db_password = os.getenv('DB_PASSWORD'),
    db_name = os.getenv('DB_NAME'),
    db_timeout = 10000,
    db_charset = 'utf8',
}

return _M
