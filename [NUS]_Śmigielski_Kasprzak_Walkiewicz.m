rosinit
pozycja = rossubscriber('turtle1/pose');
sterowanie = rospublisher( '/turtle1/cmd_vel' );
wiadomosc = rosmessage( sterowanie.MessageType );
%% Zad1
while 1
    polozenie= receive(pozycja,1);
    wiadomosc.Linear.X=1;
    wiadomosc.Angular.Z=1;
    send(sterowanie,wiadomosc)
end

%% Zad 2
t=0;
zegar = tic
while t<=1
    t = toc(zegar)
    wiadomosc.Linear.X=0
    polozenie= receive(pozycja,1)
    wiadomosc.Linear.X=0
    wiadomosc.Angular.Z=-20*polozenie.Theta
    send(sterowanie,wiadomosc)
end

%% Zad3
d=0
D=2 % wartosc odleglosci ktora ma przebyc nasz zolw
polozenie= receive(pozycja,1);
Xp=polozenie.X;
Yp=polozenie.Y;
while 1
    polozenie= receive(pozycja,1)
    if d>=D
       wiadomosc.Linear.X=0;
       send(sterowanie,wiadomosc)
       polozenie= receive(pozycja,1)
       break
    end
    wiadomosc.Linear.X=1;
    wiadomosc.Angular.Z=0;
    d=sqrt((polozenie.X-Xp)^2+(polozenie.Y-Yp)^2);
    send(sterowanie,wiadomosc);
end