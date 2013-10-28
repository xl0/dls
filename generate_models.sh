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
	cat <<EOF >> index.html
<table border="1">
  <tr><th></th>
EOF

# Fill in the given values
for i in $*; do
	echo "<th>$i</th>" >> index.html
done

echo "</tr>" >> index.html

}

function gen_table_footer {
	echo "</table>" >> index.html
}

function gen_table_left {
	echo "<tr>" >> index.html
	echo "<th>$1</th>" >> index.html
}

function gen_table_right {
	echo "</tr>" >> index.html
}

function gen_table_cell {
	echo "<th><a class=\"$model_base\" href=\"$model_html\">$1 $2</a></th>" >> index.html
}

function gen_mat {
	model_base="model_\
${_xlim}_\
${_ylim}_\
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
<hr>
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

}
function gen_vars {
	vars_base="\
${_xlim}_\
${_ylim}_\
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

alpha=(0);
beta=(0);

E_zero=(0.93)
E_max=(0.93);

Cell_density=(0.98);

delta_t=(1);

checkpoints=(50 100 150 250 500)
# Simulate until the last checkpoint
sim_time=(${checkpoints[${#checkpoints[@]}-1]})

Diffusion_rate=(0.01 0.2 0.8 0.95)
Degradation_rate=(0.3 0.5 0.7 0.8 0.99)

gen_html_header

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
	gen_table_right
done
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

