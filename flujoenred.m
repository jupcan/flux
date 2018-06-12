function flujoenred(estado)
%% --------------------------------------------------------------------
% Ayuda
% --------------------------------------------------------------------
% La función calcula el número de coches presentes en el arco, así
% como el flujo de salida del mismo, por unidad de tiempo.
% --------------------------------------------------------------------
% Entradas: 1 Normal/Sin Semáforo, 2 Con Semáforo, 3 Ambos (estado).
% --------------------------------------------------------------------
% Salida: Gráfica de Número de Vehículos presentes en el Arco por
% unidad de tiempo y gráfica de Flujo de Salida del Arco (Vehículos/h)
% por unidad de tiempo variando según el estado elegido previamente.
% --------------------------------------------------------------------
% See also vaciado, traficodearco.

%% Función Flujo en una Red
%% Algoritmo

v_t = [7:5/120:18];
n = zeros(28,length(v_t));
k = zeros(28,length(v_t));
Q = zeros(28,length(v_t));
q = zeros(28,length(v_t));
qtilde = zeros(28,length(v_t));

L = 5; % Metros de cada celda
kc = 25; % Densidad crítica
dt = 5/120; % Incremento de tiempo (h)
qc = 3000;
kmax = 100;
k_max = 60;

p = ones(1,28);
p(3) = 0.6; p(9) = 0.4; % Bifurcaciones en esas celdas
p(22) = 0.3; p(16) = 0.7; % Convergencias en esas celdas

for j = 1:length(v_t)
    for i = 1:28
        k(i,j) = n(i,j)/L;
        
        if(i==1) % Para las condiciones iniciales usando el hito2
            % Densidad de la celda i
            if(k(1,j)==0)
                Q(1,j) = 4000*exp(-(v_t(j)-8)^2)+8000*exp((v_t(j)-13)^2);
            elseif(k(1,j)>0)
                Q(1,j) = 4000*exp(-(v_t(j)-8)^2)+8000*exp((v_t(j)-13)^2)+ k(1,j)*L/dt;
            end
            q(i,j) = min([Q(i,j) (k_max*L-n(i+1,j))/dt]);
            % Evolución del tráfico
            if (j<length(v_t))
                n(i,j+1) = n(i,j)+(4000*exp(-(v_t(j)-8)^2)+8000*exp((v_t(j)-13)^2)-q(i,j))*dt;
            end
            
        elseif(i==18||i==27) % Si hay convergencia
            if(i==18)
                s = 15; r = 17;
            elseif(i==27)
                s = 26; r = 21;
            end
            
            if(k(i,j)<kc)
                Q(i,j) = qc/kc*k(i,j);
            elseif(kc<=k(i,j) && k(i,j)<=kmax)
                Q(i,j) = qc/(kmax-kc)*(kmax-k(i,j));
            elseif(kmax<k(i,j))
                Q(i,j) = 0;
            end
            
            f(s,j) = Q(s,j)/(Q(s,j)+Q(r,j));
            f(r,j) = Q(r,j)/(Q(s,j)+Q(r,j));
            
            % Flujo saliente de las celdas
            q(s,j) = min([Q(s,j)+Q(r,j) (k_max*L-n(i,j))/dt])*f(s,j);
            q(r,j) = min([Q(s,j)+Q(r,j) (k_max*L-n(i,j))/dt])*f(r,j);
            
            % Evolución para la celda i
            if (j<length(v_t))
                n(i,j+1) = n(i,j)+(q(s,j)+q(r,j)-q(i,j))*dt;
            end
        elseif(i==2||i==8) % Si hay bifurcación
            
            if(i==2)
                s = 3; r = 9;
            elseif(i==8)
                s = 22; r = 16;
            end
            
            if(k(i,j)<kc)
                Q(i,j) = qc/kc*k(i,j);
            elseif(kc<=k(i,j) && k(i,j)<=kmax)
                Q(i,j) = qc/(kmax-kc)*(kmax-k(i,j));
            elseif(kmax<k(i,j))
                Q(i,j) = 0;
            end
            
            % Flujo saliente de las celdas
            qtilde(s,j) = min([Q(i,j)*p(s) (k_max*L-n(s,j))/dt]);
            qtilde(r,j) = min([Q(i,j)*p(r) (k_max*L-n(r,j))/dt]);
            
            q(i,j) = qtilde(s,j)+qtilde(r,j);
            
            % Evolución para las celdas s y r
            if (j<length(v_t))
                n(s,j+1) = n(s,j)+(qtilde(s,j)-q(s,j))*dt;
                n(r,j+1) = n(r,j)+(qtilde(r,j)-q(r,j))*dt;
            end
        else
            % Vehículos que acceden al arco
            if(k(i,j)<kc)
                Q(i,j) = qc/kc*k(i,j);
            elseif(kc<=k(i,j) && k(i,j)<=kmax)
                Q(i,j) = qc/(kmax-kc)*(kmax-k(i,j));
            elseif(kmax<k(i,j))
                Q(i,j) = 0;
            end
            if(i<28)
                q(i,j) = min([Q(i,j) (k_max*L-n(i+1,j))/dt]);
            else
                q(28,j) = Q(28,j);
            end
            if (j<length(v_t))
                n(i,j+1) = n(i,j)+(q(i-1,j)-q(i,j))*dt;
            end
        end
    end
end

% Representamos en una gráfica los datos pedidos

if(estado == 1) % Gráfica 1 - Flujo saliente de la red (celdilla 28)
    figure(1)
    hold on;
    plot(v_t,q(28,:))
    title('Flujo de Salida (celda 28)')
    xlabel('Tiempo (h)'); ylabel('Número de Vehículos')
    
elseif(estado == 2) % Gráfico 2 - Número de vehículos celdilla 18
    figure(1)
    hold on;
    plot(v_t,n(18,:))
    title('Número de Vehículos (celda 18)')
    xlabel('Tiempo (h)'); ylabel('Número de Vehículos')
    
elseif(estado == 3) % Gráfico 3 - Número de vehículos celdilla 27
    figure(1)
    hold on;
    plot(v_t,n(27,:))
    title('Número de Vehículos (celda 27)')
    xlabel('Tiempo (h)'); ylabel('Número de Vehículos')
end
return