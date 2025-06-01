$source = "D:/ProducApp"
$user = "yuliana"
$ip = "145.223.79.134"
$port = 22
$remote_path = "/home/yuliana/producapp"

scp -P $port -r $source/* "$user@$ip:$remote_path"
