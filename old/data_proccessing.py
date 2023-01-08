import json
import csv
import time
import uuid

# 确定当前时间 格式为202111，化为int，后续比较用
cur_time = int(time.strftime("%Y%m", time.localtime()))

# 读取csv中用户数据，以后此步使用数据库读取代替
user_information = csv.reader(open('user_information.csv', 'r'))

# 读取空json数据 并向其中添加用户配置数据
with open("empty_config.json", 'r') as jsondata:
    load_data = json.load(jsondata)
jsondata.close()
# 确保配置项已经被清空
load_data['inbounds'][0]['settings']['clients'].clear()

# 读出每项记录处理
all_data = []
for record in user_information:
    all_data.append(record)
    record_dict = {}
    if record[3] == 'inf' or int(record[3]) >= cur_time:
        print(record[2] + ' ' + 'is passed by the test!')
        record_dict['id'] = record[1]
        record_dict['alterId'] = int(record[0])
        load_data['inbounds'][0]['settings']['clients'].append(record_dict)
    else:
        print(record[2] + ' ' + 'is out of date!!')
        new_id = str(uuid.uuid4())
        record_dict['id'] = new_id
        record_dict['alterId'] = int(record[0])
        load_data['inbounds'][0]['settings']['clients'].append(record_dict)

with open('config.json', 'w') as f:
    json.dump(load_data, f)
f.close()
