install:
	pip3 install --upgrade pip &&\
		pip install -r requirements.txt

all_edit_file: remove_spaces remove_commas add_commas remove_description remove_semicolon

remove_spaces:
	awk -v ORS= 'NR>1 && /==,/ {print "\n"} {print} END {if (NR) print "\n"}' < co_properties_20220315.csv > co_properties_20220315_t1.txt
	tr --delete '\r' < co_properties_20220315_t1.txt > co_properties_20220315_tratado.txt
remove_commas: remove_spaces
	sed -i 's/"//g' co_properties_20220315_tratado.txt

add_commas: remove_commas
	awk -F, '{printf "%s,%s,",$(NF-1), $(NF);for(i=1;i<NF-2;i++){printf "%s,",$i}print $(NF-2)}' co_properties_20220315_tratado.txt > co_properties_20220315_t1.txt
remove_description: add_commas
	awk -v OFS=',' -F, '{NF=22; print}' co_properties_20220315_t1.txt > co_properties_20220315_tratado.txt
remove_semicolon: remove_description
	sed -i 's/;//g' co_properties_20220315_tratado.txt



