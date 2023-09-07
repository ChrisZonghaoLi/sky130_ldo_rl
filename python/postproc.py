'''
    post-process vanilla LDO
'''

from utils import OutputParser, ActionNormalizer
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

def average_window(rews_buf, window=50):
    avg_rewards=[]
    for k in range(len(rews_buf)):
        if k >= window:
            avg_reward = np.mean(rews_buf[k-window:k])
        else:
            avg_reward = np.inf
        avg_rewards.append(avg_reward)
    
    return avg_rewards


""" Plot how each spec improve w.r.t. simulation run """
# Noted: only the new simulations contain the record of individual specificaiton through simulation run
file1 = 'memory_GraphLDO_2023-06-29_noise=uniform_reward=-0.62_ActorCriticRGCN_rew_eng=True'
file2 = 'memory_GraphLDO_2023-06-30_noise=uniform_reward=-0.44_ActorCriticRGCN_rew_eng=True'
file3 = 'memory_GraphLDO_2023-07-02_noise=uniform_reward=-0.56_ActorCriticRGCN_rew_eng=True'
with open(f'./saved_memories/{file1}.pkl', 'rb') as memory_file:
    _memory1 = pickle.load(memory_file)
with open(f'./saved_memories/{file2}.pkl', 'rb') as memory_file:
    _memory2 = pickle.load(memory_file)
with open(f'./saved_memories/{file3}.pkl', 'rb') as memory_file:
    _memory3 = pickle.load(memory_file)
    
info1 = _memory1.info_buf[:num_steps]
info2 = _memory2.info_buf[:num_steps]
info3 = _memory3.info_buf[:num_steps]

# PM
PM_maxload_1 = np.array([info1[i]['Loop-gain PM (deg) at max load'] for i in range(num_steps)])
PM_maxload_2 = np.array([info2[i]['Loop-gain PM (deg) at max load'] for i in range(num_steps)])
PM_maxload_3 = np.array([info3[i]['Loop-gain PM (deg) at max load'] for i in range(num_steps)])
PM_maxload_mean = np.mean([PM_maxload_1, PM_maxload_2, PM_maxload_3], axis=0)
PM_maxload_min = np.min([PM_maxload_1, PM_maxload_2, PM_maxload_3], axis=0)
PM_maxload_max = np.max([PM_maxload_1, PM_maxload_2, PM_maxload_3], axis=0)

PM_minload_1 = np.array([info1[i]['Loop-gain PM (deg) at min load'] for i in range(num_steps)])
PM_minload_2 = np.array([info2[i]['Loop-gain PM (deg) at min load'] for i in range(num_steps)])
PM_minload_3 = np.array([info3[i]['Loop-gain PM (deg) at min load'] for i in range(num_steps)])
PM_minload_mean = np.mean([PM_minload_1, PM_minload_2, PM_minload_3], axis=0)
PM_minload_min = np.min([PM_minload_1, PM_minload_2, PM_minload_3], axis=0)
PM_minload_max = np.max([PM_minload_1, PM_minload_2, PM_minload_3], axis=0)

plt.figure('PM')
plt.plot(np.array(average_window(PM_minload_mean)), 'b', label='PM at $\mathbf{I_{L}=10\,\mu A}$') # RGCN
plt.fill_between(np.linspace(0, num_steps, num_steps), PM_minload_min, PM_minload_max, alpha=0.3, color='b') 
plt.plot(np.array(average_window(PM_maxload_mean)), 'r', label='PM at $\mathbf{I_{L}=10\,mA}$') # RGCN
plt.fill_between(np.linspace(0, num_steps, num_steps), PM_maxload_min, PM_maxload_max, alpha=0.3, color='r') 
plt.xlabel('Number of Simulations', fontweight='bold', fontsize=14)
plt.xticks(fontsize=14, weight='bold')
plt.xticks(np.arange(0, num_steps+1, 5000))
plt.ylabel('$\mathbf{PM}$ $(\mathbf{degree})$', fontweight='bold', fontsize=14)
plt.yticks(fontsize=14, fontweight='bold')
plt.grid(linewidth=2)
plt.legend()
ax = plt.gca()
ax.spines['bottom'].set_linewidth(2)
ax.spines['left'].set_linewidth(2)
ax.spines['right'].set_linewidth(2)
ax.spines['top'].set_linewidth(2)
plt.savefig(f'./pics/PM_ldo.pdf', format='pdf', bbox_inches='tight')
plt.savefig(f'./pics/PM_ldo.png', format='png', bbox_inches='tight')

# PSRR
PSRR_leq_10kHz_maxload_1 = np.array([info1[i]['PSRR worst maxload (dB) < 10kHz'] for i in range(num_steps)])
PSRR_leq_10kHz_maxload_2 = np.array([info2[i]['PSRR worst maxload (dB) < 10kHz'] for i in range(num_steps)])
PSRR_leq_10kHz_maxload_3 = np.array([info3[i]['PSRR worst maxload (dB) < 10kHz'] for i in range(num_steps)])
PSRR_leq_10kHz_maxload_mean = np.mean([PSRR_leq_10kHz_maxload_1, PSRR_leq_10kHz_maxload_2, PSRR_leq_10kHz_maxload_3], axis=0)
PSRR_leq_10kHz_maxload_min = np.min([PSRR_leq_10kHz_maxload_1, PSRR_leq_10kHz_maxload_2, PSRR_leq_10kHz_maxload_3], axis=0)
PSRR_leq_10kHz_maxload_max = np.max([PSRR_leq_10kHz_maxload_1, PSRR_leq_10kHz_maxload_2, PSRR_leq_10kHz_maxload_3], axis=0)

PSRR_leq_10kHz_minload_1 = np.array([info1[i]['PSRR worst minload (dB) < 10kHz'] for i in range(num_steps)])
PSRR_leq_10kHz_minload_2 = np.array([info2[i]['PSRR worst minload (dB) < 10kHz'] for i in range(num_steps)])
PSRR_leq_10kHz_minload_3 = np.array([info3[i]['PSRR worst minload (dB) < 10kHz'] for i in range(num_steps)])
PSRR_leq_10kHz_minload_mean = np.mean([PSRR_leq_10kHz_minload_1, PSRR_leq_10kHz_minload_2, PSRR_leq_10kHz_minload_3], axis=0)
PSRR_leq_10kHz_minload_min = np.min([PSRR_leq_10kHz_minload_1, PSRR_leq_10kHz_minload_2, PSRR_leq_10kHz_minload_3], axis=0)
PSRR_leq_10kHz_minload_max = np.max([PSRR_leq_10kHz_minload_1, PSRR_leq_10kHz_minload_2, PSRR_leq_10kHz_minload_3], axis=0)

PSRR_leq_1MHz_maxload_1 = np.array([info1[i]['PSRR worst maxload (dB) < 1MHz'] for i in range(num_steps)])
PSRR_leq_1MHz_maxload_2 = np.array([info2[i]['PSRR worst maxload (dB) < 1MHz'] for i in range(num_steps)])
PSRR_leq_1MHz_maxload_3 = np.array([info3[i]['PSRR worst maxload (dB) < 1MHz'] for i in range(num_steps)])
PSRR_leq_1MHz_maxload_mean = np.mean([PSRR_leq_1MHz_maxload_1, PSRR_leq_1MHz_maxload_2, PSRR_leq_1MHz_maxload_3], axis=0)
PSRR_leq_1MHz_maxload_min = np.min([PSRR_leq_1MHz_maxload_1, PSRR_leq_1MHz_maxload_2, PSRR_leq_1MHz_maxload_3], axis=0)
PSRR_leq_1MHz_maxload_max = np.max([PSRR_leq_1MHz_maxload_1, PSRR_leq_1MHz_maxload_2, PSRR_leq_1MHz_maxload_3], axis=0)

PSRR_leq_1MHz_minload_1 = np.array([info1[i]['PSRR worst minload (dB) < 1MHz'] for i in range(num_steps)])
PSRR_leq_1MHz_minload_2 = np.array([info2[i]['PSRR worst minload (dB) < 1MHz'] for i in range(num_steps)])
PSRR_leq_1MHz_minload_3 = np.array([info3[i]['PSRR worst minload (dB) < 1MHz'] for i in range(num_steps)])
PSRR_leq_1MHz_minload_mean = np.mean([PSRR_leq_1MHz_minload_1, PSRR_leq_1MHz_minload_2, PSRR_leq_1MHz_minload_3], axis=0)
PSRR_leq_1MHz_minload_min = np.min([PSRR_leq_1MHz_minload_1, PSRR_leq_1MHz_minload_2, PSRR_leq_1MHz_minload_3], axis=0)
PSRR_leq_1MHz_minload_max = np.max([PSRR_leq_1MHz_minload_1, PSRR_leq_1MHz_minload_2, PSRR_leq_1MHz_minload_3], axis=0)

PSRR_geq_1MHz_maxload_1 = np.array([info1[i]['PSRR worst maxload (dB) > 1MHz'] for i in range(num_steps)])
PSRR_geq_1MHz_maxload_2 = np.array([info2[i]['PSRR worst maxload (dB) > 1MHz'] for i in range(num_steps)])
PSRR_geq_1MHz_maxload_3 = np.array([info3[i]['PSRR worst maxload (dB) > 1MHz'] for i in range(num_steps)])
PSRR_geq_1MHz_maxload_mean = np.mean([PSRR_geq_1MHz_maxload_1, PSRR_geq_1MHz_maxload_2, PSRR_geq_1MHz_maxload_3], axis=0)
PSRR_geq_1MHz_maxload_min = np.mean([PSRR_geq_1MHz_maxload_1, PSRR_geq_1MHz_maxload_2, PSRR_geq_1MHz_maxload_3], axis=0)
PSRR_geq_1MHz_maxload_max = np.mean([PSRR_geq_1MHz_maxload_1, PSRR_geq_1MHz_maxload_2, PSRR_geq_1MHz_maxload_3], axis=0)

PSRR_geq_1MHz_minload_1 = np.array([info1[i]['PSRR worst minload (dB) > 1MHz'] for i in range(num_steps)])
PSRR_geq_1MHz_minload_2 = np.array([info2[i]['PSRR worst minload (dB) > 1MHz'] for i in range(num_steps)])
PSRR_geq_1MHz_minload_3 = np.array([info3[i]['PSRR worst minload (dB) > 1MHz'] for i in range(num_steps)])
PSRR_geq_1MHz_minload_mean = np.mean([PSRR_geq_1MHz_minload_1, PSRR_geq_1MHz_minload_2, PSRR_geq_1MHz_minload_3], axis=0)
PSRR_geq_1MHz_minload_min = np.mean([PSRR_geq_1MHz_minload_1, PSRR_geq_1MHz_minload_2, PSRR_geq_1MHz_minload_3], axis=0)
PSRR_geq_1MHz_minload_max = np.mean([PSRR_geq_1MHz_minload_1, PSRR_geq_1MHz_minload_2, PSRR_geq_1MHz_minload_3], axis=0)

plt.figure('PSRR maxload')
fig, axs = plt.subplots(3)
axs[0].plot(average_window(PSRR_leq_10kHz_maxload_mean), 'b', label='RGCN') # RGCN
axs[0].fill_between(np.linspace(0, num_steps, num_steps), PSRR_leq_10kHz_maxload_min, PSRR_leq_10kHz_maxload_max, alpha=0.3, color='b') 
axs[0].xaxis.set_tick_params(labelsize='14')
axs[0].yaxis.set_tick_params(labelsize='14')
axs[0].set_ylabel('$\mathbf{PSRR_{<10kHz}}$\n$\mathbf{(dB)}$', fontweight='bold', fontsize=14)
axs[0].set_yticks(np.array([-60, -40, -20, 0, 20]))
axs[0].set_xticklabels([])
axs[0].spines['bottom'].set_linewidth(2)
axs[0].spines['left'].set_linewidth(2)
axs[0].spines['right'].set_linewidth(2)
axs[0].spines['top'].set_linewidth(2)
axs[0].grid(linewidth=2)
axs[1].plot(average_window(PSRR_leq_1MHz_maxload_mean), 'b', label='RGCN') # RGCN
axs[1].fill_between(np.linspace(0, num_steps, num_steps), PSRR_leq_1MHz_maxload_min, PSRR_leq_1MHz_maxload_max, alpha=0.3, color='b') 
axs[1].xaxis.set_tick_params(labelsize='14')
axs[1].yaxis.set_tick_params(labelsize='14')
axs[1].set_ylabel('$\mathbf{PSRR_{<1MHz}}$\n$\mathbf{(dB)}$', fontweight='bold', fontsize=14)
axs[1].set_yticks(np.array([-40, -20, 0, 20, 40]))
axs[1].set_xticklabels([])
axs[1].spines['bottom'].set_linewidth(2)
axs[1].spines['left'].set_linewidth(2)
axs[1].spines['right'].set_linewidth(2)
axs[1].spines['top'].set_linewidth(2)
axs[1].grid(linewidth=2)
axs[2].plot(average_window(PSRR_geq_1MHz_maxload_mean), 'b', label='RGCN') # RGCN
axs[2].fill_between(np.linspace(0, num_steps, num_steps), PSRR_geq_1MHz_maxload_min, PSRR_geq_1MHz_maxload_max, alpha=0.3, color='b') 
axs[2].xaxis.set_tick_params(labelsize='14')
axs[2].set_yticks(np.array([-4, -2, 0, 2, 4]))
axs[2].yaxis.set_tick_params(labelsize='14')
axs[2].set_ylabel('$\mathbf{PSRR_{>1MHz}}$\n$\mathbf{(dB)}$', fontweight='bold', fontsize=14)
axs[2].spines['bottom'].set_linewidth(2)
axs[2].spines['left'].set_linewidth(2)
axs[2].spines['right'].set_linewidth(2)
axs[2].spines['top'].set_linewidth(2)
axs[2].grid(linewidth=2)
axs[2].set_xlabel('Number of Simulations', fontweight='bold', fontsize=14)
plt.savefig(f'./pics/PSRR_maxload_ldo.pdf', format='pdf', bbox_inches='tight')
plt.savefig(f'./pics/PSRR_maxload_ldo.png', format='png', bbox_inches='tight')

plt.figure('PSRR minload')
fig, axs = plt.subplots(3)
axs[0].plot(average_window(PSRR_leq_10kHz_minload_mean), 'b', label='RGCN') # RGCN
axs[0].fill_between(np.linspace(0, num_steps, num_steps), PSRR_leq_10kHz_minload_min, PSRR_leq_10kHz_minload_max, alpha=0.3, color='b') 
axs[0].xaxis.set_tick_params(labelsize='14')
axs[0].yaxis.set_tick_params(labelsize='14')
axs[0].set_ylabel('$\mathbf{PSRR_{<10kHz}}$\n$\mathbf{(dB)}$', fontweight='bold', fontsize=14)
axs[0].set_yticks(np.array([-60, -40, -20, 0, 20]))
axs[0].set_xticklabels([])
axs[0].spines['bottom'].set_linewidth(2)
axs[0].spines['left'].set_linewidth(2)
axs[0].spines['right'].set_linewidth(2)
axs[0].spines['top'].set_linewidth(2)
axs[0].grid(linewidth=2)
axs[1].plot(average_window(PSRR_leq_1MHz_minload_mean), 'b', label='RGCN') # RGCN
axs[1].fill_between(np.linspace(0, num_steps, num_steps), PSRR_leq_1MHz_minload_min, PSRR_leq_1MHz_minload_max, alpha=0.3, color='b') 
axs[1].xaxis.set_tick_params(labelsize='14')
axs[1].yaxis.set_tick_params(labelsize='14')
axs[1].set_ylabel('$\mathbf{PSRR_{<1MHz}}$\n$\mathbf{(dB)}$', fontweight='bold', fontsize=14)
axs[1].set_yticks(np.array([-40, -20, 0, 20, 40]))
axs[1].set_xticklabels([])
axs[1].spines['bottom'].set_linewidth(2)
axs[1].spines['left'].set_linewidth(2)
axs[1].spines['right'].set_linewidth(2)
axs[1].spines['top'].set_linewidth(2)
axs[1].grid(linewidth=2)
axs[2].plot(average_window(PSRR_geq_1MHz_minload_mean), 'b', label='RGCN') # RGCN
axs[2].fill_between(np.linspace(0, num_steps, num_steps), PSRR_geq_1MHz_minload_min, PSRR_geq_1MHz_minload_max, alpha=0.3, color='b') 
axs[2].xaxis.set_tick_params(labelsize='14')
axs[2].set_yticks(np.array([-30, -20, -10, 0, 10]))
axs[2].yaxis.set_tick_params(labelsize='14')
axs[2].set_ylabel('$\mathbf{PSRR_{>1MHz}}$\n$\mathbf{(dB)}$', fontweight='bold', fontsize=14)
axs[2].spines['bottom'].set_linewidth(2)
axs[2].spines['left'].set_linewidth(2)
axs[2].spines['right'].set_linewidth(2)
axs[2].spines['top'].set_linewidth(2)
axs[2].grid(linewidth=2)
axs[2].set_xlabel('Number of Simulations', fontweight='bold', fontsize=14)
plt.savefig(f'./pics/PSRR_minload_ldo.pdf', format='pdf', bbox_inches='tight')
plt.savefig(f'./pics/PSRR_minload_ldo.png', format='png', bbox_inches='tight')

""" Show the best results in each trial """
best_design1 = np.argmax(rews_buf1)
best_design2 = np.argmax(rews_buf2)
best_design3 = np.argmax(rews_buf3)
best_action1 = memory1.acts_buf[best_design1]
best_action2 = memory2.acts_buf[best_design2]
best_action3 = memory3.acts_buf[best_design3]

best_action1 = ActionNormalizer(action_space_low=GraphLDO().action_space_low, action_space_high = \
                               GraphLDO().action_space_high).action(best_action1) # convert [-1.1] range back to normal range
best_action2 = ActionNormalizer(action_space_low=GraphLDO().action_space_low, action_space_high = \
                               GraphLDO().action_space_high).action(best_action2) # convert [-1.1] range back to normal range
best_action3 = ActionNormalizer(action_space_low=GraphLDO().action_space_low, action_space_high = \
                               GraphLDO().action_space_high).action(best_action3) # convert [-1.1] range back to normal range
    
""" Plot how some key transistor dimensions evolve w.r.t. simulation run """
action1 = memory1.acts_buf[:num_steps]
action2 = memory2.acts_buf[:num_steps]
action3 = memory3.acts_buf[:num_steps]
# M1 and M2
W_M1_mean = np.mean([action1[:num_steps,0], action2[:num_steps,0], action3[:num_steps,0]], axis=0)
W_M1_min = np.min([action1[:num_steps,0], action2[:num_steps,0], action3[:num_steps,0]], axis=0)
W_M1_max = np.max([action1[:num_steps,0], action2[:num_steps,0], action3[:num_steps,0]], axis=0)
W_M1_mean = ActionNormalizer(action_space_low=GraphLDO().action_space_low[0], action_space_high = \
                               GraphLDO().action_space_high[0]).action(W_M1_mean) # convert [-1.1] range back to normal range
W_M1_min = ActionNormalizer(action_space_low=GraphLDO().action_space_low[0], action_space_high = \
                               GraphLDO().action_space_high[0]).action(W_M1_min) # convert [-1.1] range back to normal range
W_M1_max = ActionNormalizer(action_space_low=GraphLDO().action_space_low[0], action_space_high = \
                               GraphLDO().action_space_high[0]).action(W_M1_max) # convert [-1.1] range back to normal range

L_M1_mean = np.mean([action1[:num_steps,1], action2[:num_steps,1], action3[:num_steps,1]], axis=0)
L_M1_min = np.min([action1[:num_steps,1], action2[:num_steps,1], action3[:num_steps,1]], axis=0)
L_M1_max = np.max([action1[:num_steps,1], action2[:num_steps,1], action3[:num_steps,1]], axis=0)
L_M1_mean = ActionNormalizer(action_space_low=GraphLDO().action_space_low[1], action_space_high = \
                               GraphLDO().action_space_high[1]).action(L_M1_mean) # convert [-1.1] range back to normal range
L_M1_min = ActionNormalizer(action_space_low=GraphLDO().action_space_low[1], action_space_high = \
                               GraphLDO().action_space_high[1]).action(L_M1_min) # convert [-1.1] range back to normal range
L_M1_max = ActionNormalizer(action_space_low=GraphLDO().action_space_low[1], action_space_high = \
                               GraphLDO().action_space_high[1]).action(L_M1_max) # convert [-1.1] range back to normal range

# M3 and M4
W_M3_mean = np.mean([action1[:num_steps,2], action2[:num_steps,2], action3[:num_steps,2]], axis=0)
W_M3_min = np.min([action1[:num_steps,2], action2[:num_steps,2], action3[:num_steps,2]], axis=0)
W_M3_max = np.max([action1[:num_steps,2], action2[:num_steps,2], action3[:num_steps,2]], axis=0)
W_M3_mean = ActionNormalizer(action_space_low=GraphLDO().action_space_low[2], action_space_high = \
                               GraphLDO().action_space_high[2]).action(W_M3_mean) # convert [-1.1] range back to normal range
W_M3_min = ActionNormalizer(action_space_low=GraphLDO().action_space_low[2], action_space_high = \
                               GraphLDO().action_space_high[2]).action(W_M3_min) # convert [-1.1] range back to normal range
W_M3_max = ActionNormalizer(action_space_low=GraphLDO().action_space_low[2], action_space_high = \
                               GraphLDO().action_space_high[2]).action(W_M3_max) # convert [-1.1] range back to normal range

L_M3_mean = np.mean([action1[:num_steps,3], action2[:num_steps,3], action3[:num_steps,3]], axis=0)
L_M3_min = np.min([action1[:num_steps,3], action2[:num_steps,3], action3[:num_steps,3]], axis=0)
L_M3_max = np.max([action1[:num_steps,3], action2[:num_steps,3], action3[:num_steps,3]], axis=0)
L_M3_mean = ActionNormalizer(action_space_low=GraphLDO().action_space_low[3], action_space_high = \
                               GraphLDO().action_space_high[3]).action(L_M3_mean) # convert [-1.1] range back to normal range
L_M3_min = ActionNormalizer(action_space_low=GraphLDO().action_space_low[3], action_space_high = \
                               GraphLDO().action_space_high[3]).action(L_M3_min) # convert [-1.1] range back to normal range
L_M3_max = ActionNormalizer(action_space_low=GraphLDO().action_space_low[3], action_space_high = \
                               GraphLDO().action_space_high[3]).action(L_M3_max) # convert [-1.1] range back to normal range

# M5
W_M5_mean = np.mean([action1[:num_steps,4], action2[:num_steps,4], action3[:num_steps,4]], axis=0)
W_M5_min = np.min([action1[:num_steps,4], action2[:num_steps,4], action3[:num_steps,4]], axis=0)
W_M5_max = np.max([action1[:num_steps,4], action2[:num_steps,4], action3[:num_steps,4]], axis=0)
W_M5_mean = ActionNormalizer(action_space_low=GraphLDO().action_space_low[4], action_space_high = \
                               GraphLDO().action_space_high[4]).action(W_M5_mean) # convert [-1.1] range back to normal range
W_M5_min = ActionNormalizer(action_space_low=GraphLDO().action_space_low[4], action_space_high = \
                               GraphLDO().action_space_high[4]).action(W_M5_min) # convert [-1.1] range back to normal range
W_M5_max = ActionNormalizer(action_space_low=GraphLDO().action_space_low[4], action_space_high = \
                               GraphLDO().action_space_high[4]).action(W_M5_max) # convert [-1.1] range back to normal range

L_M5_mean = np.mean([action1[:num_steps,5], action2[:num_steps,5], action3[:num_steps,5]], axis=0)
L_M5_min = np.min([action1[:num_steps,5], action2[:num_steps,5], action3[:num_steps,5]], axis=0)
L_M5_max = np.max([action1[:num_steps,5], action2[:num_steps,5], action3[:num_steps,5]], axis=0)
L_M5_mean = ActionNormalizer(action_space_low=GraphLDO().action_space_low[5], action_space_high = \
                               GraphLDO().action_space_high[5]).action(L_M5_mean) # convert [-1.1] range back to normal range
L_M5_min = ActionNormalizer(action_space_low=GraphLDO().action_space_low[5], action_space_high = \
                               GraphLDO().action_space_high[5]).action(L_M5_min) # convert [-1.1] range back to normal range
L_M5_max = ActionNormalizer(action_space_low=GraphLDO().action_space_low[5], action_space_high = \
                               GraphLDO().action_space_high[5]).action(L_M5_max) # convert [-1.1] range back to normal range

# MP
W_MP_mean = np.mean([action1[:num_steps,6], action2[:num_steps,6], action3[:num_steps,6]], axis=0)
W_MP_min = np.min([action1[:num_steps,6], action2[:num_steps,6], action3[:num_steps,6]], axis=0)
W_MP_max = np.max([action1[:num_steps,6], action2[:num_steps,6], action3[:num_steps,6]], axis=0)
W_MP_mean = ActionNormalizer(action_space_low=GraphLDO().action_space_low[6], action_space_high = \
                               GraphLDO().action_space_high[6]).action(W_MP_mean) # convert [-1.1] range back to normal range
W_MP_min = ActionNormalizer(action_space_low=GraphLDO().action_space_low[6], action_space_high = \
                               GraphLDO().action_space_high[6]).action(W_MP_min) # convert [-1.1] range back to normal range
W_MP_max = ActionNormalizer(action_space_low=GraphLDO().action_space_low[6], action_space_high = \
                               GraphLDO().action_space_high[6]).action(W_MP_max) # convert [-1.1] range back to normal range

L_MP_mean = np.mean([action1[:num_steps,7], action2[:num_steps,7], action3[:num_steps,7]], axis=0)
L_MP_min = np.min([action1[:num_steps,7], action2[:num_steps,7], action3[:num_steps,7]], axis=0)
L_MP_max = np.max([action1[:num_steps,7], action2[:num_steps,7], action3[:num_steps,7]], axis=0)
L_MP_mean = ActionNormalizer(action_space_low=GraphLDO().action_space_low[7], action_space_high = \
                               GraphLDO().action_space_high[7]).action(L_MP_mean) # convert [-1.1] range back to normal range
L_MP_min = ActionNormalizer(action_space_low=GraphLDO().action_space_low[7], action_space_high = \
                               GraphLDO().action_space_high[7]).action(L_MP_min) # convert [-1.1] range back to normal range
L_MP_max = ActionNormalizer(action_space_low=GraphLDO().action_space_low[7], action_space_high = \
                               GraphLDO().action_space_high[7]).action(L_MP_max) # convert [-1.1] range back to normal range

M_MP_mean = np.mean([action1[:num_steps,8], action2[:num_steps,8], action3[:num_steps,8]], axis=0)
M_MP_min = np.min([action1[:num_steps,8], action2[:num_steps,8], action3[:num_steps,8]], axis=0)
M_MP_max = np.max([action1[:num_steps,7], action2[:num_steps,8], action3[:num_steps,8]], axis=0)
M_MP_mean = ActionNormalizer(action_space_low=GraphLDO().action_space_low[8], action_space_high = \
                               GraphLDO().action_space_high[8]).action(M_MP_mean) # convert [-1.1] range back to normal range
M_MP_min = ActionNormalizer(action_space_low=GraphLDO().action_space_low[8], action_space_high = \
                               GraphLDO().action_space_high[8]).action(M_MP_min) # convert [-1.1] range back to normal range
M_MP_max = ActionNormalizer(action_space_low=GraphLDO().action_space_low[8], action_space_high = \
                               GraphLDO().action_space_high[8]).action(M_MP_max) # convert [-1.1] range back to normal range
    
# Vb
Vb_mean = np.mean([action1[:num_steps,9], action2[:num_steps,9], action3[:num_steps,9]], axis=0)
Vb_min = np.min([action1[:num_steps,9], action2[:num_steps,9], action3[:num_steps,9]], axis=0)
Vb_max = np.max([action1[:num_steps,9], action2[:num_steps,9], action3[:num_steps,9]], axis=0)
Vb_mean = ActionNormalizer(action_space_low=GraphLDO().action_space_low[9], action_space_high = \
                               GraphLDO().action_space_high[9]).action(Vb_mean) # convert [-1.1] range back to normal range
Vb_min = ActionNormalizer(action_space_low=GraphLDO().action_space_low[9], action_space_high = \
                               GraphLDO().action_space_high[9]).action(Vb_min) # convert [-1.1] range back to normal range
Vb_max = ActionNormalizer(action_space_low=GraphLDO().action_space_low[9], action_space_high = \
                               GraphLDO().action_space_high[9]).action(Vb_max) # convert [-1.1] range back to normal range

# Rfb
Rfb_mean = np.mean([action1[:num_steps,10], action2[:num_steps,10], action3[:num_steps,10]], axis=0)
Rfb_min = np.min([action1[:num_steps,10], action2[:num_steps,10], action3[:num_steps,10]], axis=0)
Rfb_max = np.max([action1[:num_steps,10], action2[:num_steps,10], action3[:num_steps,10]], axis=0)
Rfb_mean = GraphLDO().Rsheet * GraphLDO().L_Rfb / GraphLDO().W_Rfb / \
                                ActionNormalizer(action_space_low=GraphLDO().action_space_low[10], action_space_high = \
                               GraphLDO().action_space_high[10]).action(Rfb_mean) # convert [-1.1] range back to normal range
Rfb_min = GraphLDO().Rsheet * GraphLDO().L_Rfb / GraphLDO().W_Rfb / \
                                ActionNormalizer(action_space_low=GraphLDO().action_space_low[10], action_space_high = \
                               GraphLDO().action_space_high[10]).action(Rfb_min) # convert [-1.1] range back to normal range
Rfb_max = GraphLDO().Rsheet * GraphLDO().L_Rfb / GraphLDO().W_Rfb / \
                                ActionNormalizer(action_space_low=GraphLDO().action_space_low[10], action_space_high = \
                               GraphLDO().action_space_high[10]).action(Rfb_max) # convert [-1.1] range back to normal range

# Cfb
Cfb_mean = np.mean([action1[:num_steps,11], action2[:num_steps,11], action3[:num_steps,11]], axis=0)
Cfb_min = np.min([action1[:num_steps,11], action2[:num_steps,11], action3[:num_steps,11]], axis=0)
Cfb_max = np.max([action1[:num_steps,11], action2[:num_steps,11], action3[:num_steps,11]], axis=0)
Cfb_mean = (GraphLDO().W_Cfb*GraphLDO().L_Cfb*2e-15+(GraphLDO().W_Cfb+GraphLDO().L_Cfb)*0.38e-15) * \
                               ActionNormalizer(action_space_low=GraphLDO().action_space_low[11], action_space_high = \
                               GraphLDO().action_space_high[11]).action(Cfb_mean) # convert [-1.1] range back to normal range
Cfb_min = (GraphLDO().W_Cfb*GraphLDO().L_Cfb*2e-15+(GraphLDO().W_Cfb+GraphLDO().L_Cfb)*0.38e-15) * \
                                ActionNormalizer(action_space_low=GraphLDO().action_space_low[11], action_space_high = \
                               GraphLDO().action_space_high[11]).action(Cfb_min) # convert [-1.1] range back to normal range
Cfb_max = (GraphLDO().W_Cfb*GraphLDO().L_Cfb*2e-15+(GraphLDO().W_Cfb+GraphLDO().L_Cfb)*0.38e-15) * \
                                ActionNormalizer(action_space_low=GraphLDO().action_space_low[11], action_space_high = \
                               GraphLDO().action_space_high[11]).action(Cfb_max) # convert [-1.1] range back to normal range
    
# CL
CL_mean = np.mean([action1[:num_steps,-1], action2[:num_steps,-1], action3[:num_steps,-1]], axis=0)
CL_min = np.min([action1[:num_steps,-1], action2[:num_steps,-1], action3[:num_steps,-1]], axis=0)
CL_max = np.max([action1[:num_steps,-1], action2[:num_steps,-1], action3[:num_steps,-1]], axis=0)
CL_mean = (GraphLDO().W_CL*GraphLDO().L_CL*2e-15+(GraphLDO().W_CL+GraphLDO().L_CL)*0.38e-15) * \
                                ActionNormalizer(action_space_low=GraphLDO().action_space_low[-1], action_space_high = \
                               GraphLDO().action_space_high[-1]).action(CL_mean) # convert [-1.1] range back to normal range
CL_min = (GraphLDO().W_CL*GraphLDO().L_CL*2e-15+(GraphLDO().W_CL+GraphLDO().L_CL)*0.38e-15) * \
                                ActionNormalizer(action_space_low=GraphLDO().action_space_low[-1], action_space_high = \
                               GraphLDO().action_space_high[-1]).action(CL_min) # convert [-1.1] range back to normal range
CL_max = (GraphLDO().W_CL*GraphLDO().L_CL*2e-15+(GraphLDO().W_CL+GraphLDO().L_CL)*0.38e-15) * \
                                ActionNormalizer(action_space_low=GraphLDO().action_space_low[-1], action_space_high = \
                               GraphLDO().action_space_high[-1]).action(CL_max) # convert [-1.1] range back to normal range
    
plt.figure('Transistor dimensions M1')
fig, axs = plt.subplots(2)
axs[0].plot(average_window(W_M1_mean), 'b', label='RGCN') # RGCN
axs[0].fill_between(np.linspace(0, num_steps, num_steps), W_M1_min, W_M1_max, alpha=0.3, color='b') 
axs[0].xaxis.set_tick_params(labelsize='14')
axs[0].yaxis.set_tick_params(labelsize='14')
axs[0].set_ylabel('$\mathbf{W_{M_{1}}}$ $(\mathbf{\mu m})$', fontweight='bold', fontsize=14)
axs[0].set_yticks(np.array([0, 25, 50, 75, 100]))
axs[0].spines['bottom'].set_linewidth(2)
axs[0].spines['left'].set_linewidth(2)
axs[0].spines['right'].set_linewidth(2)
axs[0].spines['top'].set_linewidth(2)
axs[0].grid(linewidth=2)
axs[1].plot(average_window(L_M1_mean), 'b', label='RGCN') # RGCN
axs[1].fill_between(np.linspace(0, num_steps, num_steps), L_M1_min, L_M1_max, alpha=0.3, color='b') 
axs[1].xaxis.set_tick_params(labelsize='14')
axs[1].yaxis.set_tick_params(labelsize='14')
axs[1].set_ylabel('$\mathbf{L_{M_{1}}}$ $(\mathbf{\mu m})$', fontweight='bold', fontsize=14)
axs[1].spines['bottom'].set_linewidth(2)
axs[1].spines['left'].set_linewidth(2)
axs[1].spines['right'].set_linewidth(2)
axs[1].spines['top'].set_linewidth(2)
axs[1].grid(linewidth=2)
axs[1].set_xlabel('Number of Simulations', fontweight='bold', fontsize=14)
plt.savefig(f'./pics/M1_ldo.pdf', format='pdf', bbox_inches='tight')
plt.savefig(f'./pics/M1_ldo.png', format='png', bbox_inches='tight')

plt.figure('Transistor dimensions M3')
fig, axs = plt.subplots(2)
axs[0].plot(average_window(W_M3_mean), 'b', label='RGCN') # RGCN
axs[0].fill_between(np.linspace(0, num_steps, num_steps), W_M3_min, W_M3_max, alpha=0.3, color='b') 
axs[0].xaxis.set_tick_params(labelsize='14')
axs[0].yaxis.set_tick_params(labelsize='14')
axs[0].set_ylabel('$\mathbf{W_{M_{3}}}$ $(\mathbf{\mu m})$', fontweight='bold', fontsize=14)
axs[0].set_yticks(np.array([0, 25, 50, 75, 100]))
axs[0].spines['bottom'].set_linewidth(2)
axs[0].spines['left'].set_linewidth(2)
axs[0].spines['right'].set_linewidth(2)
axs[0].spines['top'].set_linewidth(2)
axs[0].grid(linewidth=2)
axs[1].plot(average_window(L_M3_mean), 'b', label='RGCN') # RGCN
axs[1].fill_between(np.linspace(0, num_steps, num_steps), L_M3_min, L_M3_max, alpha=0.3, color='b') 
axs[1].xaxis.set_tick_params(labelsize='14')
axs[1].yaxis.set_tick_params(labelsize='14')
axs[1].set_ylabel('$\mathbf{L_{M_{3}}}$ $(\mathbf{\mu m})$', fontweight='bold', fontsize=14)
axs[1].spines['bottom'].set_linewidth(2)
axs[1].spines['left'].set_linewidth(2)
axs[1].spines['right'].set_linewidth(2)
axs[1].spines['top'].set_linewidth(2)
axs[1].grid(linewidth=2)
axs[1].set_xlabel('Number of Simulations', fontweight='bold', fontsize=14)
plt.savefig(f'./pics/M3_ldo.pdf', format='pdf', bbox_inches='tight')
plt.savefig(f'./pics/M3_ldo.png', format='png', bbox_inches='tight')

plt.figure('Transistor dimensions M5')
fig, axs = plt.subplots(2)
axs[0].plot(average_window(W_M5_mean), 'b', label='RGCN') # RGCN
axs[0].fill_between(np.linspace(0, num_steps, num_steps), W_M5_min, W_M5_max, alpha=0.3, color='b') 
axs[0].xaxis.set_tick_params(labelsize='14')
axs[0].yaxis.set_tick_params(labelsize='14')
axs[0].set_ylabel('$\mathbf{W_{M_{5}}}$ $(\mathbf{\mu m})$', fontweight='bold', fontsize=14)
axs[0].set_yticks(np.array([0, 25, 50, 75, 100]))
axs[0].spines['bottom'].set_linewidth(2)
axs[0].spines['left'].set_linewidth(2)
axs[0].spines['right'].set_linewidth(2)
axs[0].spines['top'].set_linewidth(2)
axs[0].grid(linewidth=2)
axs[1].plot(average_window(L_M5_mean), 'b', label='RGCN') # RGCN
axs[1].fill_between(np.linspace(0, num_steps, num_steps), L_M5_min, L_M5_max, alpha=0.3, color='b') 
axs[1].xaxis.set_tick_params(labelsize='14')
axs[1].yaxis.set_tick_params(labelsize='14')
axs[1].set_ylabel('$\mathbf{L_{M_{5}}}$ $(\mathbf{\mu m})$', fontweight='bold', fontsize=14)
axs[1].spines['bottom'].set_linewidth(2)
axs[1].spines['left'].set_linewidth(2)
axs[1].spines['right'].set_linewidth(2)
axs[1].spines['top'].set_linewidth(2)
axs[1].grid(linewidth=2)
axs[1].set_xlabel('Number of Simulations', fontweight='bold', fontsize=14)
plt.savefig(f'./pics/M5_ldo.pdf', format='pdf', bbox_inches='tight')
plt.savefig(f'./pics/M5_ldo.png', format='png', bbox_inches='tight')

plt.figure('Vb')
plt.plot(average_window(Vb_mean), 'b', label='RGCN') # RGCN
plt.fill_between(np.linspace(0, num_steps, num_steps), Vb_min, Vb_max, alpha=0.3, color='b') 
plt.xlabel('Number of Simulations', fontweight='bold', fontsize=14)
plt.xticks(fontsize=14, weight='bold')
plt.xticks(np.arange(0, num_steps+1, 2000))
plt.ylabel('$\mathbf{V_{b}}$ (V)', fontweight='bold', fontsize=14)
plt.yticks(fontsize=14, fontweight='bold')
plt.grid(linewidth=2)
ax = plt.gca()
ax.spines['bottom'].set_linewidth(2)
ax.spines['left'].set_linewidth(2)
ax.spines['right'].set_linewidth(2)
ax.spines['top'].set_linewidth(2)
plt.savefig(f'./pics/Vb_ldo.pdf', format='pdf', bbox_inches='tight')
plt.savefig(f'./pics/Vb_ldo.png', format='png', bbox_inches='tight')

plt.figure('Transistor dimensions MP')
fig, axs = plt.subplots(3)
axs[0].plot(average_window(W_MP_mean), 'b', label='RGCN') # RGCN
axs[0].fill_between(np.linspace(0, num_steps, num_steps), W_MP_min, W_MP_max, alpha=0.3, color='b') 
axs[0].xaxis.set_tick_params(labelsize='14')
axs[0].yaxis.set_tick_params(labelsize='14')
axs[0].set_ylabel('$\mathbf{W_{M_{P}}}$ $(\mathbf{\mu m})$', fontweight='bold', fontsize=14)
axs[0].set_yticks(np.array([0, 25, 50, 75, 100]))
axs[0].set_xticklabels([])
axs[0].spines['bottom'].set_linewidth(2)
axs[0].spines['left'].set_linewidth(2)
axs[0].spines['right'].set_linewidth(2)
axs[0].spines['top'].set_linewidth(2)
axs[0].grid(linewidth=2)
axs[1].plot(average_window(L_MP_mean), 'b', label='RGCN') # RGCN
axs[1].fill_between(np.linspace(0, num_steps, num_steps), L_MP_min, L_MP_max, alpha=0.3, color='b') 
axs[1].xaxis.set_tick_params(labelsize='14')
axs[1].yaxis.set_tick_params(labelsize='14')
axs[1].set_ylabel('$\mathbf{L_{M_{P}}}$ $(\mathbf{\mu m})$', fontweight='bold', fontsize=14)
axs[1].set_yticks(np.array([0.5, 0.75, 1]))
axs[1].set_xticklabels([])
axs[1].spines['bottom'].set_linewidth(2)
axs[1].spines['left'].set_linewidth(2)
axs[1].spines['right'].set_linewidth(2)
axs[1].spines['top'].set_linewidth(2)
axs[1].grid(linewidth=2)
axs[2].plot(average_window(M_MP_mean), 'b', label='RGCN') # RGCN
axs[2].fill_between(np.linspace(0, num_steps, num_steps), M_MP_min, M_MP_max, alpha=0.3, color='b') 
axs[2].xaxis.set_tick_params(labelsize='14')
axs[2].set_yticks(np.array([0, 500, 1000, 1500, 2000]))
axs[2].yaxis.set_tick_params(labelsize='14')
axs[2].set_ylabel('$\mathbf{M_{M_{P}}}$', fontweight='bold', fontsize=14)
axs[2].spines['bottom'].set_linewidth(2)
axs[2].spines['left'].set_linewidth(2)
axs[2].spines['right'].set_linewidth(2)
axs[2].spines['top'].set_linewidth(2)
axs[2].grid(linewidth=2)
axs[2].set_xlabel('Number of Simulations', fontweight='bold', fontsize=14)
plt.savefig(f'./pics/MP_ldo.pdf', format='pdf', bbox_inches='tight')
plt.savefig(f'./pics/MP_ldo.png', format='png', bbox_inches='tight')

plt.figure('Rfb and Cfb')
fig, axs = plt.subplots(2)
axs[0].plot(average_window(Rfb_mean), 'b', label='RGCN') # RGCN
axs[0].fill_between(np.linspace(0, num_steps, num_steps), Rfb_min, Rfb_max, alpha=0.3, color='b') 
axs[0].xaxis.set_tick_params(labelsize='14')
axs[0].yaxis.set_tick_params(labelsize='14')
axs[0].set_ylabel('$\mathbf{R_{fb}}$ $(\mathbf{\Omega})$', fontweight='bold', fontsize=14)
axs[0].set_yticks(np.array([0, 1500, 3000, 4500, 6000, 7500, 9000]))
axs[0].spines['bottom'].set_linewidth(2)
axs[0].spines['left'].set_linewidth(2)
axs[0].spines['right'].set_linewidth(2)
axs[0].spines['top'].set_linewidth(2)
axs[0].grid(linewidth=2)
axs[1].plot(np.array(average_window(Cfb_mean))/1e-12, 'b', label='RGCN') # RGCN
axs[1].fill_between(np.linspace(0, num_steps, num_steps), np.array(Cfb_min)/1e-12, np.array(Cfb_max)/1e-12, alpha=0.3, color='b') 
axs[1].xaxis.set_tick_params(labelsize='14')
axs[1].yaxis.set_tick_params(labelsize='14')
axs[1].set_ylabel('$\mathbf{C_{fb}}$ $(\mathbf{pf})$', fontweight='bold', fontsize=14)
axs[1].set_yticks(np.array([0, 5, 10, 15, 20]))
axs[1].spines['bottom'].set_linewidth(2)
axs[1].spines['left'].set_linewidth(2)
axs[1].spines['right'].set_linewidth(2)
axs[1].spines['top'].set_linewidth(2)
axs[1].grid(linewidth=2)
axs[1].set_xlabel('Number of Simulations', fontweight='bold', fontsize=14)
plt.savefig(f'./pics/Rfb_Cfb_ldo.pdf', format='pdf', bbox_inches='tight')
plt.savefig(f'./pics/Rfb_Cfb_ldo.png', format='png', bbox_inches='tight')

plt.figure('CL')
plt.plot(np.array(average_window(CL_mean))/1e-12, 'b', label='RGCN') # RGCN
plt.fill_between(np.linspace(0, num_steps, num_steps), np.array(CL_min)/1e-12, np.array(CL_max)/1e-12, alpha=0.3, color='b') 
plt.xlabel('Number of Simulations', fontweight='bold', fontsize=14)
plt.xticks(fontsize=14, weight='bold')
plt.xticks(np.arange(0, num_steps+1, 2000))
plt.ylabel('$\mathbf{C_{L}}$ $(\mathbf{pf})$', fontweight='bold', fontsize=14)
plt.yticks(fontsize=14, fontweight='bold')
plt.grid(linewidth=2)
ax = plt.gca()
ax.spines['bottom'].set_linewidth(2)
ax.spines['left'].set_linewidth(2)
ax.spines['right'].set_linewidth(2)
ax.spines['top'].set_linewidth(2)
plt.savefig(f'./pics/CL_ldo.pdf', format='pdf', bbox_inches='tight')
plt.savefig(f'./pics/CL_ldo.png', format='png', bbox_inches='tight')

""" Replay the best results """
best_file = file_name1
best_design = np.argmax(rews_buf1)
best_action = memory1.acts_buf[best_design]
best_reward = np.max(rews_buf1)
LDOEnv().step(best_action) # run the simulations

""" Result visualizations and save these as pictures """
# plot average reward

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
plt.fill_between(np.linspace(0, num_steps, num_steps), np.min([rews_buf1, rews_buf2, rews_buf3], axis=0), np.max([rews_buf1, rews_buf2, rews_buf3], axis=0), alpha=0.3, color='b') 
plt.plot(gcn_mean, 'r', label='GCN') # GCN
plt.fill_between(np.linspace(0, num_steps, num_steps), np.min([rews_buf4, rews_buf5, rews_buf6], axis=0), np.max([rews_buf4, rews_buf5, rews_buf6], axis=0), alpha=0.3, color='r') 
plt.plot(gat_mean, 'lime', label='GAT') # GAT
plt.fill_between(np.linspace(0, num_steps, num_steps), np.min([rews_buf7, rews_buf8, rews_buf9], axis=0), np.max([rews_buf7, rews_buf8, rews_buf9], axis=0), alpha=0.3, color='lime') 
plt.plot(mlp_mean, 'yellow', label='MLP') # MLP 
plt.fill_between(np.linspace(0, num_steps, num_steps), np.min([rews_buf10, rews_buf11, rews_buf12], axis=0), np.max([rews_buf10, rews_buf11, rews_buf12], axis=0), alpha=0.3, color='yellow') 
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
plt.savefig(f'./pics/DC_{best_file}.pdf', format='pdf', bbox_inches='tight')
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
plt.savefig(f'./pics/PSRR_{best_file}.pdf', format='pdf', bbox_inches='tight')
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

plt.savefig(f'./pics/loop_stb_{best_file}.pdf', format='pdf', bbox_inches='tight')
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

plt.savefig(f'./pics/load_reg_{best_file}.pdf', format='pdf', bbox_inches='tight')
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
axs[1].set_ylabel('$\mathbf{V_{reg}}$ (V) at $\mathbf{I_{L,min}}$', fontweight='bold', fontsize=14)
axs[1].xaxis.set_tick_params(labelsize='14')
axs[1].yaxis.set_tick_params(labelsize='14')
axs[1].spines['bottom'].set_linewidth(2)
axs[1].spines['left'].set_linewidth(2)
axs[1].spines['right'].set_linewidth(2)
axs[1].spines['top'].set_linewidth(2)
axs[1].grid(linewidth=2)
axs[1].set_xlabel('Time ($\mathbf{\mu s}$)', fontweight='bold', fontsize=14)

plt.savefig(f'./pics/line_reg_minload_{best_file}.pdf', format='pdf', bbox_inches='tight')
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
axs[1].set_ylabel('$\mathbf{V_{reg}}$ (V) at $\mathbf{I_{L,max}}$', fontweight='bold', fontsize=14)
axs[1].xaxis.set_tick_params(labelsize='14')
axs[1].yaxis.set_tick_params(labelsize='14')
axs[1].spines['bottom'].set_linewidth(2)
axs[1].spines['left'].set_linewidth(2)
axs[1].spines['right'].set_linewidth(2)
axs[1].spines['top'].set_linewidth(2)
axs[1].grid(linewidth=2)
axs[1].set_xlabel('Time ($\mathbf{\mu s}$)', fontweight='bold', fontsize=14)

plt.savefig(f'./pics/line_reg_maxload_{best_file}.pdf', format='pdf', bbox_inches='tight')
plt.savefig(f'./pics/line_reg_maxload_{best_file}.png', format='png', bbox_inches='tight')
