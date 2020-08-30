下载SRA数据：

原始数据来源：

Willy Hugo_2016_cell_Genomic and Transcriptomic Features of Response to Anti-PD-1 Therapy in Metastatic Melanoma

melanoma 转移黑色素瘤，抗PD-1治疗，药物是pembrolizumab or nivolumab

38个tumor-normal WES和28个RNA-seq数据

PRJNA482620

> 根据SRA数据产生的特点，将SRA数据分为四类：
>
> Studies-- 研究课题
>
> Experiments-- 实验设计
>
> Samples-- 样品信息
>
> Runs-- 测序结果集
>
> SRA数据库用不同的前缀加以区分：
>
> ERP或SRP表示Studies；
>
> SRS 表示 Samples；
>
> SRX 表示 Experiments；
>
> SRR 表示 Runs
>
> https://blog.csdn.net/xxxie_/article/details/100112000

![image-20200731110930474](https://picgo-wutao.oss-cn-shanghai.aliyuncs.com/img/image-20200731110930474.png)

metadata是样本信息，accession list是一列SRR的名称可以用来批量下载

出现sra.vdbcache文件,可以使用vdb-validate检查文件是否下载完整

https://www.biostars.org/p/378082/

> I emailed to NLM-support and they replied to me as below:
>
> The "vdbcache" files speed up the access to "sra" files that contain difficult or noisy data. Please note that the existence of these adjunct files does not mean that extraction to FASTQ will be fast; they are created only in cases where needed so that extraction isn't unbearably slow. If you keep the "sra" files around, you should also keep "vdbcache" files for them. If you are concerned about whether or not your .sra file is complete please use the SRA toolkit's vdb-validate (https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=toolkit_doc&f=vdb-validate).

```R
nohup prefetch -O . $(<SRR_Acc_List.txt) > runoob.log 2>&1 &
```

每次要删除没有下载成功的样本

```shell
#!/bin/bash

for i in ./SRR*
do 
a=$(ls $i | wc -l)
if [ $a -eq 0 ]
then 
    rm -rf $i
fi
done
```

继续下没有下载成功的：

```shell
ls > file##成功下载的文件
grep -vf file SRR_Acc_List.txt > remain1 ##没有成功下载的文件
nohup prefetch -O . $(<remain1) > runoob_1.log 2>&1 &#继续下载
```

其实是不必要的，sratools会自动尝试未成功下载的文件：

> -f | –force Force object download. One of: no, yes, all. no [default]: Skip download if the object if found and complete; yes: Download it even if it is found and is complete; all: Ignore lock files (stale locks or if it is currently being downloaded: use at your own risk!).

> In case of SRR1399904 - prefetch downloads the run and all dependencies:
> 74 reference sequences and vdbcache.
>
> prefetch skips download of already found files.
>
> It will exit with 0 when all downloads were successful.
> It will exit with non-0 when any download failed.
>
> It means than after prefetch exits with non-0 -
> run the same command again to try to download the missing files.
> But don't remove already downloaded files.
>
> Except that there are some bugs in prefetch.2.9.6 that cause impossibility to download vdbcache files.
>
> I rolled back prefetch to 2.9.3 and published new SRA toolkit tarballs.
> Download it and run prefetch again.
>
> https://github.com/ncbi/sra-tools/issues/199

所以重复提交就OK了

SRA 转FASTQ

模板：

```shell
#PBS -N fastq
#PBS -l nodes=2:ppn=16
#PBS -l walltime=24:00:00
#PBS -S /bin/bash
#PBS -q slst_pub
#PBS -j oe

if [ -f "/public/home/liuxs/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/public/home/liuxs/anaconda3/etc/profile.d/conda.sh"
else
      export PATH="/public/home/liuxs/anaconda3/bin:$PATH"
fi
conda activate wes

fastq-dump --split-3 /public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/all_SRR/<srr> -O /public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/fastq/
```

```shell
##生成pbs
sync-qgen -m mapping -s file -f sra2fastq.pbs -d pbs/
##提交pbs
nohup ~/wt/gosub ../pbs &
```

## 数据质控



```
师姐的：fastqc -o ~/dnaseq/fqc/ -t 8 ~/dnaseq/fastq/<sample>
```

首先使用`fastqc`和`multiqc`来检测碱基质量

>  https://www.cnblogs.com/harrymore/p/13410267.html

```shell
#PBS -N fastqc
#PBS -l nodes=2:ppn=16
#PBS -l walltime=24:00:00
#PBS -S /bin/bash
#PBS -q slst_pub
#PBS -j oe

if [ -f "/public/home/liuxs/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/public/home/liuxs/anaconda3/etc/profile.d/conda.sh"
else
      export PATH="/public/home/liuxs/anaconda3/bin:$PATH"
fi
conda activate wes

fastqc --outdir /public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/qc_file/ --threads 16 /public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/fastq/<fastq> >> /public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/qc_file/<fastq1>_fastqc.log 2>&1
```

```shell
##mapping
##<fastq>,0
##<fastq1>,0

sync-qgen -m mapping -s fastq_file -f fastqc.pbs -d pbs/fastqc/##生成pbs
nohup ~/wt/gosub /pbs/fastqc/ &##提交pbs
```

使用`multiqc`整合结果

```shell
#PBS -N multiqc
#PBS -l nodes=2:ppn=16
#PBS -l walltime=24:00:00
#PBS -S /bin/bash
#PBS -q slst_pub
#PBS -j oe

if [ -f "/public/home/wangshx/wt/miniconda3/etc/profile.d/conda.sh" ]; then
    . "/public/home/wangshx/wt/miniconda3/etc/profile.d/conda.sh"
 else
     export PATH="/public/home/wangshx/wt/miniconda3/bin:$PATH"
 fi

conda activate /public/home/wangshx/wt/miniconda3
multiqc /public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/qc_file/*zip -o /public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/multiqc
```

![image-20200803145207805](https://picgo-wutao.oss-cn-shanghai.aliyuncs.com/img/image-20200803145207805.png)

![image-20200803145241915](https://picgo-wutao.oss-cn-shanghai.aliyuncs.com/img/image-20200803145241915.png)

可以看到碱基质量还是比较好的，但是需要去除接头序列

使用`Trim Galore`去接头

模板：

```shell
#PBS -N trim_galore
#PBS -l nodes=1:ppn=8
#PBS -l walltime=24:00:00
#PBS -S /bin/bash
#PBS -q slst_pub
#PBS -j oe
 
if [ -f "/public/home/wangshx/wt/miniconda3/etc/profile.d/conda.sh" ]; then
    . "/public/home/wangshx/wt/miniconda3/etc/profile.d/conda.sh"
 else
     export PATH="/public/home/wangshx/wt/miniconda3/bin:$PATH"
 fi

source activate /public/home/wangshx/wt/miniconda3

fq1=/public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/fastq/<fastq1>.fastq
fq2=/public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/fastq/<fastq2>.fastq
id=$(basename <fastq1> _1)

trim_galore --paired -q 20 --dont_gzip --phred33 --length 30 --stringency 3 -o /public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/clean_fastq/ $fq1 $fq2 >> /public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/clean_fastq/$id_trim.log
```

```shell
$ for i in *_1.fastq;do basename $i .fastq;done > ../fastq1_file
$ for i in *_2.fastq;do basename $i .fastq;done > ../fastq2_file
$ paste -d "," fastq1_file fastq2_file > fastq12_file
```

```shell
#mapping
##<fastq1>,0
##<fastq2>,1
```

```shell
sync-qgen -m remove_adapter_mapping -s fastq12_file -f remove_adapter.pbs -d pbs/trimgalore/ ##生成pbs
nohup ~/wt/gosub ../../pbs/trimgalore/ & ##提交pbs
```

再看去接头后的序列质量：

```shell
#PBS -N fastqc2
#PBS -l nodes=1:ppn=16
#PBS -l walltime=24:00:00
#PBS -S /bin/bash
#PBS -q slst_pub
#PBS -j oe

if [ -f "/public/home/liuxs/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/public/home/liuxs/anaconda3/etc/profile.d/conda.sh"
else
      export PATH="/public/home/liuxs/anaconda3/bin:$PATH"
fi
conda activate wes

fastqc --outdir /public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/qc_file/qc2 --threads 16 /public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/clean_fastq/<fastq> >> /public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/qc_file/qc2/<fastq1>_fastqc.log 2>&1
```

```shell
sync-qgen -m mapping -s fastq2_file -f fastqc2.pbs -d pbs/fastqc2/
nohup ~/wt/gosub ../../pbs/fastqc2/ &
```

```shell
#PBS -N multiqc2
#PBS -l nodes=1:ppn=8
#PBS -l walltime=24:00:00
#PBS -S /bin/bash
#PBS -q slst_pub
#PBS -j oe

if [ -f "/public/home/wangshx/wt/miniconda3/etc/profile.d/conda.sh" ]; then
    . "/public/home/wangshx/wt/miniconda3/etc/profile.d/conda.sh"
 else
     export PATH="/public/home/wangshx/wt/miniconda3/bin:$PATH"
 fi

conda activate /public/home/wangshx/wt/miniconda3
multiqc /public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/qc_file/qc2/*zip -o /public/home/wangshx/wt/immune_therapy_dataset/willy_hugo_2016_cell/sra/WES/multiqc/multiqc2/
```

![image-20200804090750439](https://picgo-wutao.oss-cn-shanghai.aliyuncs.com/img/image-20200804090750439.png)

![image-20200804090825882](https://picgo-wutao.oss-cn-shanghai.aliyuncs.com/img/image-20200804090825882.png)

## 突变检测

conda install -y

/public/home/wangshx/wt/miniconda3