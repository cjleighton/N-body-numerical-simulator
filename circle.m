function [] = circle(bodies,r,t)
    hold on;
    th = 0:pi/50:2*pi;
    for i=1:length(bodies)
        xunit=r*cos(th)+bodies(i).position(1);
        yunit=r*sin(th)+bodies(i).position(2);
        plot(xunit,yunit);
        %text(bodies(i).position(1),bodies(i).position(2),[num2str(bodies(i).mass) ' kg']);
    end
    
    axis([-30 30 -20 20]);
    title(['Time (s): ' num2str(t)]); % display time elapsed
    
    pause(0.0000000000000000001);
    clf('reset');
end