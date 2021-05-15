function realQ = realQCalc(neutralQ)

    realQ = neutralQ;
    realQ(3) = realQ(3) - pi/2 + realQ(2);

end

