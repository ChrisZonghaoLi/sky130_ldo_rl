#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov  2 16:20:56 2022

@author: zonghao
"""

import torch
import numpy as np
import os
import json
from tabulate import tabulate
import gymnasium as gym
from gymnasium import spaces

from ckt_graphs import GraphLDOFoldedCascode 
from dev_params import DeviceParams
from utils import ActionNormalizer, OutputParser
from datetime import datetime

date = datetime.today().strftime('%Y-%m-%d')
PWD = os.getcwd()
SPICE_NETLIST_DIR = f'{PWD}/simulations'
os.environ['CUDA_LAUNCH_BLOCKING'] = "1"

CktGraph = GraphLDOFoldedCascode
            
class LDOFoldedCascodeEnv(gym.Env, CktGraph, DeviceParams):

    def __init__(self):
        gym.Env.__init__(self)
        CktGraph.__init__(self)
        DeviceParams.__init__(self, self.ckt_hierarchy)

        self.CktGraph = CktGraph()
        self.observation_space = spaces.Box(low=-np.inf, high=np.inf, shape=self.obs_shape, dtype=np.float64)
        self.action_space = spaces.Box(low=-1, high=1, shape=self.action_shape, dtype=np.float64)
        
    def _initialize_simulation(self):
        self.W_M1, self.L_M1, \
        self.W_M3, self.L_M3, \
        self.W_M5, self.L_M5, \
        self.W_M7, self.L_M7, \
        self.W_M9, self.L_M9, \
        self.W_pass, self.L_pass, self.M_pass, \
        self.Vb1, self.Vb2,  \
        self.M_Rfb, \
        self.M_Cfb, \
        self.M_CL = \
        np.array([10, 1, 
                         10, 1,
                         10, 1,
                         10, 1,
                         10, 1,
                         10, 0.5, 1000,
                         1.2, 0.6, 
                         10,
                         10,
                        200])

        """Run the initial simulations."""  
        action = np.array([self.W_M1, self.L_M1, \
                self.W_M3, self.L_M3, \
                self.W_M5, self.L_M5, \
                self.W_M7, self.L_M7, \
                self.W_M9, self.L_M9, \
                self.W_pass, self.L_pass, self.M_pass, \
                self.Vb1, self.Vb2, \
                self.M_Rfb, \
                self.M_Cfb, \
                self.M_CL])
        self.do_simulation(action)
        
    def _do_simulation(self, action: np.array):
        W_M1, L_M1, \
        W_M3, L_M3, \
        W_M5, L_M5, \
        W_M7, L_M7, \
        W_M9, L_M9, \
        W_pass, L_pass, M_pass, \
        Vb1, Vb2, \
        M_Rfb, \
        M_Cfb, \
        M_CL = action 
        
        M_pass = int(M_pass)
        M_Rfb = int(M_Rfb)
        M_Cfb = int(M_Cfb)
        M_CL = int(M_CL)
        
        # update netlist
        try:
            # open the netlist of the testbench
            ldo_folded_cascode_tb_vars = open(f'{SPICE_NETLIST_DIR}/ldo_folded_cascode_tb_vars.spice', 'r')
            lines = ldo_folded_cascode_tb_vars.readlines()
            
            lines[0] = f'.param W_M1={W_M1} L_M1={L_M1}\n'
            lines[1] = f'.param W_M2=W_M1 L_M2=L_M1\n'
            lines[2] = f'.param W_M3={W_M3} L_M3={L_M3}\n'
            lines[3] = f'.param W_M4=W_M3 L_M4=L_M3\n'
            lines[4] = f'.param W_M5={W_M5} L_M5={L_M5}\n'
            lines[5] = f'.param W_M6=W_M5 L_M6=L_M5\n'
            lines[6] = f'.param W_M7={W_M7} L_M7={L_M7}\n'
            lines[7] = f'.param W_M8=W_M7 L_M8=L_M7\n'
            lines[8] = f'.param W_M9={W_M9} L_M9={L_M9}\n'
            lines[9] = f'.param W_pass={W_pass} L_pass={L_pass} M_pass={M_pass}\n'
            lines[10] = f'.param Vb1={Vb1}\n'
            lines[11] = f'.param Vb2={Vb2}\n'
            lines[12] = f'.param M_Rfb={M_Rfb}\n'
            lines[13] = f'.param M_Cfb={M_Cfb}\n'
            lines[14] = f'.param M_CL={M_CL}\n'
            
            lines[16] = f'.param Vref={self.Vref}\n'
                    
            ldo_folded_cascode_tb_vars = open(f'{SPICE_NETLIST_DIR}/ldo_folded_cascode_tb_vars.spice', 'w')
            ldo_folded_cascode_tb_vars.writelines(lines)
            ldo_folded_cascode_tb_vars.close()
            
            print('*** Simulations for Loop Stability, load regulation, DC and PSRR ***')
            os.system(f'cd {SPICE_NETLIST_DIR}; ngspice -b -o ldo_folded_cascode_tb.log ldo_folded_cascode_tb.spice')
            print('*** Simulations Done! ***')
        except:
            print('ERROR')

    def do_simulation(self, action):
        self._do_simulation(action)
        self.sim_results = OutputParser(self.CktGraph)
        self.op_results = self.sim_results.dcop(file_name='ldo_folded_cascode_tb_op')

    def reset(self, seed=None, options=None):
        super().reset(seed=seed)
        self._initialize_simulation()
        observation = self._get_obs()
        info = self._get_info()
        return observation, info
    
    def close(self):
        return None
    
    def step(self, action):
        action = ActionNormalizer(action_space_low=self.action_space_low, action_space_high = \
                                       self.action_space_high).action(action) # convert [-1.1] range back to normal range
        action = action.astype(object)
        
        print(f"action: {action}")
        
        self.W_M1, self.L_M1, \
        self.W_M3, self.L_M3, \
        self.W_M5, self.L_M5, \
        self.W_M7, self.L_M7, \
        self.W_M9, self.L_M9, \
        self.W_pass, self.L_pass, self.M_pass, \
        self.Vb1, self.Vb2,  \
        self.M_Rfb, \
        self.M_Cfb, \
        self.M_CL = action        
        
        ''' run simulations '''
        self.do_simulation(action)
        
        '''get observation'''
        observation = self._get_obs()
        info = self._get_info()

        reward = self.reward
        
        terminated = False
            
        print(tabulate(
            [
                ['Drop-out voltage (mV)', self.Vdrop*1e3, self.Vdrop_target*1e3],
                ['Load regulation (mV)', self.Vload_reg_delta*1e3, self.Vload_reg_delta_target*1e3],
                
                # ['Line regulation at minload (mV)', self.Vline_reg_minload_delta*1e3, self.Vline_reg_delta_target*1e3],
                # ['Line regulation at maxload (mV)', self.Vline_reg_maxload_delta*1e3, self.Vline_reg_delta_target*1e3],
                
                ['PSRR worst maxload (dB) < 10kHz', 20*np.log10(self.PSRR_maxload_worst_10kHz), 20*np.log10(self.PSRR_target_10kHz)],
                ['PSRR worst maxload (dB) < 1MHz', 20*np.log10(self.PSRR_maxload_worst_1MHz), 20*np.log10(self.PSRR_target_1MHz)],
                ['PSRR worst maxload (dB) > 1MHz', 20*np.log10(self.PSRR_maxload_worst_above_1MHz), 20*np.log10(self.PSRR_target_above_1MHz)],
                
                ['PSRR worst minload (dB) < 10kHz', 20*np.log10(self.PSRR_minload_worst_10kHz), 20*np.log10(self.PSRR_target_10kHz)],
                ['PSRR worst minload (dB) < 1MHz', 20*np.log10(self.PSRR_minload_worst_1MHz), 20*np.log10(self.PSRR_target_1MHz)],
                ['PSRR worst minload (dB) > 1MHz', 20*np.log10(self.PSRR_minload_worst_above_1MHz), 20*np.log10(self.PSRR_target_above_1MHz)],
                
                ['Loop-gain PM (deg) at max load', self.phase_margin_maxload, self.phase_margin_target],
                ['Loop-gain PM (deg) at min load', self.phase_margin_minload, self.phase_margin_target],
                
                ['Iq (uA)', self.Iq*1e6, self.Iq_target*1e6],
                ['CL (pF)', self.op_results['CL']['c']*1e12, ''],
                
                ['Vdrop score', self.Vdrop_score, ''],
                ['Load regulation score', self.load_reg_score, ''],
                
                # ['Line regulation score at minload', self.line_reg_minload_score, ''],
                # ['Line regulation score at maxload', self.line_reg_maxload_score, ''],
                
                ['PSRR worst maxload (dB) < 10kHz score', self.PSRR_maxload_worst_10kHz_score, ''],
                ['PSRR worst maxload (dB) < 1MHz score', self.PSRR_maxload_worst_1MHz_score, ''],
                ['PSRR worst maxload (dB) > 1MHz score', self.PSRR_maxload_worst_above_1MHz_score, ''],
                
                ['PSRR worst minload (dB) < 10kHz score', self.PSRR_minload_worst_10kHz_score, ''],
                ['PSRR worst minload (dB) < 1MHz score', self.PSRR_minload_worst_1MHz_score, ''],
                ['PSRR worst minload (dB) > 1MHz score', self.PSRR_minload_worst_above_1MHz_score, ''],
                
                ['PM score minload', self.phase_margin_minload_score, ''],
                ['PM score maxload', self.phase_margin_maxload_score, ''],
                ['Iq score', self.Iq_score, ''],
                
                ['CL area score', self.CL_area_score, ''],
                ['Reward', reward, '']
                ],
            headers=['param', 'num', 'target'], tablefmt='orgtbl', numalign='right', floatfmt=".2f"
            ))

        return observation, reward, terminated, False, info
        
    def _get_obs(self):
        # pick some .OP params from the dict:
        try:
            f = open(f'{SPICE_NETLIST_DIR}/ldo_folded_cascode_tb_op_mean_std.json')
            self.op_mean_std = json.load(f)
            self.op_mean = self.op_mean_std['OP_M_mean']
            self.op_std = self.op_mean_std['OP_M_std']
            self.op_mean = np.array([self.op_mean['id'], self.op_mean['gm'], self.op_mean['gds'], self.op_mean['vth'], self.op_mean['vdsat'], self.op_mean['vds'], self.op_mean['vgs']])
            self.op_std = np.array([self.op_std['id'], self.op_std['gm'], self.op_std['gds'], self.op_std['vth'], self.op_std['vdsat'], self.op_std['vds'], self.op_std['vgs']])
        except:
            print('You need to run <_random_op_sims> to generate mean and std for transistor .OP parameters')
        
        self.OP_M1 = self.op_results['M1']
        self.OP_M1_norm = (np.array([self.OP_M1['id'],
                                self.OP_M1['gm'],
                                self.OP_M1['gds'],
                                self.OP_M1['vth'],
                                self.OP_M1['vdsat'],
                                self.OP_M1['vds'],
                                self.OP_M1['vgs']
                                ]) - self.op_mean)/self.op_std
        self.OP_M2 = self.op_results['M2']
        self.OP_M2_norm = (np.array([self.OP_M2['id'],
                                self.OP_M2['gm'],
                                self.OP_M2['gds'],
                                self.OP_M2['vth'],
                                self.OP_M2['vdsat'],
                                self.OP_M2['vds'],
                                self.OP_M2['vgs']
                                ]) - self.op_mean)/self.op_std
        self.OP_M3 = self.op_results['M3']
        self.OP_M3_norm = (np.abs([self.OP_M3['id'],
                                self.OP_M3['gm'],
                                self.OP_M3['gds'],
                                self.OP_M3['vth'],
                                self.OP_M3['vdsat'],
                                self.OP_M3['vds'],
                                self.OP_M3['vgs']
                                ]) - self.op_mean)/self.op_std
        self.OP_M4 = self.op_results['M4']
        self.OP_M4_norm = (np.abs([self.OP_M4['id'],
                                self.OP_M4['gm'],
                                self.OP_M4['gds'],
                                self.OP_M4['vth'],
                                self.OP_M4['vdsat'],
                                self.OP_M4['vds'],
                                self.OP_M4['vgs']
                                ]) - self.op_mean)/self.op_std
        self.OP_M5 = self.op_results['M5']
        self.OP_M5_norm = (np.abs([self.OP_M5['id'],
                                self.OP_M5['gm'],
                                self.OP_M5['gds'],
                                self.OP_M5['vth'],
                                self.OP_M5['vdsat'],
                                self.OP_M5['vds'],
                                self.OP_M5['vgs']
                                ]) - self.op_mean)/self.op_std
        self.OP_M6 = self.op_results['M6']
        self.OP_M6_norm = (np.array([self.OP_M6['id'],
                                self.OP_M6['gm'],
                                self.OP_M6['gds'],
                                self.OP_M6['vth'],
                                self.OP_M6['vdsat'],
                                self.OP_M6['vds'],
                                self.OP_M6['vgs']
                                ]) - self.op_mean)/self.op_std
        self.OP_M7 = self.op_results['M7']
        self.OP_M7_norm = (np.array([self.OP_M7['id'],
                                self.OP_M7['gm'],
                                self.OP_M7['gds'],
                                self.OP_M7['vth'],
                                self.OP_M7['vdsat'],
                                self.OP_M7['vds'],
                                self.OP_M7['vgs']
                                ]) - self.op_mean)/self.op_std
        self.OP_M8 = self.op_results['M8']
        self.OP_M8_norm = (np.array([self.OP_M8['id'],
                                self.OP_M8['gm'],
                                self.OP_M8['gds'],
                                self.OP_M8['vth'],
                                self.OP_M8['vdsat'],
                                self.OP_M8['vds'],
                                self.OP_M8['vgs']
                                ]) - self.op_mean)/self.op_std
        self.OP_M9 = self.op_results['M9']
        self.OP_M9_norm = (np.array([self.OP_M9['id'],
                                self.OP_M9['gm'],
                                self.OP_M9['gds'],
                                self.OP_M9['vth'],
                                self.OP_M9['vdsat'],
                                self.OP_M9['vds'],
                                self.OP_M9['vgs']
                                ]) - self.op_mean)/self.op_std
        self.OP_M10 = self.op_results['M10']
        self.OP_M10_norm = (np.array([self.OP_M10['id'],
                                self.OP_M10['gm'],
                                self.OP_M10['gds'],
                                self.OP_M10['vth'],
                                self.OP_M10['vdsat'],
                                self.OP_M10['vds'],
                                self.OP_M10['vgs']
                                ]) - self.op_mean)/self.op_std
        
        # it is not straightforward to extract resistance info from sky130 resistor, using the following approximation instead
        # normalize all passive components
        self.Rfb =  self.Rsheet * self.L_Rfb / self.W_Rfb / self.M_Rfb  
        self.OP_Rfb_norm = ActionNormalizer(action_space_low=self.Rfb_low, action_space_high=self.Rfb_high).reverse_action(self.Rfb) # convert to (-1, 1)
        self.OP_Cfb_norm = ActionNormalizer(action_space_low=self.Cfb_low, action_space_high=self.Cfb_high).reverse_action(self.op_results['Cfb']['c']) # convert to (-1, 1)
        self.OP_CL_norm = ActionNormalizer(action_space_low=self.CL_low, action_space_high=self.CL_high).reverse_action(self.op_results['CL']['c']) # convert to (-1, 1)
        
        # state shall be in the order of node (node0, node1, ...)
        observation = np.array([
                               [0,0,0,0,      0,0,0,      self.OP_M1_norm[0],self.OP_M1_norm[1],self.OP_M1_norm[2],self.OP_M1_norm[3],self.OP_M1_norm[4],self.OP_M1_norm[5],self.OP_M1_norm[6]],
                               [0,0,0,0,      0,0,0,      self.OP_M2_norm[0],self.OP_M2_norm[1],self.OP_M2_norm[2],self.OP_M2_norm[3],self.OP_M2_norm[4],self.OP_M2_norm[5],self.OP_M2_norm[6]],
                               [0,0,0,0,      0,0,0,      self.OP_M3_norm[0],self.OP_M3_norm[1],self.OP_M3_norm[2],self.OP_M3_norm[3],self.OP_M3_norm[4],self.OP_M3_norm[5],self.OP_M3_norm[6]],
                               [0,0,0,0,      0,0,0,      self.OP_M4_norm[0],self.OP_M4_norm[1],self.OP_M4_norm[2],self.OP_M4_norm[3],self.OP_M4_norm[4],self.OP_M4_norm[5],self.OP_M4_norm[6]],
                               [0,0,0,0,      0,0,0,      self.OP_M5_norm[0],self.OP_M5_norm[1],self.OP_M5_norm[2],self.OP_M5_norm[3],self.OP_M5_norm[4],self.OP_M5_norm[5],self.OP_M5_norm[6]],
                               [0,0,0,0,      0,0,0,      self.OP_M6_norm[0],self.OP_M6_norm[1],self.OP_M6_norm[2],self.OP_M6_norm[3],self.OP_M6_norm[4],self.OP_M6_norm[5],self.OP_M6_norm[6]],
                               [0,0,0,0,      0,0,0,      self.OP_M7_norm[0],self.OP_M7_norm[1],self.OP_M7_norm[2],self.OP_M7_norm[3],self.OP_M7_norm[4],self.OP_M7_norm[5],self.OP_M7_norm[6]],
                               [0,0,0,0,      0,0,0,      self.OP_M8_norm[0],self.OP_M8_norm[1],self.OP_M8_norm[2],self.OP_M8_norm[3],self.OP_M8_norm[4],self.OP_M8_norm[5],self.OP_M8_norm[6]],
                               [0,0,0,0,      0,0,0,      self.OP_M9_norm[0],self.OP_M9_norm[1],self.OP_M9_norm[2],self.OP_M9_norm[3],self.OP_M9_norm[4],self.OP_M9_norm[5],self.OP_M9_norm[6]],
                               [0,0,0,0,      0,0,0,      self.OP_M10_norm[0],self.OP_M10_norm[1],self.OP_M10_norm[2],self.OP_M10_norm[3],self.OP_M10_norm[4],self.OP_M10_norm[5],self.OP_M10_norm[6]],     
                               
                               [0,0,self.Vb1,0,   0,0,0,    0,0,0,0,0,0,0],
                               [0,0,0,self.Vb2,   0,0,0,    0,0,0,0,0,0,0],
                                                              
                               [0,0,0,0,      self.OP_Rfb_norm,0,0,        0,0,0,0,0,0,0],
                               [0,0,0,0,      0,self.OP_Cfb_norm,0,        0,0,0,0,0,0,0],
                               [0,0,0,0,      0,0,self.OP_CL_norm,       0,0,0,0,0,0,0],

                               [self.Vdd,0,0,0,       0,0,0,      0,0,0,0,0,0,0],
                               [0,self.GND,0,0,       0,0,0,      0,0,0,0,0,0,0],
                               
                               ])
        # clip the obs for better regularization
        observation = np.clip(observation, -5, 5)
        
        return observation
        
    def _get_info(self):
        '''Evaluate the performance'''
        ''' DC performance '''
        self.dc_results = self.sim_results.dc(file_name='ldo_folded_cascode_tb_dc')
        idx = int(self.Vdd/0.01 - 1/0.01) # since I sweep Vdc from 1V - 3V to avoid some bad DC points 
        self.Vdrop =  abs(self.Vdd - self.dc_results[1][idx])
        
        self.Vdrop_score = np.min([(self.Vdrop_target - self.Vdrop) / (self.Vdrop_target + self.Vdrop), 0])
    
        """ Load regulation """
        _, self.load_reg = self.sim_results.tran(file_name='ldo_folded_cascode_tb_load_reg')
        idx_1 = int(len(self.load_reg)/4)
        idx_2 = len(self.load_reg) - 1
        self.Vload_reg_delta = abs(self.load_reg[idx_2] - self.load_reg[idx_1])
        
        self.load_reg_score = np.min([(self.Vload_reg_delta_target - self.Vload_reg_delta) / (self.Vload_reg_delta_target + self.Vload_reg_delta), 0])
    
        # """ line regulation at min load current """
        # _, self.line_reg_minload = self.sim_results.tran(file_name='ldo_folded_cascode_tb_line_reg_minload')
        # self.Vline_reg_minload_delta = abs(max(self.line_reg_minload) - min(self.line_reg_minload))
        
        # self.line_reg_minload_score = np.min([(self.Vline_reg_delta_target - self.Vline_reg_minload_delta) / (self.Vline_reg_delta_target + self.Vline_reg_minload_delta), 0])
    
        # """ line regulation at max load current """
        # _, self.line_reg_maxload = self.sim_results.tran(file_name='ldo_folded_cascode_tb_line_reg_maxload')
        # self.Vline_reg_maxload_delta = abs(max(self.line_reg_maxload) - min(self.line_reg_maxload))
        
        # self.line_reg_maxload_score = np.min([(self.Vline_reg_delta_target - self.Vline_reg_maxload_delta) / (self.Vline_reg_delta_target + self.Vline_reg_maxload_delta), 0])
    
        ''' PSRR performance at max load current '''
        self.psrr_results_maxload = self.sim_results.ac(file_name='ldo_folded_cascode_tb_psrr_maxload')
        freq = self.psrr_results_maxload[0]
        # @ 10 kHz
        idx_10kHz = int(10 * np.log10(self.PSRR_10kHz))
        # @ 1 MHz
        idx_1MHz = int(10 * np.log10(self.PSRR_1MHz))
        self.PSRR_maxload_worst_10kHz = max(self.psrr_results_maxload[1][:idx_10kHz]) # in linear scale
        self.PSRR_maxload_worst_1MHz = max(self.psrr_results_maxload[1][:idx_1MHz]) # in linear scale
        self.PSRR_maxload_worst_above_1MHz = max(self.psrr_results_maxload[1][idx_1MHz:]) # in linear scale
        
        if self.rew_eng == True:
            # @ 10 kHz
            if 20*np.log10(self.PSRR_maxload_worst_10kHz) > 0:
                self.PSRR_maxload_worst_10kHz_score = -1 
            else:
                self.PSRR_maxload_worst_10kHz_score =  np.min([(self.PSRR_target_10kHz - self.PSRR_maxload_worst_10kHz) / (self.PSRR_maxload_worst_10kHz + self.PSRR_target_10kHz), 0])
                self.PSRR_maxload_worst_10kHz_score =  self.PSRR_maxload_worst_10kHz_score * 0.5 # give a weights
    
            # @ 1MHz
            if 20*np.log10(self.PSRR_maxload_worst_1MHz) > 0:
                self.PSRR_maxload_worst_1MHz_score = -1
            else:
                self.PSRR_maxload_worst_1MHz_score =  np.min([(self.PSRR_target_1MHz - self.PSRR_maxload_worst_1MHz) / (self.PSRR_maxload_worst_1MHz + self.PSRR_target_1MHz), 0])
        
            # beyond 1 MHz
            if 20*np.log10(self.PSRR_maxload_worst_above_1MHz) > 0:
                self.PSRR_maxload_worst_above_1MHz_score = -1 
            else:
                self.PSRR_maxload_worst_above_1MHz_score =  np.min([(self.PSRR_target_above_1MHz - self.PSRR_maxload_worst_above_1MHz) / (self.PSRR_maxload_worst_above_1MHz + self.PSRR_target_above_1MHz), 0])
        else:
            # @ 10 kHz
            self.PSRR_maxload_worst_10kHz_score =  np.min([(self.PSRR_target_10kHz - self.PSRR_maxload_worst_10kHz) / (self.PSRR_maxload_worst_10kHz + self.PSRR_target_10kHz), 0])
            # @ 1MHz
            self.PSRR_maxload_worst_1MHz_score =  np.min([(self.PSRR_target_1MHz - self.PSRR_maxload_worst_1MHz) / (self.PSRR_maxload_worst_1MHz + self.PSRR_target_1MHz), 0])
            # beyond 1 MHz
            self.PSRR_maxload_worst_above_1MHz_score =  np.min([(self.PSRR_target_above_1MHz - self.PSRR_maxload_worst_above_1MHz) / (self.PSRR_maxload_worst_above_1MHz + self.PSRR_target_above_1MHz), 0])
        
        ''' PSRR performance at min load current '''
        self.psrr_results_minload = self.sim_results.ac(file_name='ldo_folded_cascode_tb_psrr_minload')
        freq = self.psrr_results_minload[0]
        # @ 10 kHz
        idx_10kHz = int(10 * np.log10(self.PSRR_10kHz))
        # @ 1 MHz
        idx_1MHz = int(10 * np.log10(self.PSRR_1MHz))
        self.PSRR_minload_worst_10kHz = max(self.psrr_results_minload[1][:idx_10kHz]) # in linear scale
        self.PSRR_minload_worst_1MHz = max(self.psrr_results_minload[1][:idx_1MHz]) # in linear scale
        self.PSRR_minload_worst_above_1MHz = max(self.psrr_results_minload[1][idx_1MHz:]) # in linear scale
    
        if self.rew_eng == True:
            # @ 10 kHz
            if 20*np.log10(self.PSRR_minload_worst_10kHz) > 0:
                self.PSRR_minload_worst_10kHz_score = -1 
            else:
                self.PSRR_minload_worst_10kHz_score =  np.min([(self.PSRR_target_10kHz - self.PSRR_minload_worst_10kHz) / (self.PSRR_minload_worst_10kHz + self.PSRR_target_10kHz), 0])
                self.PSRR_minload_worst_10kHz_score =  self.PSRR_minload_worst_10kHz_score * 0.5 # give a weights
    
            # @ 1MHz
            if 20*np.log10(self.PSRR_minload_worst_1MHz) > 0:
                self.PSRR_minload_worst_1MHz_score = -1 
            else:
                self.PSRR_minload_worst_1MHz_score =  np.min([(self.PSRR_target_1MHz - self.PSRR_minload_worst_1MHz) / (self.PSRR_minload_worst_1MHz + self.PSRR_target_1MHz), 0])
        
            # beyond 1 MHz
            if 20*np.log10(self.PSRR_minload_worst_above_1MHz) > 0:
                self.PSRR_minload_worst_above_1MHz_score = -1 
            else:
                self.PSRR_minload_worst_above_1MHz_score =  np.min([(self.PSRR_target_above_1MHz - self.PSRR_minload_worst_above_1MHz) / (self.PSRR_minload_worst_above_1MHz + self.PSRR_target_above_1MHz), 0])
        else:
            # @ 10 kHz
            self.PSRR_minload_worst_10kHz_score =  np.min([(self.PSRR_target_10kHz - self.PSRR_minload_worst_10kHz) / (self.PSRR_minload_worst_10kHz + self.PSRR_target_10kHz), 0])
            # @ 1MHz
            self.PSRR_minload_worst_1MHz_score =  np.min([(self.PSRR_target_1MHz - self.PSRR_minload_worst_1MHz) / (self.PSRR_minload_worst_1MHz + self.PSRR_target_1MHz), 0])
            # beyond 1 MHz
            self.PSRR_minload_worst_above_1MHz_score =  np.min([(self.PSRR_target_above_1MHz - self.PSRR_minload_worst_above_1MHz) / (self.PSRR_minload_worst_above_1MHz + self.PSRR_target_above_1MHz), 0])
        
        ''' Loop-gain phase margin at max load current'''
        self.loop_gain_results_maxload = self.sim_results.ac(file_name='ldo_folded_cascode_tb_loop_gain_maxload')
        freq = self.loop_gain_results_maxload[0]
        self.loop_gain_mag_maxload = 20*np.log10(self.loop_gain_results_maxload[1])
        self.loop_gain_phase_maxload = self.loop_gain_results_maxload[2] # in degree
        if self.loop_gain_mag_maxload[0] < 0: # if DC gain is smaller than 0 dB
            self.phase_margin_maxload = 0 # phase margin becomes meaningless 
        else:  
            try:
                idx = [i for i,j in enumerate(self.loop_gain_mag_maxload[:-1] * self.loop_gain_mag_maxload[1:]) if j<0][0]+1 
                phase_margin_maxload = np.min(self.loop_gain_phase_maxload[:idx]) + 180
            except: # this rarely happens: unity gain is larger than the frequency sweep
                idx = len(self.loop_gain_phase_maxload)
                phase_margin_maxload = np.min(self.loop_gain_phase_maxload[:idx]) + 180
            if phase_margin_maxload > 180 or phase_margin_maxload < 0:
                self.phase_margin_maxload = 0
            else:
                self.phase_margin_maxload = phase_margin_maxload
        
        ''' Loop-gain phase margin at min load current'''
        self.loop_gain_results_minload = self.sim_results.ac(file_name='ldo_folded_cascode_tb_loop_gain_minload')
        freq = self.loop_gain_results_minload[0]
        self.loop_gain_mag_minload = 20*np.log10(self.loop_gain_results_minload[1])
        self.loop_gain_phase_minload = self.loop_gain_results_minload[2] # in degree
        if self.loop_gain_mag_minload[0] < 0: # if DC gain is smaller than 0 dB
            self.phase_margin_minload = 0 # phase margin becomes meaningless 
        else:  
            try:
                idx = [i for i,j in enumerate(self.loop_gain_mag_minload[:-1] * self.loop_gain_mag_minload[1:]) if j<0][0]+1 
                phase_margin_minload = np.min(self.loop_gain_phase_minload[:idx]) + 180
            except: # this rarely happens: unity gain is larger than the frequency sweep
                idx = len(self.loop_gain_phase_minload)
                phase_margin_minload = np.min(self.loop_gain_phase_minload[:idx]) + 180
            if phase_margin_minload > 180 or phase_margin_minload < 0:
                self.phase_margin_minload = 0
            else:
                self.phase_margin_minload = phase_margin_minload
        
        if self.rew_eng == True:
            if self.phase_margin_minload < 45:
                self.phase_margin_minload_score = -1 + np.min([(self.phase_margin_minload - self.phase_margin_target) / (self.phase_margin_minload + self.phase_margin_target), 0])  # fight against PSRR
            else:
                self.phase_margin_minload_score = np.min([(self.phase_margin_minload - self.phase_margin_target) / (self.phase_margin_minload + self.phase_margin_target), 0]) # larger PM is better    
                
            if self.phase_margin_maxload < 45:
                self.phase_margin_maxload_score = -1 + np.min([(self.phase_margin_maxload - self.phase_margin_target) / (self.phase_margin_maxload + self.phase_margin_target), 0]) 
            else:
                self.phase_margin_maxload_score = np.min([(self.phase_margin_maxload - self.phase_margin_target) / (self.phase_margin_maxload + self.phase_margin_target), 0]) # larger PM is better
        else:
            self.phase_margin_minload_score = np.min([(self.phase_margin_minload - self.phase_margin_target) / (self.phase_margin_minload + self.phase_margin_target), 0]) # larger PM is better    
            self.phase_margin_maxload_score = np.min([(self.phase_margin_maxload - self.phase_margin_target) / (self.phase_margin_maxload + self.phase_margin_target), 0]) # larger PM is better
        
        """ Quiescent current exclude load current """
        self.Iq = self.OP_M3['id'] + self.OP_M4['id']
        self.Iq_score = np.min([(self.Iq_target - self.Iq) / (self.Iq_target + self.Iq), 0]) # smaller iq is better
        
        """ Decap score """
        self.CL_area_score = (self.CL_low - self.op_results['CL']['c']) / (self.CL_low + self.op_results['CL']['c'])
    
        """ Total reward """
        self.reward = self.PSRR_maxload_worst_10kHz_score +  self.PSRR_maxload_worst_1MHz_score + self.PSRR_maxload_worst_above_1MHz_score + \
            self.PSRR_minload_worst_10kHz_score +  self.PSRR_minload_worst_1MHz_score + self.PSRR_minload_worst_above_1MHz_score + \
                self.phase_margin_minload_score + self.phase_margin_maxload_score + \
                self.Iq_score + self.load_reg_score #+ self.line_reg_minload_score + self.line_reg_maxload_score
        
        if self.reward >= 0:
            self.reward = self.reward + self.CL_area_score + 10
                    
        return {
                'Drop-out voltage (mV)': self.Vdrop*1e3,
                'Load regulation (mV)': self.Vload_reg_delta*1e3,
                
                # 'Line regulation at minload (mV)': self.Vline_reg_minload_delta*1e3,
                # 'Line regulation at maxload (mV)': self.Vline_reg_maxload_delta*1e3,
                
                'PSRR worst maxload (dB) < 10kHz': 20*np.log10(self.PSRR_maxload_worst_10kHz),
                'PSRR worst maxload (dB) < 1MHz': 20*np.log10(self.PSRR_maxload_worst_1MHz),
                'PSRR worst maxload (dB) > 1MHz': 20*np.log10(self.PSRR_maxload_worst_above_1MHz),
                
                'PSRR worst minload (dB) < 10kHz': 20*np.log10(self.PSRR_minload_worst_10kHz),
                'PSRR worst minload (dB) < 1MHz': 20*np.log10(self.PSRR_minload_worst_1MHz),
                'PSRR worst minload (dB) > 1MHz': 20*np.log10(self.PSRR_minload_worst_above_1MHz),
                
                'Loop-gain PM (deg) at max load': self.phase_margin_maxload, 
                'Loop-gain PM (deg) at min load': self.phase_margin_minload, 
                'Iq (uA)': self.Iq*1e6, 
                'CL (pF)': self.op_results['CL']['c']*1e12
            }


    def _init_random_sim(self, max_sims=100):
        '''
        
        This is NOT the same as the random step in the agent, here is basically 
        doing some completely random design variables selection for generating
        some device parameters for calculating the mean and variance for each
        .OP device parameters (getting a statistical idea of, how each ckt parameter's range is like'), 
        so that you can do the normalization for the state representations later.
    
        '''

        random_op_count = 0
        OP_M_lists = []
        OP_R_lists = []
        OP_C_lists = []
        OP_V_lists = []
        
        while random_op_count <= max_sims :
            print(f'* simulation #{random_op_count} *')
            action = np.random.uniform(self.action_space_low, self.action_space_high, self.action_dim) 
            print(f'action: {action}')
            self._do_simulation(action)
    
            sim_results = OutputParser(self.CktGraph)
            op_results = sim_results.dcop(file_name='ldo_folded_cascode_tb_op')
            
            OP_M_list = []
            OP_R_list = []
            OP_C_list = []
            OP_V_list = []

            for key in list(op_results):
                if key[0] == 'M' or key[0] == 'm':
                    OP_M = np.array([op_results[key][f'{item}'] for item in list(op_results[key])])    
                    OP_M_list.append(OP_M)
                elif key[0] == 'R' or key[0] == 'r':
                    OP_R = np.array([op_results[key][f'{item}'] for item in list(op_results[key])])    
                    OP_R_list.append(OP_R)
                elif key[0] == 'C' or key[0] == 'c':
                    OP_C = np.array([op_results[key][f'{item}'] for item in list(op_results[key])])    
                    OP_C_list.append(OP_C)   
                elif key[0] == 'V' or key[0] == 'v':
                    OP_V = np.array([op_results[key][f'{item}'] for item in list(op_results[key])])    
                    OP_V_list.append(OP_V)   
                else:
                    None
                    
            OP_M_list = np.array(OP_M_list)
            OP_R_list = np.array(OP_R_list)
            OP_C_list = np.array(OP_C_list)
            OP_V_list = np.array(OP_V_list)
                        
            OP_M_lists.append(OP_M_list)
            OP_R_lists.append(OP_R_list)
            OP_C_lists.append(OP_C_list)
            OP_V_lists.append(OP_V_list)
            
            random_op_count = random_op_count + 1

        OP_M_lists = np.array(OP_M_lists)
        OP_R_lists = np.array(OP_R_lists)
        OP_C_lists = np.array(OP_C_lists)
        OP_V_lists = np.array(OP_V_lists)
        
        if OP_M_lists.size != 0:
            OP_M_mean = np.mean(OP_M_lists.reshape(-1, OP_M_lists.shape[-1]), axis=0)
            OP_M_std = np.std(OP_M_lists.reshape(-1, OP_M_lists.shape[-1]),axis=0)
            OP_M_mean_dict = {}
            OP_M_std_dict = {}
            for idx, key in enumerate(self.params_mos):
                OP_M_mean_dict[key] = OP_M_mean[idx]
                OP_M_std_dict[key] = OP_M_std[idx]
        
        if OP_R_lists.size != 0:
            OP_R_mean = np.mean(OP_R_lists.reshape(-1, OP_R_lists.shape[-1]), axis=0)
            OP_R_std = np.std(OP_R_lists.reshape(-1, OP_R_lists.shape[-1]),axis=0)
            OP_R_mean_dict = {}
            OP_R_std_dict = {}
            for idx, key in enumerate(self. params_r):
                OP_R_mean_dict[key] = OP_R_mean[idx]
                OP_R_std_dict[key] = OP_R_std[idx]
                
        if OP_C_lists.size != 0:
            OP_C_mean = np.mean(OP_C_lists.reshape(-1, OP_C_lists.shape[-1]), axis=0)
            OP_C_std = np.std(OP_C_lists.reshape(-1, OP_C_lists.shape[-1]),axis=0)
            OP_C_mean_dict = {}
            OP_C_std_dict = {}
            for idx, key in enumerate(self.params_c):
                OP_C_mean_dict[key] = OP_C_mean[idx]
                OP_C_std_dict[key] = OP_C_std[idx]     
                
        if OP_V_lists.size != 0:
            OP_V_mean = np.mean(OP_V_lists.reshape(-1, OP_V_lists.shape[-1]), axis=0)
            OP_V_std = np.std(OP_V_lists.reshape(-1, OP_V_lists.shape[-1]),axis=0)
            OP_V_mean_dict = {}
            OP_V_std_dict = {}
            for idx, key in enumerate(self.params_v):
                OP_V_mean_dict[key] = OP_V_mean[idx]
                OP_V_std_dict[key] = OP_V_std[idx]

        self.OP_M_mean_std = {
            'OP_M_mean': OP_M_mean_dict,         
            'OP_M_std': OP_M_std_dict
            }

        with open(f'{SPICE_NETLIST_DIR}/ldo_folded_cascode_tb_op_mean_std.json','w') as file:
            json.dump(self.OP_M_mean_std, file)




