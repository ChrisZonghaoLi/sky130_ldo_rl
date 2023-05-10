'''
    post-process vanilla LDO
'''

from utils import OutputParser
from ckt_graphs import GraphLDO
from ldo import LDOEnv

import matplotlib.pyplot as plt
plt.style.use(style='default')
plt.rcParams['lines.linewidth'] = 2
plt.rcParams["font.weight"] = "bold"
plt.rcParams["axes.labelweight"] = "bold"

from mpl_toolkits.axes_grid1.inset_locator import zoomed_inset_axes
from mpl_toolkits.axes_grid1.inset_locator import mark_inset

import pickle

import numpy as np

from datetime import datetime
date = datetime.today().strftime('%Y-%m-%d')

""" Load memory to plot reward vs simulations """
# RGCN
file_name1 = 'memory_GraphLDO_2023-04-06_noise=uniform_reward=-0.46_ActorCriticRGCN'
file_name2 = 'memory_GraphLDO_2023-04-07_noise=uniform_reward=-0.46_ActorCriticRGCN'
file_name3 = 'memory_GraphLDO_2023-04-08_noise=uniform_reward=-0.39_ActorCriticRGCN'
# GCN
file_name4 = 'memory_GraphLDO_2023-04-11_noise=uniform_reward=-0.41_ActorCriticGCN'
file_name5 = 'memory_GraphLDO_2023-04-11_noise=uniform_reward=-0.53_ActorCriticGCN'
file_name6 = 'memory_GraphLDO_2023-04-12_noise=uniform_reward=-0.38_ActorCriticGCN'
# GAT
file_name7 = 'memory_GraphLDO_2023-04-13_noise=uniform_reward=-0.61_ActorCriticGAT'
file_name8 = 'memory_GraphLDO_2023-04-14_noise=uniform_reward=-0.45_ActorCriticGAT'
file_name9 = 'memory_GraphLDO_2023-04-14_noise=uniform_reward=-0.59_ActorCriticGAT'
# MLP
file_name10 = 'memory_GraphLDO_2023-04-23_noise=uniform_reward=-0.73_ActorCriticMLP'
file_name11 = 'memory_GraphLDO_2023-04-24_noise=uniform_reward=-0.35_ActorCriticMLP'
file_name12 = 'memory_GraphLDO_2023-04-25_noise=uniform_reward=-0.57_ActorCriticMLP'
    
num_steps = 10000

with open(f'./saved_memories/{file_name1}.pkl', 'rb') as memory_file:
    memory1 = pickle.load(memory_file)
with open(f'./saved_memories/{file_name2}.pkl', 'rb') as memory_file:
    memory2 = pickle.load(memory_file)
with open(f'./saved_memories/{file_name3}.pkl', 'rb') as memory_file:
    memory3 = pickle.load(memory_file)
with open(f'./saved_memories/{file_name4}.pkl', 'rb') as memory_file:
    memory4 = pickle.load(memory_file)
with open(f'./saved_memories/{file_name5}.pkl', 'rb') as memory_file:
    memory5 = pickle.load(memory_file)
with open(f'./saved_memories/{file_name6}.pkl', 'rb') as memory_file:
    memory6 = pickle.load(memory_file)
with open(f'./saved_memories/{file_name7}.pkl', 'rb') as memory_file:
    memory7 = pickle.load(memory_file)
with open(f'./saved_memories/{file_name8}.pkl', 'rb') as memory_file:
    memory8 = pickle.load(memory_file)
with open(f'./saved_memories/{file_name9}.pkl', 'rb') as memory_file:
    memory9 = pickle.load(memory_file)
with open(f'./saved_memories/{file_name10}.pkl', 'rb') as memory_file:
    memory10 = pickle.load(memory_file)
with open(f'./saved_memories/{file_name11}.pkl', 'rb') as memory_file:
    memory11 = pickle.load(memory_file)
with open(f'./saved_memories/{file_name12}.pkl', 'rb') as memory_file:
    memory12 = pickle.load(memory_file)
    
rews_buf1 = memory1.rews_buf[:num_steps]
rews_buf2 = memory2.rews_buf[:num_steps]
rews_buf3 = memory3.rews_buf[:num_steps]
rews_buf4 = memory4.rews_buf[:num_steps]
rews_buf5 = memory5.rews_buf[:num_steps]
rews_buf6 = memory6.rews_buf[:num_steps]
rews_buf7 = memory7.rews_buf[:num_steps]
rews_buf8 = memory8.rews_buf[:num_steps]
rews_buf9 = memory9.rews_buf[:num_steps]
rews_buf10 = memory10.rews_buf[:num_steps]
rews_buf11 = memory11.rews_buf[:num_steps]
rews_buf12 = memory12.rews_buf[:num_steps]

""" Replay the best results """
best_file = file_name1
best_design = np.argmax(rews_buf1)
best_action = memory1.acts_buf[best_design]
best_reward = np.max(rews_buf1)
LDOEnv().step(best_action) # run the simulations

""" Result visualizations and save these as pictures """
# plot average reward
def average_window(rews_buf, window=50):
    avg_rewards=[]
    for k in range(len(rews_buf)):
        if k >= window:
            avg_reward = np.mean(rews_buf[k-window:k])
        else:
            avg_reward = np.inf
        avg_rewards.append(avg_reward)
    
    return avg_rewards

rgcn_mean = average_window(np.mean([rews_buf1, rews_buf2, rews_buf3], axis=0))
rgcn_std =  np.std([rews_buf1, rews_buf2, rews_buf3], axis=0)
gcn_mean = average_window(np.mean([rews_buf4, rews_buf5, rews_buf6], axis=0))
gcn_std =  np.std([rews_buf4, rews_buf5, rews_buf6], axis=0)
gat_mean = average_window(np.mean([rews_buf7, rews_buf8, rews_buf9], axis=0))
gat_std =  np.std([rews_buf7, rews_buf8, rews_buf9], axis=0)
mlp_mean = average_window(np.mean([rews_buf10, rews_buf11, rews_buf12], axis=0))
mlp_std =  np.std([rews_buf10, rews_buf11, rews_buf12], axis=0)

plt.figure('Reward')
plt.plot(rgcn_mean, 'b', label='RGCN') # RGCN
plt.fill_between(np.linspace(0, num_steps, num_steps), np.min([rews_buf1, rews_buf2, rews_buf3], axis=0), np.min([rews_buf1, rews_buf2, rews_buf3], axis=0), alpha=0.3, color='b') 
plt.plot(gcn_mean, 'r', label='GCN') # GCN
plt.fill_between(np.linspace(0, num_steps, num_steps), np.min([rews_buf4, rews_buf5, rews_buf6], axis=0), np.min([rews_buf4, rews_buf5, rews_buf6], axis=0), alpha=0.3, color='r') 
plt.plot(gat_mean, 'lime', label='GAT') # GAT
plt.fill_between(np.linspace(0, num_steps, num_steps), np.min([rews_buf7, rews_buf8, rews_buf9], axis=0), np.min([rews_buf7, rews_buf8, rews_buf9], axis=0), alpha=0.3, color='lime') 
plt.plot(mlp_mean, 'yellow', label='MLP') # MLP 
plt.fill_between(np.linspace(0, num_steps, num_steps), np.min([rews_buf10, rews_buf11, rews_buf12], axis=0), np.min([rews_buf10, rews_buf11, rews_buf12], axis=0), alpha=0.3, color='yellow') 
plt.xlabel('Number of Simulations', fontweight='bold', fontsize=14)
plt.xticks(fontsize=14, weight='bold')
plt.xticks(np.arange(0, num_steps+1, 2000))
plt.ylabel('Reward', fontweight='bold', fontsize=14)
plt.yticks(fontsize=14, fontweight='bold')
plt.yticks(np.linspace(-12,0,7))
plt.legend(loc='lower right')
plt.grid(linewidth=2)
ax = plt.gca()
ax.spines['bottom'].set_linewidth(2)
ax.spines['left'].set_linewidth(2)
ax.spines['right'].set_linewidth(2)
ax.spines['top'].set_linewidth(2)
plt.savefig(f'./pics/reward_ldo.pdf', format='pdf', bbox_inches='tight')
plt.savefig(f'./pics/reward_ldo.png', format='png', bbox_inches='tight')


''' plot simulation results '''
sim_results = OutputParser(GraphLDO())
dc_results = sim_results.dc(file_name='ldo_tb_dc')

# plot DC response
plt.figure('DC')
Vin = dc_results[0]
Vout = [max(dc_results[1][i], 0) for i in range(len(dc_results[1]))]
plt.plot(Vin, Vout, 'b')
plt.xlabel('$\mathbf{V_{DD}\,(V)}$', fontweight='bold', fontsize=14)
plt.xticks(fontsize=14, weight='bold')
plt.ylabel('$\mathbf{V_{reg}\,(V)}$', fontweight='bold', fontsize=14)
plt.yticks(fontsize=14, fontweight='bold')
plt.grid(linewidth=2)
ax = plt.gca()
ax.spines['bottom'].set_linewidth(2)
ax.spines['left'].set_linewidth(2)
ax.spines['right'].set_linewidth(2)
ax.spines['top'].set_linewidth(2)
plt.savefig(f'./pics/DC_{best_file}.eps', format='eps', bbox_inches='tight')
plt.savefig(f'./pics/DC_{best_file}.png', format='png', bbox_inches='tight')

# plot PSRR AC response
psrr_results_minload = sim_results.ac(file_name='ldo_tb_psrr_minload')
psrr_results_maxload = sim_results.ac(file_name='ldo_tb_psrr_maxload')
freq = psrr_results_minload[0]
psrr_minload = 20*np.log10(psrr_results_minload[1])
psrr_maxload = 20*np.log10(psrr_results_maxload[1])

plt.figure('PSRR')
plt.plot(freq, psrr_minload, 'b', label='PSRR @ $\mathbf{I_{L}=10\,\mu A}$')
plt.plot(freq, psrr_maxload, 'r', label='PSRR @ $\mathbf{I_{L}=10\,mA}$')
plt.xlabel('Frequency (Hz)', fontweight='bold', fontsize=14)
plt.xticks(fontsize=14, weight='bold')
plt.ylabel('PSRR (dB)', fontweight='bold', fontsize=14)
plt.yticks(fontsize=14, fontweight='bold')
plt.legend(loc='upper left', prop=dict(weight='bold'))
plt.grid(linewidth=2)
ax = plt.gca()
ax.spines['bottom'].set_linewidth(2)
ax.spines['left'].set_linewidth(2)
ax.spines['right'].set_linewidth(2)
ax.spines['top'].set_linewidth(2)
ax.set_xscale('log')
plt.savefig(f'./pics/PSRR_{best_file}.eps', format='eps', bbox_inches='tight')
plt.savefig(f'./pics/PSRR_{best_file}.png', format='png', bbox_inches='tight')

# plot loop stability
loop_gain_minload_results = sim_results.ac(file_name='ldo_tb_loop_gain_minload')
freq = loop_gain_minload_results[0]
loop_gain_minload = 20*np.log10(loop_gain_minload_results[1])
loop_gain_phase_minload = loop_gain_minload_results[2]
loop_gain_maxload_results = sim_results.ac(file_name='ldo_tb_loop_gain_maxload')
loop_gain_maxload = 20*np.log10(loop_gain_maxload_results[1])
loop_gain_phase_maxload = loop_gain_maxload_results[2]

plt.figure('Loop Gain')
fig, axs = plt.subplots(2)
axs[0].plot(freq, loop_gain_minload, 'b', label='Loop Gain @ $\mathbf{I_{L}=10\,\mu A}$')
axs[0].plot(freq, loop_gain_maxload, 'r', label='Loop Gain @ $\mathbf{I_{L}=10\,mA}$')
axs[0].set_ylabel('Loop Gain (dB)', fontweight='bold', fontsize=14)
axs[0].xaxis.set_tick_params(labelsize='14')
axs[0].yaxis.set_tick_params(labelsize='14')
axs[0].spines['bottom'].set_linewidth(2)
axs[0].spines['left'].set_linewidth(2)
axs[0].spines['right'].set_linewidth(2)
axs[0].spines['top'].set_linewidth(2)
axs[0].grid(linewidth=2)
axs[0].legend(loc='lower left', prop=dict(weight='bold'))
axs[0].set_yticks(axs[0].get_yticks()[::1])
idx_minload = [i for i in range(len(loop_gain_minload)) if loop_gain_minload[i] <=0][0]
idx_maxload = [i for i in range(len(loop_gain_maxload)) if loop_gain_maxload[i] <=0][0]
axs[0].axvline(x=freq[idx_minload], ls='--', color='b')
axs[0].axvline(x=freq[idx_maxload], ls='--', color='r')
axs[0].set_xscale('log')

axs[1].plot(freq, loop_gain_phase_minload, 'b', label='Phase @ $\mathbf{I_{L}=10\,\mu A}$')
axs[1].plot(freq, loop_gain_phase_maxload, 'r', label='Phase @ $\mathbf{I_{L}=10\,mA}$')
axs[1].set_ylabel('Phase (deg)', fontweight='bold', fontsize=14)
axs[1].xaxis.set_tick_params(labelsize='14')
axs[1].yaxis.set_tick_params(labelsize='14')
axs[1].spines['bottom'].set_linewidth(2)
axs[1].spines['left'].set_linewidth(2)
axs[1].spines['right'].set_linewidth(2)
axs[1].spines['top'].set_linewidth(2)
axs[1].grid(linewidth=2)
axs[1].legend(loc='upper left', prop=dict(weight='bold'))
axs[1].set_yticks(np.array([-180, -135, -90, -45, 0, 45, 90, 135, 180]))
axs[1].axvline(x=freq[idx_minload], ls='--', color='b')
axs[1].axvline(x=freq[idx_maxload], ls='--', color='r')
axs[1].set_xscale('log')
axs[1].set_xlabel('Frequency (Hz)', fontweight='bold', fontsize=14)

plt.savefig(f'./pics/loop_stb_{best_file}.eps', format='eps', bbox_inches='tight')
plt.savefig(f'./pics/loop_stb_{best_file}.png', format='png', bbox_inches='tight')

# load regulation
load_reg_results = sim_results.tran(file_name='ldo_tb_load_reg')
time = 1e6 * np.array(load_reg_results[0])
load_reg = load_reg_results[1]
load_reg_current_results = sim_results.tran(file_name='ldo_tb_load_reg_current')
load_reg_current = 1e3 * np.array(load_reg_current_results[1])

plt.figure('Load Reg')
fig, axs = plt.subplots(2)
axs[0].plot(time, load_reg_current, 'b', label='Load current')
axs[0].set_ylabel('$\mathbf{I_{L}}$ (mA)', fontweight='bold', fontsize=14)
axs[0].xaxis.set_tick_params(labelsize='14')
axs[0].yaxis.set_tick_params(labelsize='14')
axs[0].spines['bottom'].set_linewidth(2)
axs[0].spines['left'].set_linewidth(2)
axs[0].spines['right'].set_linewidth(2)
axs[0].spines['top'].set_linewidth(2)
axs[0].grid(linewidth=2)
axins = zoomed_inset_axes(axs[0], 100, loc=1) # zoom = 100
axins.plot(time, load_reg_current, color='b')
axins.set_xlim(60, 60.2) # Limit the region for zoom
axins.set_ylim(0, 0.02)
mark_inset(axs[0], axins, loc1=2, loc2=4, fc="none", ec="0.5")

axs[1].plot(time, load_reg, 'b', label='Vreg')
axs[1].set_ylabel('$\mathbf{V_{reg}}$ (V)', fontweight='bold', fontsize=14)
axs[1].xaxis.set_tick_params(labelsize='14')
axs[1].yaxis.set_tick_params(labelsize='14')
axs[1].spines['bottom'].set_linewidth(2)
axs[1].spines['left'].set_linewidth(2)
axs[1].spines['right'].set_linewidth(2)
axs[1].spines['top'].set_linewidth(2)
axs[1].grid(linewidth=2)
axs[1].set_yticks(np.array([1.2, 1.4, 1.6, 1.8, 2.0]))
axs[1].set_xlabel('Time ($\mathbf{\mu s}$)', fontweight='bold', fontsize=14)

plt.savefig(f'./pics/load_reg_{best_file}.eps', format='eps', bbox_inches='tight')
plt.savefig(f'./pics/load_reg_{best_file}.png', format='png', bbox_inches='tight')

# line regulation
line_reg_minload_results = sim_results.tran(file_name='ldo_tb_line_reg_minload')
line_reg_maxload_results = sim_results.tran(file_name='ldo_tb_line_reg_maxload')
line_reg_Vdd_results = sim_results.tran(file_name='ldo_tb_line_reg_Vdd')

time = 1e6 * np.array(line_reg_minload_results[0])
load_reg_minload = line_reg_minload_results[1]
load_reg_maxload = line_reg_maxload_results[1]
line_reg_Vdd = line_reg_Vdd_results[1]

plt.figure('Line Reg Minload')
fig, axs = plt.subplots(2)
axs[0].plot(time, line_reg_Vdd, 'b', label='$V_{DD}$')
axs[0].set_ylabel('$\mathbf{V_{DD}}$ (V)', fontweight='bold', fontsize=14)
axs[0].xaxis.set_tick_params(labelsize='14')
axs[0].yaxis.set_tick_params(labelsize='14')
axs[0].spines['bottom'].set_linewidth(2)
axs[0].spines['left'].set_linewidth(2)
axs[0].spines['right'].set_linewidth(2)
axs[0].spines['top'].set_linewidth(2)
axs[0].grid(linewidth=2)

axs[1].plot(time, load_reg_minload, 'b', label='Vreg')
axs[1].set_ylabel('$\mathbf{V_{reg}}$ (V)', fontweight='bold', fontsize=14)
axs[1].xaxis.set_tick_params(labelsize='14')
axs[1].yaxis.set_tick_params(labelsize='14')
axs[1].spines['bottom'].set_linewidth(2)
axs[1].spines['left'].set_linewidth(2)
axs[1].spines['right'].set_linewidth(2)
axs[1].spines['top'].set_linewidth(2)
axs[1].grid(linewidth=2)
axs[1].set_xlabel('Time ($\mathbf{\mu s}$)', fontweight='bold', fontsize=14)

plt.savefig(f'./pics/line_reg_minload_{best_file}.eps', format='eps', bbox_inches='tight')
plt.savefig(f'./pics/line_reg_minload_{best_file}.png', format='png', bbox_inches='tight')

plt.figure('Line Reg Maxload')
fig, axs = plt.subplots(2)
axs[0].plot(time, line_reg_Vdd, 'b', label='$V_{DD}$')
axs[0].set_ylabel('$\mathbf{V_{DD}}$ (V)', fontweight='bold', fontsize=14)
axs[0].xaxis.set_tick_params(labelsize='14')
axs[0].yaxis.set_tick_params(labelsize='14')
axs[0].spines['bottom'].set_linewidth(2)
axs[0].spines['left'].set_linewidth(2)
axs[0].spines['right'].set_linewidth(2)
axs[0].spines['top'].set_linewidth(2)
axs[0].grid(linewidth=2)

axs[1].plot(time, load_reg_maxload, 'b', label='Vreg')
axs[1].set_ylabel('$\mathbf{V_{reg}}$ (V)', fontweight='bold', fontsize=14)
axs[1].xaxis.set_tick_params(labelsize='14')
axs[1].yaxis.set_tick_params(labelsize='14')
axs[1].spines['bottom'].set_linewidth(2)
axs[1].spines['left'].set_linewidth(2)
axs[1].spines['right'].set_linewidth(2)
axs[1].spines['top'].set_linewidth(2)
axs[1].grid(linewidth=2)
axs[1].set_xlabel('Time ($\mathbf{\mu s}$)', fontweight='bold', fontsize=14)

plt.savefig(f'./pics/line_reg_maxload_{best_file}.eps', format='eps', bbox_inches='tight')
plt.savefig(f'./pics/line_reg_maxload_{best_file}.png', format='png', bbox_inches='tight')
