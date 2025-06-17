% Print your student ID and Name here, for example
% 2022110131    Zuyi Liao
%%
% your_strategy returns your strategy of the trade this time
% your_strategy = 0 means that you want to trust the counterparty this time
% your_strategy not equal to 0 means that you want to betray the
% counterparty this time 
%%
% counterparty_id is the ID of the counterparty you are going to trade with
% this time
function [your_strategy] = id3(counterparty_id) 
    if counterparty_id>15  % trust the id that smaller than 15
        your_strategy = 0;
    else
        your_strategy = 1;
end