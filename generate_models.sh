#!/bin/bash

# Generate the variable files, as well as the index and table pages.

MODEL_DIR=`pwd`
OUT_DIR=$1
cd $OUT_DIR

# Generating HTML with bash. Haters gonna hate.

function gen_html_header {
	cat <<EOF > index.html
<html>
<body>
<style type="text/css">
a:link {color:#000000;}
a:visited {color:#000000;}
</style>
<link href="tables.css" rel="stylesheet">
EOF
}

function gen_html_footer {
	cat <<EOF >> index.html
</body>
</html>
EOF
}


function gen_table_header {
	table_num=$(($table_num+1))

	echo "<hr style=\"clear:both;\">" > table-${table_num}.html 
	echo "<div style=\"float:left; width:30%;\" >" >> table-${table_num}.html

	if [ -n "${_xlim}" ]; then
		echo "xlim = ${_xlim};</br>" >> table-${table_num}.html
	fi

	if [ -n "${_ylim}" ]; then
		echo "ylim = ${_ylim};</br>" >> table-${table_num}.html
	fi

	if [ -n "${_T_arp}" ]; then
		echo "T_arp = ${_T_arp};</br>" >> table-${table_num}.html
	fi

	if [ -n "${_T_rrp}" ]; then
		echo "T_rrp = ${_T_rrp};</br>" >> table-${table_num}.html
	fi

	if [ -n "${_T_max}" ]; then
		echo "T_max = ${_T_max};</br>" >> table-${table_num}.html
	fi

	if [ -n "${_C_max}" ]; then
		echo "C_max = ${_C_max};</br>" >> table-${table_num}.html
	fi

	if [ -n "${_alpha}" ]; then
		echo "alpha = ${_alpha};</br>" >> table-${table_num}.html
	fi

	if [ -n "${_beta}" ]; then
		echo "beta = ${_beta};</br>" >> table-${table_num}.html
	fi

	if [ -n "${_E_max}" ]; then
		echo "E_max = ${_E_max};</br>" >> table-${table_num}.html
	fi

	if [ -n "${_E_zero}" ]; then
		echo "E_zero = ${_E_zero};</br>" >> table-${table_num}.html
	fi

	if [ -n "${_Cell_density}" ]; then
		echo "Cell_density = ${_Cell_density};</br>" >> table-${table_num}.html
	fi

	if [ -n "${_delta_t}" ]; then
		echo "delta_t = ${_delta_t};</br>" >> table-${table_num}.html
	fi

	if [ -n "${sim_time}" ]; then
		echo "sim_time = ${_sim_time};</br>" >> table-${table_num}.html
	fi

	if [ -n "${_Diffusion_rate}" ]; then
		echo "Diffusion_rate = ${_Diffusion_rate};</br>" >> table-${table_num}.html
	fi

	if [ -n "${_Degradation_rate}" ]; then
		echo "Degradation_rate = ${_Degradation_rate};</br>" >> table-${table_num}.html
	fi

	echo "</div>" >> table-${table_num}.html

	echo "<h3><a href=\"batch-${table_num}.html\">See all results for table ${table_num}</a></h3>" >> table-${table_num}.html

	cat <<EOF >> table-${table_num}.html
<table border="1">
  <tr><th>Diffusion\\Degradation</th>
EOF

# Fill in the given values
for i in $*; do
	echo "<th>$i</th>" >> table-${table_num}.html
done

echo "</tr>" >> table-${table_num}.html

cat <<EOF > batch-${table_num}.html
<html>
<body>
<style type="text/css">
a:link {color:#000000;}
a:visited {color:#000000;}
</style>
<link href="tables.css" rel="stylesheet">
EOF




}

function gen_table_footer {
	echo "</table>" >> table-${table_num}.html

	cat table-${table_num}.html >> index.html
	cat table-${table_num}.html batch-${table_num}.html > tmp

	echo "<a href=\"index.html\">Back</a>" > batch-${table_num}.html
	cat tmp >> batch-${table_num}.html
	rm tmp
}

function gen_table_left {
	echo "<tr>" >> table-${table_num}.html
	echo "<th>$1</th>" >> table-${table_num}.html
}

function gen_table_right {
	echo "</tr>" >> table-${table_num}.html
}

function gen_table_cell {
	echo "<th><a class=\"$model_base\" href=\"$model_html\">$1 $2</a></th>" >> table-${table_num}.html
}

function gen_mat {
	model_base="model_\
${_T_arp}_\
${_T_rrp}_\
${_T_max}_\
${_C_max}_\
${_alpha}_\
${_beta}_\
${_E_max}_\
${_E_zero}_\
${_Cell_density}_\
${_delta_t}_\
${sim_time}_\
${_Diffusion_rate}_\
${_Degradation_rate}"

	model_base=`echo ${model_base} | tr '.' x`
	model_file="${model_base}.m"

	cat <<EOF > ${model_file}
	Parameters = struct();
	Parameters.xlim = ${_xlim};
	Parameters.ylim = ${_ylim};
	Parameters.Diffusion_rate = ${_Diffusion_rate};
	Parameters.Degradation_rate = ${_Degradation_rate};
	Parameters.T_arp = ${_T_arp};
	Parameters.T_rrp = ${_T_rrp};
	Parameters.T_max = ${_T_max};
	Parameters.C_max = ${_C_max};
	Parameters.C_min = ${_C_min};
	Parameters.alpha = ${_alpha};
	Parameters.beta = ${_beta};
	Parameters.E_max = ${_E_max};
	Parameters.E_zero = ${_E_zero};
	Parameters.Cell_density = ${_Cell_density};
	Parameters.delta_t = ${_delta_t};
	Parameters.sim_time = ${_sim_time};
	Parameters.checkpoints = [${checkpoints[*]}];
	Parameters.display = 0;
	Parameters.record = 1;
	Parameters.model_base ='$model_base';

	addpath $MODEL_DIR

	run_model(Parameters);
EOF


	model_html="${model_base}.html"

	cat <<EOF > ${model_html}
<hr style="clear:both;">
<p>
<pre>
xlim: ${_xlim}
ylim: ${_ylim}
Diffusion_rate: ${_Diffusion_rate}
Degradation_rate: ${_Degradation_rate}
T_arp: ${_T_arp}
T_rrp: ${_T_rrp}
T_max: ${_T_max}
C_max: ${_C_max}
C_min: ${_C_min}
alpha: ${_alpha}
beta: ${_beta}
E_max: ${_E_max}
E_zero: ${_E_zero}
Cell_density: ${_Cell_density}
delta_t: ${_delta_t}
sim_time: ${_sim_time}
checkpoints: [${checkpoints[*]}]
</pre>
</p>
EOF
	for cp in ${checkpoints[*]}; do
		echo "<img src=\"${model_base}/${model_base}_${cp}.png\">" >> ${model_html}
	done

	echo "<video controls>" >> ${model_html}
	echo "<source src=\"${model_base}/video/video.mp4\" type=\"video/mp4\">" >> ${model_html}
	echo "</video>" >> ${model_html}


gen_table_cell ${_Diffusion_rate} ${_Degradation_rate}

	cat ${model_base}.html >> batch-${table_num}.html

}
function gen_vars {
	vars_base="\
${_T_arp}_\
${_T_rrp}_\
${_T_max}_\
${_C_max}_\
${_alpha}_\
${_beta}_\
${_E_max}_\
${_E_zero}_\
${_Cell_density}_\
${_delta_t}_\
${sim_time}_\
${_Diffusion_rate}_\
${_Degradation_rate}"

	vars_base=`echo ${vars_base} | tr '.' x`
	vars_file="vars_${vars_base}.sh"

	cat <<EOF > ${vars_file}
	xlim=${_xlim}
	ylim=${_ylim}
	Diffusion_rate=${_Diffusion_rate}
	Degradation_rate=${_Degradation_rate}
	T_arp=${_T_arp}
	T_rrp=${_T_rrp}
	T_max=${_T_max}
	C_max=${_C_max}
	C_min=${_C_min}
	alpha=${_alpha}
	beta=${_beta}
	E_max=${_E_max}
	E_zero=${_E_zero}
	Cell_density=${_Cell_density}
	delta_t=${_delta_t}
	sim_time=${_sim_time}
	checkpoints=(${checkpoints[*]})
	display=0
	record=1
	model_base='$vars_base'
EOF
}


xlim=(150)
ylim=(150)

T_arp=(8)
T_rrp=(2)
T_max=(15)

C_max=(100)
C_min=(4)

alpha=(0.0005)
beta=(1.24)

E_zero=(0)
E_max=(0.93)

Cell_density=(0.5 0.75 0.98);

delta_t=(1)

checkpoints=(250 700 1125 3500 16500)
# Simulate until the last checkpoint
sim_time=(${checkpoints[${#checkpoints[@]}-1]})

Diffusion_rate=(0.5 0.8 0.99)
Degradation_rate=(0.2 0.3 0.5 0.6 0.7 0.8)

gen_html_header
table_num=0

for _xlim in ${xlim[*]}; do
for _ylim in ${ylim[*]}; do
for _T_arp in ${T_arp[*]}; do
for _T_rrp in ${T_rrp[*]}; do
for _T_max in ${T_max[*]}; do
for _C_max in ${C_max[*]}; do
for _C_min in ${C_min[*]}; do
for _alpha in ${alpha[*]}; do
for _beta in ${beta[*]}; do
for _E_max in ${E_max[*]}; do
for _E_zero in ${E_zero[*]}; do
for _Cell_density in ${Cell_density[*]}; do
for _delta_t in ${delta_t[*]}; do
for _sim_time in ${sim_time[*]}; do

gen_table_header ${Degradation_rate[*]}

for _Diffusion_rate in ${Diffusion_rate[*]}; do
	gen_table_left $_Diffusion_rate
	for _Degradation_rate in ${Degradation_rate[*]}; do
		gen_mat
#		gen_table_cell $_Diffusion_rate $_Degradation_rate
	done
	unset _Degradation_rate
	gen_table_right
done
unset _Diffusion_rate
gen_table_footer
done
done
done
done
done
done
done
done
done
done
done
done
done
done

