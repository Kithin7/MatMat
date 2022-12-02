function [ ] = WaterTower_PartC( Waterlevel, Min_on, Max_off, Rate_in )

load PartC_Data
Rate_out = water_usage;

%v = h*r^2*pi
VolumeG = (Waterlevel * 5^2 * pi)/.0038;
VolumeM3 = Waterlevel * 5^2 * pi;
%assume pump is initially OFF
Pump_status = false;
for a = 2:1:1441    % 1440 min/day every 1 min = 1440 cycles/iterations, shift one to the right
    
    %pump check
    if Waterlevel(a-1) >= Max_off
        Pump_status = false;
    elseif Waterlevel(a-1) <= Min_on
        Pump_status = true;
    end  
    
    %update values based on pump status
    if Pump_status == false;
        %no rate_in
        Rate_overall = -Rate_out(a-1);
        Change = Rate_overall*2;
        VolumeG(a) = VolumeG(a-1) + Change;
        VolumeM3(a) = 0.0038 * VolumeG(a);
        Waterlevel(a) = VolumeM3(a) /25/pi;
        
    elseif Pump_status == true;
        %include rate_in
        Rate_overall = Rate_in - Rate_out(a-1);
        Change = Rate_overall*2;
        VolumeG(a) = VolumeG(a-1) + Change;
        VolumeM3(a) = 0.0038 * VolumeG(a);
        Waterlevel(a) = VolumeM3(a) /25/pi;
        
    else    % error catch
        disp('Something not good happened fam');
        
    end
    
end

%plot time!
%t = 0:2:1440;
figure (1)
hold on
plot(time,Waterlevel,'k-');
plot(time,ones(size(time))*Max_off,'r-'); refline(0,Min_on);
hold off

%disp starting and ending levels in tank
fprintf('Initially  %0.3f gal in the tank and ending at  %0.3f gal\n',VolumeG(1),VolumeG(end));
fprintf('Initially  %0.3f m and ending at  %0.3f m\n',Waterlevel(1),Waterlevel(end));

end

