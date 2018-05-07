x = h:h:2;
figure
hold on;
ax1 = subplot(2,1,1);
plot(x,neu_1,x,neu_2,x,neu_3,x,neu_4,x,neu_5,x,neu_6,x,neu_7,x,neu_8,x,neu_9,x,neu_10,x,neu_12,x,neu_13,x,neu_14,x,neu_15,x,neu_16,x,neu_17,x,neu_18,x,neu_19,x,neu_20,x,neu_21)
ylim([0 1])
set(gcf,'units','points','position',[x0,y0,width,height])
%legend(ax1,{'Line 1,2','Line 1,5','Line 2,3','Line 2,4','Line 2.5','Line 3,4','Line 4,5','Line 4,7', 'Line 4,9','Line 5,6','Line 6,11','Line 6,12','Line 6,13','Line 7,8','Line 7,9','Line 9,10','Line 9,14','Line 10,11','Line 12,13','Line 13,14'});
xlabel(ax1,"Time")
ylabel(ax1,"Line Status")

ax2 = subplot(2,1,2);
plot(x,omega_plt1,x,omega_plt2,x,omega_plt3,x,omega_plt4,x,omega_plt5)
ylim([-2 2])
xlabel(ax2,"Time")
ylabel(ax2,"Generator Frequency")


set(gcf,'units','points','position',[x0,y0,width,height])
legend(ax2,{'Generator 1','Generator 2','Generator 3','Generator 6','Generator 8'})

