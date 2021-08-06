filename=inputFile
> $filename
for (( value=1 ; value <=10 ; value++ ))
do
echo $value,$RANDOM >> $filename
don