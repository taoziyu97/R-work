进入需要提取文件名的目录下
```
(wes) [somebody@HPC-login sra]$ for i in * .sra;do basename $i .sra;done > id.txt
(wes) [somebody@HPC-login sra]$ head id.txt
```
准备以下3个文件
```
(wes) [somebody@HPC-login sra2fastq]$ ls
id.csv  mappfile  temple.pbs
```
查看一下三个文件的内容：
```
(wes) [somebody@HPC-login sra2fastq]$ head id.csv
SRR6359386.sra
SRR6359387.sra
SRR6359388.sra
SRR6359389.sra
SRR6359390.sra
SRR6359391.sra
SRR6359392.sra
SRR6359393.sra
SRR6359394.sra
SRR6359395.sra
(wes) [somebody@HPC-login sra2fastq]$ head mappfile
<sample>,0
(wes) [somebody@HPC-login sra2fastq]$ cat temple.pbs
#PBS -N fastq_<sample>
#PBS -l nodes=1:ppn=1
#PBS -l walltime=20:00:00
#PBS -l mem=10gb
#PBS -S /bin/bash
#PBS -q normal_3
#PBS -j oe

source activate wes
workdir=/public/home/somebody/ncbi/dbGaP-22002
cd $workdir
fastq-dump -outdir fastq_gz --split-3 --skip-technical --clip --gzip $workdir/sra/<sample>


/public/home/liuxs/ncbi/dbGaP-26301/run/sra2fastq

```
开始批量生成
- -d是路径，点就表示当前路径
- -f是模板
- -m是匹配
- -s是文件
```
$ sync-qgen -f temple.pbs -m mappfile -s id.csv -d .
```
循环提交同一个文件夹下的文件
```
for i in /public/home/somebody/biodata/gdc/links/sequence-nsclc/step_4/script/tcgapaired/*pbs
do qsub $i
done
```

#### 遇到的报错：
比如下图中`-outdir`用法应该是`--outdir`，pbs的输出文件中显示的都是该工具`--help`内容，说明工具在使用过程中用错了.
![](https://upload-images.jianshu.io/upload_images/22465597-8d160eb8d1865bbc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000)

#### 批量删除提交的任务
中途发现模板pbs文件出现问题，于是