function [tp] = vaciado(geometria,h,g,r)
%% --------------------------------------------------------------------
% Ayuda
% --------------------------------------------------------------------
% La función calcula los tiempos de vaciado de los depósitos, dados
% los parámetros de entrada, según el porcentaje de líquido restante.
% --------------------------------------------------------------------
% Entradas: 1 Cilindro, 2 Cono, 3 Esfera (geometria), altura del
% depósito (h), constante de gravedad del planeta donde se realiza el
% vaciado (g), radio de la espita presente en el depósito (r).
% --------------------------------------------------------------------
% Salida: Tiempo vaciado ordenado por porcentaje (75%, 50%, 25%, 0%)
% y representación gráfica de dicho vaciado frente al tiempo (min).
% --------------------------------------------------------------------
% See also traficodearco, flujoenred.

%% Función Vaciado Depósitos
%% Algoritmo

if(geometria == 1)
    
    % Inicializar Cilindro
    
    V = pi*2.5^2*h;
    t = 0;
    i = 1;
    k = (pi*r^2)*1;
    dt = 60;
    p = 0.75;
    j = 1;
    
    % Operaciones Cilindro
    
    while(V(i)>0)
        
        v(i) = sqrt(2*g*h(i));
        q(i) = v(i)*k;
        V(i+1) = V(i)-q(i)*dt;
        
        % Observación: Cálculo de la altura restante
        % El cálculo de la altura de líquido restante en un instante
        % siguiete o i+1 lo he llevado a cabo depejando la altura (h) de
        % la fórmula del volúmen. Si V = pi*r^2*h entonces h = V/(pi*r^2).
        
        % Resolvemos la ecuación de la altura
        
        h(i+1) = V(i+1)/(pi*2.5^2);
        t(i+1) = t(i)+dt;
        if(V(i+1)<p*V(1))
            tp(j) = (t(i+1))/60;
            p = p-0.25;
            j = j+1;
        end
        i = i+1;
    end
    
    Vp = V(1)*[0.75 0.5 0.25 0];
    
    % Dibujar Cilindro
    
    figure(2)
    plot(t/60,V)
    title('Vaciado del Depósito Cilíndrico')
    xlabel('Tiempo (min)'); ylabel('Volumen (m^3)')
    hold on;
    
    % Simular vaciado del Cilindro en 2D
    
    figure(1)
    minx=-0.5; maxx=5.5; miny=-0.5; maxy=10.5; % Da la dimensiones del
    % cuadro de dibujo
    
    for k=1:length(v) % Iteracion por cada posicion
        hold on
        axis([minx maxx miny maxy]); axis('equal'); axis('manual');
        % Barra Arriba
        patch([0 5],[h(k) h(k)],'b','EdgeColor','b','LineWidth',3); % Hay
        % que meterle dos vectores, el primero con las coordenadas x y el
        % segundo con las coordenadas y. Luego une estos dos puntos
        % Barra Abajo
        patch([0 5],[0 0],'b','EdgeColor','b','LineWidth',3);
        % Lateral izquierdo
        patch([0 0],[0 10],'b','EdgeColor','b','LineWidth',3);
        % Lateral derecho
        patch([5 5],[0 10],'b','EdgeColor','b','LineWidth',3);
        
        pause(0.000001); % Velocidad de actualizado
        if k<length(v);
            clf; % Limpia el dibujo
        end
    end
    
elseif (geometria == 2)
    
    % Inicializar Cono
    
    V = pi*2.5^2*h/3;
    t = 0;
    i = 1;
    k = (pi*r^2)*1;
    dt = 60;
    p = 0.75;
    j = 1;
    
    % Operaciones Cono
    
    while(V(i)>0)
        
        v(i) = sqrt(2*g*h(i));
        q(i) = v(i)*k;
        V(i+1) = V(i)-q(i)*dt;
        
        % Observación: Cálculo de la altura restante
        % El cálculo de la altura de líquido restante en un instante
        % siguiete o i+1 lo he llevado a cabo por medio de semejanza de
        % triángulos obteniendo así la siguiente ecuación.
        
        % Resolvemos la ecuación de la altura
        
        h(i+1) = (3*V(i+1)/(pi*(2.5/10)^2))^(1/3);
        
        t(i+1) = t(i)+dt;
        if(V(i+1)<p*V(1))
            tp(j) = (t(i+1))/60;
            p = p-0.25;
            j = j+1;
        end
        i = i+1;
    end
    
    Vp = V(1)*[0.75 0.5 0.25 0];
    
    % Dibujar Cono
    figure(2)
    plot(t/60,V)
    title('Vaciado del Depósito Cónico')
    xlabel('Tiempo (min)'); ylabel('Volumen (m^3)')
    hold on;
    
    % Simular vaciado del Cono en 2D
    
    figure(1)
    minx=-0.5; maxx=5.5; miny=-0.5; maxy=10.5; % Da la dimensiones del
    % cuadro de dibujo
    
    for k=1:length(h)-1 % Iteracion por cada posicion
        hold on
        axis([minx maxx miny maxy]); axis('equal'); axis('manual');
        % Barra Arriba
        % Hay que meterle dos vectores, el primero con las coordenadas x
        % y el segundo con las coordenadas y, luego une estos dos puntos
        patch([2.5-0.25*h(k) 0.25*h(k)+2.5],[h(k) h(k)],'b','EdgeColor','b','LineWidth',3);
        % Lateral izquierdo
        patch([2.5 0],[0 10],'b','EdgeColor','b','LineWidth',3);
        % Lateral derecho
        patch([2.5 5],[0 10],'b','EdgeColor','b','LineWidth',3);
        
        pause(0.1); % Velocidad de actualizado
        if k<length(h);
            
            clf; % Limpia el dibujo
        end
    end
    
elseif (geometria == 3)
    
    % Inicializar Esfera
    
    V = 4/3*pi*5^3;
    t = 0;
    i = 1;
    k = (pi*r^2)*1;
    dt = 60;
    p = 0.75;
    j = 1;
    
    % Operaciones Esfera
    
    while(V(i)>0)
        
        v(i) = sqrt(2*g*h(i));
        q(i) = v(i)*k;
        V(i+1) = V(i)-q(i)*dt;
        
        % Observación: Cálculo de la altura
        % El cálculo de la altura de líquido restante en un instante
        % siguiete o i+1 es algo más complejo en el caso de la esfera.
        % Para dicho cálculo me he basado en la definición del Volumen
        % como la integral definida entre h y -R de una superficie
        % (pi*r^2) por diferencial de 'y' (dy). Por medio de pitágoras,
        % puedo deducir que cuando la esfera esté al 50% de capacidad
        % entonces r^2+y^ = R^2 de dónde puedo despejar r^2 para
        % obtener que r^2 = R^2-y^2. Sustituyendo esta expresión en la
        % integral, operando y simplificando, obtengo la ecuación de la
        % cual poder despejar la nueva altura pero debido a que dicho
        % procedimiento es muy complejo y no he podido obtenerlo, he
        % utilizado las líneas de código facilitadas por los profesores
        % de la asignatura para tal fin.
        
        % Así pues, lo que hacemos con el comando fzero es buscar los
        % ceros de la función esfera, que previamente definimos, en el
        % intervalo [0,10] (tomando que 0 es la base de la esfera y 10 la
        % altura máxima de la misma) pudiendo así diferenciar si en algún
        % punto de dicho intervalo hay diferencia de signo, si la hay
        % busca dónde está para obtener así la nueva altura.
        
        % Resolvemos la ecuación de la altura
        
        esfera = @(h) pi/3*(15*h^2-h^3)-V(i);
        h(i+1) = fzero(esfera,[0,10]);
        t(i+1) = t(i)+dt;
        if(V(i+1)<p*V(1))
            tp(j) = (t(i+1))/60;
            p = p-0.25;
            j = j+1;
        end
        i = i+1;
    end
    
    Vp = V(1)*[0.75 0.5 0.25 0];
    
    % Dibujar Esfera
    
    figure(2)
    plot(t/60,V)
    title('Vaciado del Depósito Esférico')
    xlabel('Tiempo (min)'); ylabel('Volumen (m^3)')
    hold on;
    
    % Simular vaciado de la Esfera en 2D
    
    figure(1)
    minx=-5.5; maxx=5.5; miny=-5.5; maxy=5.5; % Da la dimensiones del 
    % cuadro de dibujo
    t = (0:0.01:1)'*2*pi;
    x = 5*sin(t);
    y = 5*cos(t);
    for k=1:length(h) % Iteracion por cada posicion (cada 30 para que 
        % vaya más rapido)
        hold on
        axis([minx maxx miny maxy]); axis('equal');
       
        % Dibujamos la esfera en 2-D
        plot(x,y,'b','LineWidth',3)
        
        % Barra Arriba
        % Hay que meterle dos vectores, el primero con las coordenadas x 
        % y el segundo con las coordenadas y, luego une estos dos puntos
        patch([-((abs(25-(h(k)-5).^2)).^(1/2)) (abs(25-(h(k)-5).^2)).^(1/2)],[h(k)-5 h(k)-5],'b','EdgeColor','b','LineWidth',3); 
        
        pause(0.00001); % Velocidad de actualizado
        if k<length(h);
            clf; % Limpia el dibujo
        end
    end
end
return