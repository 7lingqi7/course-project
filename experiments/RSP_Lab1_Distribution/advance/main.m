clear;
clc;
warning off;

% Initialize parameters
N_trades = 100;  % Number of trades
test_times = 1000;  % Number of independent trials
Return_total_list = [];  % List to record returns from each trial
predict_probability_p_list = [];  % List to store predicted probabilities
probability_p_list = [];  % List to store actual probabilities

% Loop over the number of trials
for test_number = 1:test_times
    % Randomly initialize the probability of betrayal by the counterparty
    counterparty_betray_prob = rand(1);
    % Create the 10 previous actions
    counterparty_previous_action_list = rand(10, 1);
    counterparty_previous_action = double(counterparty_betray_prob > counterparty_previous_action_list);
    Return_total = 0;  % Initialize the total return for this trial

    % Loop over the number of trades
    for n_trade = 1:N_trades
        disp(['Trade Number: ', num2str(n_trade)]);  % Display current trade number

        % Determine strategy and counterparty's action
        Your_Strategy = Your_Strategies(counterparty_previous_action);
        counterparty_action = double(counterparty_betray_prob > rand(1));
        
        % Calculate the return based on the actions
        if Your_Strategy == 0
            if counterparty_action == 0
                Return_current = 10;  % Both trust
            else
                Return_current = -10; % You trust, they betray
            end
        else
            if counterparty_action == 0
                Return_current = -10; % You call police, they trust
            else
                Return_current = 10;  % Both betray
            end
        end
        
        % Update the total return and previous actions
        Return_total = Return_total + Return_current;
        counterparty_previous_action(end+1) = counterparty_action; % Update actions
    end
    
    % Store the results of this trial
    Return_total_list(end+1) = Return_total;
    predict_probability_p_list(end+1) = Your_Strategy;  % Assuming Your_Strategies returns a probability
    probability_p_list(end+1) = counterparty_betray_prob;
end

% Calculate statistics on the returns
Return_total_mean = mean(Return_total_list);
Return_total_var = std(Return_total_list);

% Visualization of the returns for each trial
figure(1);
scatter(1:test_times, Return_total_list, 2);
title('Return for each independent trade time');
xlabel('Trade time');
ylabel('Return');
ylim([-250, 1050]);
set(figure(1), 'Position', [300, 300, 1400, 400]);

% Histogram of the returns
figure(2);
histogram(Return_total_list, 'NumBins', 1200);
title('Return statistics for 1000 independent trials');
xlabel('Return');
ylabel('Number of occurrences for corresponding return');
legend('Return total list');
