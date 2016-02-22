# Implement a method #stock_picker that takes in an array of stock prices, one for each hypothetical day.
# It should return a pair of days representing the best day to buy and the best day to sell. Days start at 0.

def stock_picker(prices)

    buy = 0
    sell = prices.length - 1
    spread = []
    i = 1

    while i < prices.length

        curr_diff = prices[sell] - prices[buy]

        if prices[i] <= prices[buy] && i < sell && prices[sell] - prices[i] >= curr_diff
            buy = i
        end

        if prices[i] >= prices[sell] && i > buy && prices[i] - prices[buy] >= curr_diff
            sell = i
        end

        i += 1    
    end

    spread << buy << sell
    return spread

end

prices = [17,3,6,9,15,8,6,1,10]

days_picked = stock_picker(prices)

puts "The best buy day: #{days_picked[0]}."
puts "The best sell day: #{days_picked[1]}."
puts "Calculated profit: $#{prices[days_picked[1]] - prices[days_picked[0]]}."
