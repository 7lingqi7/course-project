function Your_Strategy = Your_Strategies(counterparty_previous_action)
     % Count the number of betrayals and denoted by k
     k = length (find(counterparty_previous_action == 1));

     % Count the trade times 
     n = length (counterparty_previous_action)

     % Estimate the probability of counterparty betrayal
     counterparty_betray_estimated = (k + 1) / (n + 2); % The conclusion of example 7 "p = (k+1) / (n+2)"
       
     % The strategy
     if counterparty_betray_estimated > 0.5
       Your_Strategy = 1; % reject
     else
       Your_Strategy = 0; % trust
     end
end


