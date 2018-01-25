# Config
NODE_ID = 9


# hour,set 0 to disable
SPEEDTEST = 19930827  #测速周期，单位H,与前端一致即可，或者关闭
CLOUDSAFE = 1  
ANTISSATTACK = 0  #改为1则启用防攻击模式
AUTOEXEC = 0      #这个选项如果没有部署自动下发请保持为0，否则改为1

MU_SUFFIX = 'zhaoj.in'
MU_REGEX = '%5m%id.%suffix'

SERVER_PUB_ADDR = '127.0.0.1'  # mujson_mgr need this to generate ssr link
API_INTERFACE = 'modwebapi'  # glzjinmod, modwebapi

WEBAPI_URL = 'https://api.kantianxia.win'  #网站域名，如果开启了cdn，nginx请学习real ip有关知识，保证能正确获取后端IP
WEBAPI_TOKEN = '4hrZTJX2Dr64rhHqBAtDGDNdGZjNV7p8' #随意，与config文件一致

# mudb
MUDB_FILE = 'mudb.json'

# Mysql 使用modwebapi则无需配置
MYSQL_HOST = '127.0.0.1'
MYSQL_PORT = 3306
MYSQL_USER = 'ss'
MYSQL_PASS = 'ss'
MYSQL_DB = 'shadowsocks'

MYSQL_SSL_ENABLE = 0
MYSQL_SSL_CA = ''
MYSQL_SSL_CERT = ''
MYSQL_SSL_KEY = ''

# API
API_HOST = '127.0.0.1'
API_PORT = 80
API_PATH = '/mu/v2/'
API_TOKEN = 'abcdef'
API_UPDATE_TIME = 60

# Manager (ignore this)
MANAGE_PASS = 'ss233333333'
# if you want manage in other server you should set this value to global ip
MANAGE_BIND_IP = '127.0.0.1'
# make sure this port is idle
MANAGE_PORT = 23333

# Safety
IP_MD5_SALT = 'randomforsafety'
