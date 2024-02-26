function[tws2,tws2_std]=interp1_t2_std(t1,tws1,t2)
t1=reshape(t1,1,size(t1,1)*size(t1,2)*size(t1,3));
tws1=reshape(tws1,1,size(tws1,1)*size(tws1,2)*size(tws1,3));
A=t1;
[C,ia,ic]=unique(A);
t1=t1(ia);
tws1=tws1(ia);
% tws2=interp1(t1,tws1,t2,'nearest','extrap');
tws2=interp1(t1,tws1,t2,'linear','extrap');
tws2=tws2(:);
% tws2_std=
% plotyy_ts(t1,tws1,t2,tws2,info_save_name,'before');
end