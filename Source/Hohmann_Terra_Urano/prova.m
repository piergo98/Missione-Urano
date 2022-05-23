TOF_Hohmann;
Data_iniziale = 01/01/2022;

for 
    data_P = Data_iniziale + i;
    data_A = data_P + TOF_Hohmann;

    [coe_partenza , ~, ~, ~] = planet_elements_and_sv(3, 2022, 07, 01, 12, 00, 00);
    TA_Partenza = rad2deg(coe_partenza(6));

    [coe_arrivo, ~, ~, ~] = planet_elements_and_sv(7, 2022, 07, 01, 12, 00, 00);
    TA_Arrivo = rad2deg(coe_arrivo(6));

    if(TA_Arrivo == TA_partenza + 180)
        Data_Giusta = data_P;
    end

end