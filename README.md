# fox-dd_parameter_locker
Quickly apply access level controls to default Foxboro detail displays (dd_1) 

Use case: You are a Foxboro site using FoxView/FoxDraw graphics. Your control room operators are allowed to open the block detail displays, but you do not want them modifying certain parameters (eg: PIDA block tuning parameters). This script can interate through all detail displays, applying a Protection IDs on a per-parameter basis (eg: lock down the REMSW parameter on every block with that parameter).

DO NOT COPY DD FILES ACROSS DIFFERENT VERSIONS OF I/A or Evo: With each version release, block detail displays can change slightly. For example, CCS 9.3 might have a different PIDA detail display than I/A 8.5. To work around this, use this script for the dd_1 folder of each version of I/A running on your site. Be sure to make backups first. 
 
See comments in script file for how to use. 

References/Resources:
* B0193MQ: Display Engineering for FoxView(tm) Software and Display Manager Software 
