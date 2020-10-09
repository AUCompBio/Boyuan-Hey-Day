#! /bin/sh
mkdir -p Boyuan_Project1
sample=('DOM' 'CAST')
lc=0
for i in *.csv
do
echo "${lc}..."
echo "File: $i; Sample: ${sample[$lc]}"
mkdir -p Boyuan_Project1/${sample[$lc]}
cp $i Boyuan_Project1/${sample[$lc]}/
cd Boyuan_Project1/${sample[$lc]}/
head -1 $i > ${sample[$lc]}_header.txt
sort -nk17,17 $i |uniq > ${sample[$lc]}_lat_uniq.txt
sort -nk18,18 ${sample[$lc]}_lat_uniq.txt |uniq > ${sample[$lc]}_lat_long_uniq.txt
begin=`wc -l $i | awk '{print $1}'`
end=`wc -l ${sample[$lc]}_lat_long_uniq.txt | awk '{print $1}'`
echo "Begin: $begin; End: $end"
percent=`echo "scale=4; 100-(($end/$begin)* 100)"| bc`
echo "Percent duplicated is: $percent %"
grep "USNM" ${sample[$lc]}_lat_long_uniq.txt > ${sample[$lc]}_USNM.txt
awk 'FS="\t" {print $17, $18}' ${sample[$lc]}_USNM.txt >${sample[$lc]}_USNM_lat_long.txt
grep -v "^\s*$" ${sample[$lc]}_USNM_lat_long.txt > ${sample[$lc]}_lat_long_cleaned.txt
cd ../../
lc=`expr $lc + 1`
done
cd Boyuan_Project1/
cat CAST/CAST_lat_long_cleaned.txt DOM/DOM_lat_long_cleaned.txt > Lat_Long_USNM_combined.txt
