import sys
import os

remoteip = sys.argv[1]
username = "" if len(sys.argv) <= 2 else sys.argv[2] 
storeFile = "storeRemoteIp.txt"
print "username: " + username + " remoteip: " + remoteip + "\n"
flag = "not exist"
lines = []

if(os.stat(storeFile).st_size != 0):
	file = open(storeFile, "r")
	lines = file.readlines()
	for index,line in enumerate(lines):
		content = line.split(" ")
		if (content[0] == remoteip):
			if (username == "") or (content[1] == username):
				username = content[1]
				flag = "exist"
			else:
				print "remote ip is exist, but the username is not right"
				lines[index] = remoteip + " " + username + "\n"
				flag = "name is not right"
			break
	file.close()
else:
	print "the content of the store file is empty"
wfile = open(storeFile, "w")
if(flag == "not exist"):
	print "remote ip is not exist"
	lines.append(remoteip + " " + username)
for line in lines:
	wfile.write(line)
wfile.close()
result = "false" if (flag != "exist") else "ture"
print "result:" + result + "," + username

