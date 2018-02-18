Source file folder for project. src -> src_readme.tx can function as a note pad of what needs to get done or where someone stopped working last. 


Calculating M_i, B_ij
ref urls:
(1)https://journals.aps.org/prl/pdf/10.1103/PhysRevLett.119.248302
(2)
http://research.iaun.ac.ir/pd/bahador.fani/pdfs/UploadFile_6990.pdf

M_i is defined in ref[38] as M_i = w_o/p_o (I_i) where 
w_o is nominal operating frequency
p_o is base power 
I_i is the moment of inertia

w_o is given by region i.e. U.S. is 60 Hz E.U. is 50 Hz
p_o is given in data set as mBase
I_i is given as an approximation on Table 9.2 of refUrl[2] pg. 101

B_ij is calculated by the reactance of the i-j line given in the data set. This info can be found by typing 'help caseformat' into the matlab terminal and looking for mpc.branches.

 

