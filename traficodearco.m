function traficodearco(estado)
%% --------------------------------------------------------------------
% Ayuda
% --------------------------------------------------------------------
% La función calcula el número de coches presentes en el arco, así
% como el flujo de salida del mismo, por unidad de tiempo.
% --------------------------------------------------------------------
% Entradas: 1 Normal/Sin Semáforo, 2 Con Semáforo.
% --------------------------------------------------------------------
% Salida: Gráfica de Número de Vehículos presentes en el Arco por
% unidad de tiempo y gráfica de Flujo de Salida del Arco (Vehículos/h)
% por unidad de tiempo, ambos variando según el estado elegido antes.
% --------------------------------------------------------------------
% See also vaciado, flujoenred.

%% Función Tráfico de un Arco
%% Algoritmo

if(estado == 1) % Estado Normal/Sin Semáforo
    
    % Flujo de coches en el Arco
    
    v_t = [7:5/120:14];
    n = zeros(6,length(v_t));
    k = zeros(6,length(v_t));
    Q = zeros(6,length(v_t));
    q = zeros(6,length(v_t));
    
    L = 5; % Metros de cada celda
    kc = 25; % Densidad crítica
    dt = 5/120; % Incremento de tiempo (h)
    qc = 3000;
    kmax = 100;
    k_max = 60;
    
    for j = 1:length(v_t)
        for i = 1:6
            k(i,j) = n(i,j)/L;
            if(i==1)
                % Densidad de la celda i
                if(k(1,j)==0)
                    Q(1,j) = 4000*exp(-(v_t(j)-8)^2);
                elseif(k(1,j)>0)
                    Q(1,j) = 4000*exp(-(v_t(j)-8)^2)+ k(1,j)*L/dt;
                end
                q(i,j) = min([Q(i,j) (k_max*L-n(i+1,j))/dt]);
                % Evolución del tráfico
                if (j<length(v_t))
                    n(i,j+1) = n(i,j)+(4000*exp(-(v_t(j)-8)^2)-q(i,j))*dt;
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
                if(i<6)
                    q(i,j) = min([Q(i,j) (k_max*L-n(i+1,j))/dt]);
                else
                    q(6,j) = Q(6,j);
                end
                if (j<length(v_t))
                    n(i,j+1) = n(i,j)+(q(i-1,j)-q(i,j))*dt;
                end
            end
        end
    end
    
elseif (estado == 2) % Estado Con Semáforo
    %% Algoritmo
    
    % Flujo de coches en el Arco
    
    v_t = [7:5/120:14];
    n = zeros(6,length(v_t));
    k = zeros(6,length(v_t));
    Q = zeros(6,length(v_t));
    q = zeros(6,length(v_t));
    
    L = 5; % Metros de cada celda
    kc = 25; % Densidad crítica
    dt = (5/120)/2.5; % Incremento de tiempo (min) para controlar semáforo
    verde = 1; % Variable semáforo
    qc = 3000;
    kmax = 100;
    k_max = 60;
    
    for j = 1:length(v_t)
        if (verde==1)
            qc = 3000;
        else
            qc = 0;
        end
        for i = 1:6
            k(i,j) = n(i,j)/L;
            if(i==1)
                % Densidad de la celda i
                if(k(1,j)==0)
                    Q(1,j) = 4000*exp(-(v_t(j)-8)^2);
                elseif(k(1,j)>0)
                    Q(1,j) = 4000*exp(-(v_t(j)-8)^2)+ k(1,j)*L/dt;
                end
                q(i,j) = min([Q(i,j) (k_max*L-n(i+1,j))/dt]);
                % Evolución del tráfico
                if (j<length(v_t))
                    n(i,j+1) = n(i,j)+(4000*exp(-(v_t(j)-8)^2)-q(i,j))*dt;
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
                if(i<6)
                    q(i,j) = min([Q(i,j) (k_max*L-n(i+1,j))/dt]);
                else % Si estamos en la última celda ponemos las
                    % condiciones del semáforo especificadas
                    if(rem(j,4)~=0) % Si el tiempo no es múltiplo de 4, el
                        % semáforo permanecerá en verde
                        q(6,j) = min (Q(6,j), 3000);
                        verde = 1; % Semáforo en verde
                    else % Si es múltiplo de 4, se pondrá en rojo
                        q(6,j) = 0;
                        verde = 0; % Semáforo en rojo
                    end
                end
                if (j<length(v_t))
                    n(i,j+1) = n(i,j)+(q(i-1,j)-q(i,j))*dt;
                end
            end
        end
    end
end

% Quitamos las del depósito (fila 1) que hemos usado como auxiliar
% Pintamos las gráficas correspondientes según el estado elegido
% anteriormente. Esta parte es común para ambos.

n_arco = n(2:6,:);
n_total = sum(n_arco);
figure(1)
subplot(2,1,1)
plot(v_t,n_total);
title('Número de Vehículos en el Arco')
hold on;
xlabel('Tiempo (h)'); ylabel('Número de Vehículos')
subplot(2,1,2)
plot(v_t,q(6,:))
title('Flujo de Salida del Arco')
hold on;
xlabel('Tiempo (h)'); ylabel('Flujo (Vehículos/h)')

return