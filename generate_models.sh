#!/bin/bash

OUT_DIR=$1

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
	model_file="$1/${model_base}.m"

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

	addpath $PWD

	run_model(Parameters);
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

Cell_density=(0.7);

delta_t=(0.1);

checkpoints=(50, 100, 150, 250)
# Simulate until the last checkpoint
sim_time=(${checkpoints[${#checkpoints}]});

Diffusion_rate=(0.5)
Degradation_rate=(0.1 0.5 1 2 4)


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
for _Diffusion_rate in ${Diffusion_rate[*]}; do
for _Degradation_rate in ${Degradation_rate[*]}; do
	gen_mat $OUT_DIR
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
done
done

