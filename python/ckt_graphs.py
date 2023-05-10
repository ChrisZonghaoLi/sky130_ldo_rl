#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Nov 10 17:58:15 2022

@author: zonghao

Here you define the graph for a circuit
"""

import torch
import numpy as np

class GraphLDO:
    """

        Here is a graph discription for the simple LDO:


                       Vdd 
             ____________________________
             |            |                              |
           M4_____M3                             |
             |____|     |                              |
             |            |_______ ___________M6
             |            |           |_Rfb__Cfb__|
   Vreg-M1_____M2-Vref                      |_______________Vreg
                 |                                        |                    |
         Vb---M5                           |----------------|           |
                 |                              |       CL        |          IL
                 |                              |    decap     |           |
                 |                              |----------------|           |
                  -------------------------------------------------------
                        GND

    node 0 will be M1
    node 1 will be M2
    node 2 will be M3
    node 3 will be M4
    node 4 will be M5
    node 5 will be M6
    node 6 will be Vb
    node 7 will be Vdd
    node 8 will be GND
    node 9 will be Rfb
    node 10 will be Cfb
    node 11 will be CL decap

    """
    def __init__(self):
        # self.device = torch.device(
        #     "cuda:0" if torch.cuda.is_available() else "cpu"
        # )
        
        self.device = torch.device(
           "cpu"
        )

        # we do not include R here since, it is not straght forward to get the resistance from resistor
        # in SKY130 PDK
        self.ckt_hierarchy = (('M1','x1.x1.XM1','nfet_g5v0d10v5','m'),
                      ('M2','x1.x1.XM2','nfet_g5v0d10v5','m'),
                      ('M3','x1.x1.XM3','pfet_g5v0d10v5','m'),
                      ('M4','x1.x1.XM4','pfet_g5v0d10v5','m'),
                      ('M5','x1.x1.XM5','nfet_g5v0d10v5','m'),
                      ('M6','x1.XM6','pfet_g5v0d10v5','m'),
                      ('Vb','','Vb','v'),
                      
                      ('Cfb','x1.XCfb','cap_mim_m3_1','c'),
                      ('CL','XCL','cap_mim_m3_1','c')
                     )    

        self.op = {'M1':{},
                'M2':{},
                'M3':{},
                'M4':{},
                'M5':{},
                'M6':{},
                'Vb':{},
                'Cfb':{},
                'CL':{}
                 }

        self.edge_index = torch.tensor([
            [0,1], [1,0], [0,2], [2,0], [0,3], [3,0], [0,4], [4,0], [0,5], [5,0], [0,10], [10,0], [0,11], [11,0],    
            [1,2], [2,1], [1,4], [4,1], [1,5], [5,1], [1,9], [9,1],
            [2,3], [3,2], [2,5], [5,2], [2,7], [7,2], [2,9], [9,2],
            [3,7], [7,3],
            [4,6], [6,4], [4,8], [8,4],
            [5,7], [7,5], [5,9], [9,5],
            [5,10], [10,5], [5,11], [11,5],
            [9,10], [10,9],
            [10,11], [11,10],
            [11,8], [8,11]
            ], dtype=torch.long).t().to(self.device)
        
        # sorted based on if it is the small signal path
        # small signal path: 0; biasing path: 1
        self.edge_type = torch.tensor([
            0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0,
            0, 0, 1, 1, 0, 0, 0, 0,
            0, 0, 0, 0, 1, 1, 0, 0,
            1, 1,
            1, 1, 1, 1, 
            1, 1, 0, 0, 0, 0, 0, 0, 
            0, 0,
            0, 0,
            1, 1,
            ]).to(self.device)
        
        self.num_relations = 2
        self.num_nodes = 12
        self.num_node_features = 13
        self.obs_shape = (self.num_nodes, self.num_node_features)
        
        """Select an action from the input state."""
        L_CL = 30 # each unit cap is 30um by 30um
        W_CL = 30
        M_CL_low = 10
        M_CL_high = 300 # copies of unit cap
        self.CL_low = M_CL_low * (L_CL*W_CL*2e-15+(L_CL+W_CL)*0.38e-15)
        self.CL_high = M_CL_high * (L_CL*W_CL*2e-15+(L_CL+W_CL)*0.38e-15)
       
        self.W_Rfb = 0.35 # W: 5um
        self.L_Rfb = 3 # L: 3um
        M_Rfb_low = 1
        M_Rfb_high = 20
        self.Rsheet = 1112.4
        self.Rfb_low =  self.Rsheet * self.L_Rfb / self.W_Rfb / M_Rfb_high  
        self.Rfb_high = self.Rsheet * self.L_Rfb / self.W_Rfb / M_Rfb_low 
        
        W_Cfb = 10
        L_Cfb = 10
        M_Cfb_low = 1
        M_Cfb_high = 50
        self.Cfb_low = M_Cfb_low * (L_Cfb*W_Cfb*2e-15+(L_Cfb+W_Cfb)*0.38e-15)
        self.Cfb_high = M_Cfb_high * (L_Cfb*W_Cfb*2e-15+(L_Cfb+W_Cfb)*0.38e-15)
 
        self.action_space_low = np.array([ 1, 0.5, 
                                                                     1, 0.5,
                                                                     1, 0.5,
                                                                     10, 0.5, 100,
                                                                     0.9,
                                                                     M_Rfb_low, #Rfb
                                                                     M_Cfb_low, #Cfb
                                                                     M_CL_low, # CL
                                                                     ]) 
        
        self.action_space_high = np.array([100, 2,
                                                                      100, 2,
                                                                      100, 2,
                                                                      100, 1, 2000,
                                                                      1.4,
                                                                     M_Rfb_high, #Rfb
                                                                     M_Cfb_high, #Cfb
                                                                     M_CL_high, # CL
                                                                     ]) 
        
        self.action_dim =len(self.action_space_low)
        self.action_shape = (self.action_dim,)    
        
        """Some target specifications for the final design"""
        self.Vdrop_target = 0.22  # drop-out voltage
        
        self.PSRR_target_1kHz = 10**(-30/20) # in linear scale, equals -30dB
        self.PSRR_target_10kHz = 10**(-30/20) # in linear scale, equals -30dB
        self.PSRR_target_1MHz =  10**(-20/20) # in linear scale, equals -20dB
        self.PSRR_target_above_1MHz =  10**(-5/20) # in linear scale, equals -5dB
        self.PSRR_1kHz = 1e3 #  from DC to 1kHz
        self.PSRR_10kHz = 1e4 #  from DC to 10kHz
        self.PSRR_1MHz = 1e6  # from DC to 1 MHz
        
        self.phase_margin_target = 60 # 60 degree PM minimum, this is for the loop-gain
        self.Vreg = 1.8 # regulated output
        self.Vref = 1.8
        self.GND = 0
        self.Vdd = 2
        
        self.Vload_reg_delta_target = self.Vreg * 0.02 # load regulartion variation is at most 2% of Vreg when it is switched from ILmin to ILmax
        self.Iq_target = 200e-6 #200uA quiescent current maximum
        self.Vline_reg_delta_target =  self.Vreg * 0.02  # line reg voltage to be around at most 2% of Vreg when it is at both ILmin and ILmax

        """If you want to apply the reward engineering"""
        self.rew_eng = True

class GraphLDOFoldedCascode:
    # here is the description for the two-stage op-amp
    """

        Here is a graph discription for the folded cascode EA LDO:


                                     Vdd 
      _________________________________________________________________________________________
                                                                              |                       |                               |                                                          
                                                                              |                       |                               |                                                          
                                                                            M3---------------M4                               |
                             |---------------------------------------|     |                |                               |
                             |             |---------------------------|----|-------------|                              |
                             |             |                               M5---|---Vb2---M6                              |
                             |             |                                |____|               |                               |
                   Vreg-M1_____M2-Vref                        |                        |-------------------------M10
                                     |                                      M7------Vb1-----M8       |_Rfb__Cfb__|--------------------------------Vreg
    Vb1----------------------M9                                   |                        |                                |            |                        
                                     |                                      |                        |                                CL          IL                       
      ---------------------------------------------------------------------------------------------------------------------------                      
                                      GND                                                                                                                                  
                                                                                                                                                                                 
                                                                                                                                                                                  
                                                                                                                                                                                 
    node 0 will be M1
    node 1 will be M2
    node 2 will be M3
    node 3 will be M4
    node 4 will be M5
    node 5 will be M6
    node 6 will be M7
    node 7 will be M8
    node 8 will be M9
    node 9 will be M10
    node 10 will be Vb1
    node 11 will be Vb2
    node 12 will be Rfb
    node 13 will be Cfb
    node 14 will be CL decap
    node 15 will be Vdd
    node 16 will be GND

    """
    def __init__(self):
        # self.device = torch.device(
        #     "cuda:0" if torch.cuda.is_available() else "cpu"
        # )
        
        self.device = torch.device(
           "cpu"
        )

        self.ckt_hierarchy = (('M1','x1.x1.XM1','nfet_g5v0d10v5','m'),
                      ('M2','x1.x1.XM2','nfet_g5v0d10v5','m'),
                      ('M3','x1.x1.XM3','pfet_g5v0d10v5','m'),
                      ('M4','x1.x1.XM4','pfet_g5v0d10v5','m'),
                      ('M5','x1.x1.XM5','pfet_g5v0d10v5','m'),
                      ('M6','x1.x1.XM6','pfet_g5v0d10v5','m'),
                      ('M7','x1.x1.XM7','nfet_g5v0d10v5','m'),
                      ('M8','x1.x1.XM8','nfet_g5v0d10v5','m'),
                      ('M9','x1.x1.XM9','nfet_g5v0d10v5','m'),
                      ('M10','x1.XM10','pfet_g5v0d10v5','m'),
                      ('Vb1','','Vb1','v'),
                      ('Vb2','','Vb2','v'),
                      
                      ('Cfb','x1.XCfb','cap_mim_m3_1','c'),
                      ('CL','XCL','cap_mim_m3_1','c')
                     )    

        self.op = {'M1':{},
                'M2':{},
                'M3':{},
                'M4':{},
                'M5':{},
                'M6':{},
                'M7':{},
                'M8':{},           
                'M9':{},
                'M10':{},
                'Vb1':{},
                'Vb2':{},

                'Cfb':{},
                'CL':{}
                 }

        self.edge_index = torch.tensor([
          [0,1], [1,0], [0,2], [2,0], [0,4], [4,0], [0,8], [8,0], [0,9], [9,0], [0,13], [13,0], [0,14], [14,0],
          [1,3], [3,1], [1,5], [5,1], [1,8], [8,1], 
          [2,3], [3,2], [2,4], [4,2], [2,6], [6,2], [2,15], [15,2],
          [3,4], [4,3], [3,5], [5,3], [3,6], [6,3], [3,15], [15,3],
          [4,5], [5,4], [4,6], [6,4], [4,11], [11,4],
          [5,7], [7,5], [5,9], [9,5], [5,11], [11,5], [5,12], [12,5],
          [6,7], [7,6], [6,8], [8,6], [6,10], [10,6], [6,16], [16,6],
          [7,9], [9,7], [7,12], [12,7], [7,8], [8,7], [7,16], [16,7],
          [8,10], [10,8], [8,16], [16,8],
          [9,12], [12,9], [9,13], [13,9], [9,14], [14,9], [9,15], [15,9], 
          [12,13], [13,12],
          [13,14], [14,13], 
          [14,16], [16,14],
            ], dtype=torch.long).t().to(self.device)
        
        # sorted based on if it is the small signal path
        # small signal path: 0; biasing path: 1
        self.edge_type = torch.tensor([
            0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 1, 1, 
            0, 0, 0, 0, 0, 0, 1, 1,
            0, 0, 0, 0, 0, 0, 1, 1,
            1, 1, 0, 0, 1, 1,
            0, 0, 0, 0, 1, 1, 0, 0,
            1, 1, 1, 1, 1, 1, 1, 1,
            0, 0, 0, 0, 1, 1, 1, 1,
            1, 1, 1, 1,
            0, 0, 0, 0, 0, 0, 1, 1,
            0, 0,
            0, 0, 
            1, 1,
            ]).to(self.device)
        
        self.num_relations = 2
        self.num_nodes = 17
        self.num_node_features = 14
        self.obs_shape = (self.num_nodes, self.num_node_features)
        
        """Select an action from the input state."""

        L_CL = 30 # each unit cap is 30um by 30um
        W_CL = 30
        M_CL_low = 10
        M_CL_high = 300 # copies of unit cap
        self.CL_low = M_CL_low * (L_CL*W_CL*2e-15+(L_CL+W_CL)*0.38e-15)
        self.CL_high = M_CL_high * (L_CL*W_CL*2e-15+(L_CL+W_CL)*0.38e-15)

        self.W_Rfb = 0.35 # W: 5um
        self.L_Rfb = 3 # L: 3um
        M_Rfb_low = 1
        M_Rfb_high = 20
        self.Rsheet = 1112.4
        self.Rfb_low =  self.Rsheet * self.L_Rfb / self.W_Rfb / M_Rfb_high  
        self.Rfb_high = self.Rsheet * self.L_Rfb / self.W_Rfb / M_Rfb_low 
        
        W_Cfb = 10
        L_Cfb = 10
        M_Cfb_low = 1
        M_Cfb_high = 100
        self.Cfb_low = M_Cfb_low * (L_Cfb*W_Cfb*2e-15+(L_Cfb+W_Cfb)*0.38e-15)
        self.Cfb_high = M_Cfb_high * (L_Cfb*W_Cfb*2e-15+(L_Cfb+W_Cfb)*0.38e-15)
        
        self.action_space_low = np.array([ 1, 0.5, #M1
                                        1, 0.5, #M3
                                        1, 0.5, #M5
                                        1, 0.5, #M7
                                        1, 0.5, #M9
                                        10, 0.5, 100, #M10
                                        0.9, 0.0, # Vb1, Vb2,
                                        M_Rfb_low, #Rfb
                                        M_Cfb_low, #Cfb
                                        M_CL_low]) # CL
        
        self.action_space_high = np.array([100, 2, 
                                        100, 2,    
                                        100, 2,  
                                        100, 2,
                                        100, 2,   
                                        100, 1, 2000,   
                                        1.4, 1,
                                        M_Rfb_high,  
                                        M_Cfb_high,
                                        M_CL_high])
        
        self.action_dim = len(self.action_space_low)
        self.action_shape = (self.action_dim,)    

        """Some target specifications for the final design"""
        self.Vdrop_target = 0.22  # drop-out voltage
        
        self.PSRR_target_1kHz = 10**(-30/20) # in linear scale, equals -30dB
        self.PSRR_target_10kHz = 10**(-30/20) # in linear scale, equals -30dB
        self.PSRR_target_1MHz =  10**(-20/20) # in linear scale, equals -20dB
        self.PSRR_target_above_1MHz =  10**(-5/20) # in linear scale, equals -5dB
        self.PSRR_1kHz = 1e3 #  from DC to 1kHz
        self.PSRR_10kHz = 1e4 #  from DC to 10kHz
        self.PSRR_1MHz = 1e6  # from DC to 1 MHz
        
        self.phase_margin_target = 60 # 60 degree PM minimum, this is for the loop-gain
        self.Vreg = 1.8 # regulated output
        self.Vref = 1.8
        self.GND = 0
        self.Vdd = 2

        self.Vload_reg_delta_target = self.Vreg * 0.02 # load regulartion variation is at most 2% of Vreg when it is switched from ILmin to ILmax
        self.Iq_target = 400e-6 #400uA quiescent current maximum
        self.Vline_reg_delta_target =  self.Vreg * 0.02  # line reg voltage to be around at most 2% of Vreg when it is at both ILmin and ILmax
        
        """If you want to apply the reward engineering"""
        self.rew_eng = False
        
        
        
        