from vnctpmd import MdApi
from vnctptd import TdApi


md = MdApi()
td = TdApi()

print("MdApi Version:" + md.getApiVersion())
print("TdApi Version:" + td.getApiVersion())
