#!/usr/bin/sh

if [ $# -ne 2 ]
then
	echo "脚本使用："
	echo "用法：$(basename $0)	旧项目名称	新项目名称"
	echo "例如：$(basename $0)	Test-V01	Test-V02"
	exit 0
fi

if [ -d $2 ]
then
	echo "已存在文件夹 $2 ！"
	echo -n "请确认是否需要删除文件夹 $2 ？（Y/N）"
	read choose
	case $choose in 
		y|Y)
			echo "---------------------------"
			echo "开始删除文件夹..."
			rm -rf $2
			echo "文件夹删除完毕！"
			echo "---------------------------"
			break
			;;
		*)
			echo "文件夹不删除！脚本退出，感谢您的使用！~~"
			exit 0
			break
			;;
	esac
fi

echo "---------------------------------------------------"
echo "[$(date +%Y-%m-%d\ %H:%M:%S)] -> 复制 $1 到 $2 ..."
cp -R $1 $2
echo "[$(date +%Y-%m-%d\ %H:%M:%S)] -> 复制完毕！"
echo "---------------------------------------------------"

cd $2

echo "[$(date +%Y-%m-%d\ %H:%M:%S)] -> 开始修改相关文件名..."
for file in $(ls *$1*); do mv $file $(echo $file |sed "s/$1/$2/Ig"); done
echo "[$(date +%Y-%m-%d\ %H:%M:%S)] -> 相关文件名修改完毕！"
echo "---------------------------------------------------"
echo "[$(date +%Y-%m-%d\ %H:%M:%S)] -> 开始修改相关文件内容..."
sed -i "s/$1/$2/Ig" *$2*
echo "[$(date +%Y-%m-%d\ %H:%M:%S)] -> 相关文件内容修改完毕！"
echo "---------------------------------------------------"
echo "感谢使用本脚本，再见！~~"
exit 0


