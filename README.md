# Design and Optimization of Low-Dropout Voltage Regulator Using Relational Graph Neural Network and Reinforcement Learning in Open-Source SKY130 Process

Design and Optimization of Low-Dropout Voltage Regulator Using Relational Graph Neural Network and Reinforcement Learning in Open-Source SKY130 Process

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![CI](https://github.com/efabless/caravel_user_project_analog/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_user_project_analog/actions/workflows/user_project_ci.yml) [![Caravan Build](https://github.com/efabless/caravel_user_project_analog/actions/workflows/caravan_build.yml/badge.svg)](https://github.com/efabless/caravel_user_project_analog/actions/workflows/caravan_build.yml)

---

This is the source code for the paper submitted to IEEE/ACM ICCAAD 2023.

---

## Repo Structure

All files you are lookring for are placed inside the folder `/python`. 
- `ldo.py`: define the LDO1 environment (Gymnasium compatible).
- `ldo_folded_cascode.py`: define the LDO2 environment (Gymnasium compatible).
- `ckt_graphs.py`: define the graph info as well as specifications for LDO1 and LDO2.
- `dev_params.py`: used to extrac device parameters such as threshold voltage and transconductance of transistors, providing the observations for RL.
- `ddpg.py`: where DDPG algorithm is stored.
- `models.py`: where various GNN models are stored.
- `main.py`: run the optimization for LDO1.
- `main2.py`: run the optimization for LDO2.
- `postproc.py`: do some post-processing such as data visualization for LDO1 after the optimization is done.
- `postproc.py`: do some post-processing such as data visualization for LDO2 after the optimization is done.
- `utils.py`: some useful utilities.
- `/simulations`: store the SPICE files and it is where Ngspice is running.
- `ldo_rgcn_rl.ipynb`: a notebook summaries the work, it is outdated.


