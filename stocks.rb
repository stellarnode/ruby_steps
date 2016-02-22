# Implement a method #stock_picker that takes in an array of stock prices, one for each hypothetical day.
# It should return a pair of days representing the best day to buy and the best day to sell. Days start at 0.

def stock_picker(prices)

    buy = 0
    sell = prices.length - 1
    spread = []
    i = 1

    while i < prices.length
        if prices[i] > prices[sell] && sell > buy
            sell = i
        end
        
        if prices[i] < prices[buy] && i < sell
            buy = i
        end

        i += 1    
    end

    spread << buy << sell
    return spread

end

puts stock_picker([17,3,6,9,15,8,6,1,10])
